cwlVersion: v1.1
class: CommandLineTool
label: Philosopher Workspace
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: LoadListingRequirement
- class: ResourceRequirement
  coresMin: 1
  ramMin: 100
- class: DockerRequirement
  dockerPull: prvst/philosopher:3.2.3
- class: InitialWorkDirRequirement
  listing:
  - $(inputs.pepXML)
  - entryname: philosopher_workspace.sh
    writable: false
    entry: |2-

      mkdir $(inputs.meta_data_files[0].metadata["Plex or dataset name"])

      cd $(inputs.meta_data_files[0].metadata["Plex or dataset name"])

      philosopher workspace $@

      cd ../

      tar -cvzf $(inputs.meta_data_files[0].metadata["Plex or dataset name"]).tar.gz $(inputs.meta_data_files[0].metadata["Plex or dataset name"])
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
- id: init
  doc: Initialize the workspace
  type:
  - 'null'
  - boolean
  default:
  inputBinding:
    prefix: --init
    position: 1
    shellQuote: false
- id: analytics
  doc: reports when a workspace is created for usage estimation (default true)
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --analytics
    position: 1
    shellQuote: false
- id: backup
  doc: create a backup of the experiment meta data
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --backup
    position: 1
    shellQuote: false
- id: clean
  doc: remove the workspace and all meta data. Experimental file are kept intact
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --clean
    position: 1
    shellQuote: false
- id: nocheck
  doc: do not check for new versions
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --nocheck
    position: 1
    shellQuote: false
- id: meta_data_files
  type:
    type: array
    items: File
  inputBinding:
    position: 0
    valueFrom: ./$(self[0].metadata["Plex or dataset name"])
    shellQuote: false

outputs:
- id: workspace
  type:
  - 'null'
  - File
  outputBinding:
    glob: '*.tar.gz'
    outputEval: $(inheritMetadata(self, inputs.meta_data_files))
stdout: std.out

baseCommand:
- bash philosopher_workspace.sh

hints:
- class: sbg:SaveLogs
  value: '*.sh'
- class: sbg:SaveLogs
  value: std.out
id: david.roberson/pdc-webinar-dev/workspace/5
sbg:appVersion:
- v1.1
sbg:content_hash: a04c6999346eef832c6aee72c9f54d427ac8f57881e6d5731fd842444398ea973
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1616629639
sbg:id: david.roberson/pdc-webinar-dev/workspace/5
sbg:image_url:
sbg:latestRevision: 5
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1617114475
sbg:project: david.roberson/pdc-webinar-dev
sbg:projectName: PDC Webinar Dev
sbg:publisher: sbg
sbg:revision: 5
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616629639
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: tools/workspace/workspace.cwl
    commit: 31fdf12
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616629985
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616674457
  sbg:revision: 2
  sbg:revisionNotes: added tar
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616674508
  sbg:revision: 3
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616677891
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617114475
  sbg:revision: 5
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
