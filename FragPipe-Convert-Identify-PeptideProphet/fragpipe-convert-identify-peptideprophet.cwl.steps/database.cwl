cwlVersion: v1.1
class: CommandLineTool
label: Philosopher Database
doc: |-
  ```
  Usage:
    philosopher database [flags]

  Flags:
        --add string        add custom sequences (UniProt FASTA format only)
        --annotate string   process a ready-to-use database
        --contam            add common contaminants
        --custom string     use a pre-formatted custom database
        --enzyme string     enzyme for digestion (trypsin, lys_c, lys_n, glu_c, chymotrypsin) (default "trypsin")
    -h, --help              help for database
        --id string         UniProt proteome ID
        --isoform           add isoform sequences
        --nodecoys          don't add decoys to the database
  ```
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: ResourceRequirement
  coresMin: 0
  ramMin: 2000
- class: DockerRequirement
  dockerPull: prvst/philosopher:3.2.3
- class: InitialWorkDirRequirement
  listing:
  - entryname: philosopher_database.sh
    writable: false
    entry: |-
      tar -xvzf $(inputs.workspace_in.path) -C ./

      cd $(inputs.workspace_in.metadata["Plex or dataset name"])

      philosopher database $@

      cd ../

      tar -cvzf $(inputs.workspace_in.metadata["Plex or dataset name"]).tar.gz $(inputs.workspace_in.metadata["Plex or dataset name"])
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
- id: add
  doc: add custom sequences (UniProt FASTA format only)
  type:
  - 'null'
  - string
  default:
  inputBinding:
    prefix: --add
    position: 0
    shellQuote: false
- id: annotate
  doc: process a ready-to-use database
  type:
  - 'null'
  - File
  inputBinding:
    prefix: --annotate
    position: 1
    shellQuote: false
- id: contam
  doc: add common contaminants
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --contam
    position: 3
    shellQuote: false
- id: custom
  doc: use a pre-formatted custom database
  type:
  - 'null'
  - string
  inputBinding:
    prefix: --custom
    position: 0
    shellQuote: false
- id: enzyme
  doc: |-
    enzyme for digestion (trypsin, lys_c, lys_n, glu_c, chymotrypsin) (default "trypsin")
  type:
  - 'null'
  - string
  default: trypsin
  inputBinding:
    prefix: --enzyme
    position: 5
    shellQuote: false
- id: id
  doc: UniProt proteome ID
  type:
  - 'null'
  - string
  inputBinding:
    prefix: --id
    position: 6
    shellQuote: false
- id: isoform
  doc: add isoform sequences
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --isoform
    position: 7
    shellQuote: false
- id: nodecoys
  doc: don't add decoys to the database
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --nodecoys
    position: 8
    shellQuote: false
- id: prefix
  type:
  - 'null'
  - string
  default: rev_
  inputBinding:
    prefix: --prefix
    position: 9
    shellQuote: false
- id: reviewed
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --reviewed
    position: 10
    shellQuote: false
- id: workspace_in
  type: File
  inputBinding:
    position: 0
    shellQuote: false

outputs:
- id: output
  type:
  - 'null'
  - File
  outputBinding:
    glob: std.out
- id: workspace
  type: File
  outputBinding:
    glob: '*.tar.gz'
    outputEval: $(inheritMetadata(self, inputs.workspace_in))
stdout: std.out

baseCommand:
- bash philosopher_database.sh

hints:
- class: sbg:SaveLogs
  value: '*.out'
- class: sbg:SaveLogs
  value: '*.sh'
id: david.roberson/pdc-webinar-dev/database/4
sbg:appVersion:
- v1.1
sbg:content_hash: a1963dbc9c0bdb17105f27d6a56a9eb3b9d264aff95433302791a02ab0f542ab2
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1616674914
sbg:id: david.roberson/pdc-webinar-dev/database/4
sbg:image_url:
sbg:latestRevision: 4
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1616679449
sbg:project: david.roberson/pdc-webinar-dev
sbg:projectName: PDC Webinar Dev
sbg:publisher: sbg
sbg:revision: 4
sbg:revisionNotes: inherit metadata
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616674914
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: tools/database/database.cwl
    commit: 31fdf12
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616676112
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616678466
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616679008
  sbg:revision: 3
  sbg:revisionNotes: fixing cd
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1616679449
  sbg:revision: 4
  sbg:revisionNotes: inherit metadata
sbg:sbgMaintained: false
sbg:validationErrors: []
