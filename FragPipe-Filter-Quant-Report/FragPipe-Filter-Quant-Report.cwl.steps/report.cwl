cwlVersion: v1.1
class: CommandLineTool
label: Philosopher Report
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: LoadListingRequirement
- class: ResourceRequirement
  coresMin: 0
  ramMin: 2000
- class: DockerRequirement
  dockerPull: prvst/philosopher:latest
- class: InitialWorkDirRequirement
  listing:
  - entryname: philosopher_report.sh
    writable: false
    entry: |
      ln -s $(inputs.workspace_in.path) ./

      cd $(inputs.workspace_in.basename)

      philosopher report $@

      cd ../

      mkdir report_files

      #peptide.tsv
      cp $(inputs.workspace_in.basename)/peptide.tsv report_files/$(inputs.workspace_in.basename)_peptide.tsv

      #ion.tsv
      cp $(inputs.workspace_in.basename)/ion.tsv report_files/$(inputs.workspace_in.basename)_ion.tsv

      #protein.tsv
      cp $(inputs.workspace_in.basename)/protein.tsv report_files/$(inputs.workspace_in.basename)_protein.tsv

      #psm.tsv
      cp $(inputs.workspace_in.basename)/psm.tsv report_files/$(inputs.workspace_in.basename)_psm.tsv
  - $(inputs.interact_protein_xml)
- class: InlineJavascriptRequirement
  expressionLib:
  - |2-

    var setMetadata = function(file, metadata) {
        if (!('metadata' in file)) {
            file['metadata'] = {}
        }
        for (var key in metadata) {
            file['metadata'][key] = metadata[key];
        }
        return file
    };
    var inheritMetadata = function(o1, o2) {
        var commonMetadata = {};
        if (!o2) {
            return o1;
        };
        if (!Array.isArray(o2)) {
            o2 = [o2]
        }
        for (var i = 0; i < o2.length; i++) {
            var example = o2[i]['metadata'];
            for (var key in example) {
                if (i == 0)
                    commonMetadata[key] = example[key];
                else {
                    if (!(commonMetadata[key] == example[key])) {
                        delete commonMetadata[key]
                    }
                }
            }
            for (var key in commonMetadata) {
                if (!(key in example)) {
                    delete commonMetadata[key]
                }
            }
        }
        if (!Array.isArray(o1)) {
            o1 = setMetadata(o1, commonMetadata)
            if (o1.secondaryFiles) {
                o1.secondaryFiles = inheritMetadata(o1.secondaryFiles, o2)
            }
        } else {
            for (var i = 0; i < o1.length; i++) {
                o1[i] = setMetadata(o1[i], commonMetadata)
                if (o1[i].secondaryFiles) {
                    o1[i].secondaryFiles = inheritMetadata(o1[i].secondaryFiles, o2)
                }
            }
        }
        return o1;
    };

inputs:
- id: decoys
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --decoys
    position: 0
    shellQuote: false
- id: msstats
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --msstats
    position: 1
    shellQuote: false
- id: mzid
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --mzid
    position: 2
    shellQuote: false
- id: workspace_in
  type: Directory
  loadListing: deep_listing
- id: interact_protein_xml
  type: File

outputs:
- id: report_outputs
  type:
  - 'null'
  - type: array
    items: File
  outputBinding:
    glob: 'report_files/* '
    outputEval: $(inheritMetadata(self, inputs.workspace_in))

baseCommand:
- bash philosopher_report.sh

hints:
- class: sbg:SaveLogs
  value: '*.sh'
id: david.roberson/pdc-webinar-devl-2/report/1
sbg:appVersion:
- v1.1
sbg:content_hash: a8b7aa718d70539999d8ef152cb2958106d15456ac257d49277c1ccccfdf0710b
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618471798
sbg:id: david.roberson/pdc-webinar-devl-2/report/1
sbg:image_url:
sbg:latestRevision: 1
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618472791
sbg:project: david.roberson/pdc-webinar-devl-2
sbg:projectName: PDC Webinar Devl 2
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618471798
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: filter_quant_report.steps/report.cwl
    commit: 3bc2af0
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618472791
  sbg:revision: 1
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
