cwlVersion: v1.1
class: CommandLineTool
label: Philosopher ProteinProphet
doc: |-
  Protein identification validation  
    
  Usage:  
    philosopher proteinprophet [flags]  
    
  Flags:  
    -h, --help             help for proteinprophet  
        --iprophet         input is from iProphet  
        --maxppmdiff int   maximum peptide mass difference in ppm (default 2000000)  
        --minprob float    PeptideProphet probability threshold (default 0.05)  
        --nonsp            do not use NSP model  
        --output string    Output name (default "interact")  
        --unmapped         report results for UNMAPPED proteins
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: ResourceRequirement
  coresMin: 1
  ramMin: 4000
- class: DockerRequirement
  dockerPull: prvst/philosopher:latest
- class: InitialWorkDirRequirement
  listing:
  - entryname: protein_prophet.sh
    writable: false
    entry: |+
      find . -name '*.tar.gz' -execdir tar -xzvf '{}' \;

      echo $@

      philosopher workspace --init &&
      philosopher proteinprophet $@ */interact*.pep.xml


  - $(inputs.workspace_in)
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
- id: iprophet
  doc: input is from iProphet
  type: boolean?
  default:
  inputBinding:
    prefix: --iprophet
    position: 0
    shellQuote: false
- id: maxppmdiff
  doc: maximum peptide mass difference in ppm (default 2000000)
  type: int?
  default: 2000000
  inputBinding:
    prefix: --maxppmdiff
    position: 1
    shellQuote: false
- id: minprob
  doc: PeptideProphet probability threshold (default 0.05)
  type: float?
  default: 0.05
  inputBinding:
    prefix: --minprob
    position: 2
    shellQuote: false
- id: nonsp
  doc: do not use NSP model
  type: boolean?
  inputBinding:
    prefix: --nonsp
    position: 3
    shellQuote: false
- id: output
  doc: Output name (default "interact")
  type: string?
  default: interact
  inputBinding:
    prefix: --output
    position: 4
    shellQuote: false
- id: unmapped
  doc: report results for UNMAPPED proteins
  type: boolean?
  inputBinding:
    prefix: --unmapped
    position: 5
    shellQuote: false
- id: workspace_in
  type: File[]?

outputs:
- id: interact_protein_xml
  type: File?
  outputBinding:
    glob: interact.prot.xml
    outputEval: $(inheritMetadata(self, inputs.workspace_in))

baseCommand:
- bash protein_prophet.sh
id: david.roberson/pdc-webinar-dev/philosopher-proteinprophet/1
sbg:appVersion:
- v1.1
sbg:content_hash: a989acf3fd9302f6fdd10aa641b380db61bfaa2d57ef4752dd32d1988afa8593b
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1616618178
sbg:id: david.roberson/pdc-webinar-dev/philosopher-proteinprophet/1
sbg:image_url:
sbg:latestRevision: 1
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1616619570
sbg:project: david.roberson/pdc-webinar-dev
sbg:projectName: PDC Webinar Dev
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616618178
  sbg:revision: 0
  sbg:revisionNotes: Copy of david.roberson/philosopher-dev/philosopher-proteinprophet/7
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616619570
  sbg:revision: 1
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
