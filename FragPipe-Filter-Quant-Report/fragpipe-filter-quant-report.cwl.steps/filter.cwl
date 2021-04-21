cwlVersion: v1.1
class: CommandLineTool
label: Philosopher Filter
doc: |-
  ```
  Statistical filtering, validation and False Discovery Rates assessment

  Usage:
    philosopher filter [flags]

  Flags:
        --2d               two-dimensional FDR filtering
    -h, --help             help for filter
        --inference        extremely fast and efficient protein inference compatible with 2D and Sequential filters
        --ion float        peptide ion FDR level (default 0.01)
        --mapmods          map modifications
        --models           print model distribution
        --pep float        peptide FDR level (default 0.01)
        --pepProb float    top peptide probability threshold for the FDR filtering (default 0.7)
        --pepxml string    pepXML file or directory containing a set of pepXML files
        --picked           apply the picked FDR algorithm before the protein scoring
        --prot float       protein FDR level (default 0.01)
        --protProb float   protein probability threshold for the FDR filtering (not used with the razor algorithm) (default 0.5)
        --protxml string   protXML file path
        --psm float        psm FDR level (default 0.01)
        --razor            use razor peptides for protein FDR scoring
        --sequential       alternative algorithm that estimates FDR using both filtered PSM and protein lists
        --tag string       decoy tag (default "rev_")
        --weight float     threshold for defining peptide uniqueness (default 1)

  ```
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: LoadListingRequirement
- class: ResourceRequirement
  coresMin: 0
  ramMin: 8000
- class: DockerRequirement
  dockerPull: prvst/philosopher:latest
- class: InitialWorkDirRequirement
  listing:
  - entryname: philosopher_filter.sh
    writable: false
    entry: |+
      tar -xvzf $(inputs.workspace_in.path) -C ./

      cd $(inputs.workspace_in.metadata["Plex or dataset name"])

      philosopher filter --pepxml ./ $@


- class: InlineJavascriptRequirement

inputs:
- id: 2d
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --2d
    position: 0
    shellQuote: false
- id: inference
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --inference
    position: 1
    shellQuote: false
- id: ion
  doc: peptide ion FDR level (default 0.01)
  type:
  - 'null'
  - float
  default: 0.01
  inputBinding:
    prefix: --ion
    position: 2
    shellQuote: false
- id: mapmods
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --mapmods
    position: 3
    shellQuote: false
- id: models
  doc: print model distribution
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --models
    position: 4
    shellQuote: false
- id: pep
  doc: peptide FDR level (default 0.01)
  type:
  - 'null'
  - float
  default: 0.01
  inputBinding:
    prefix: --pep
    position: 5
    shellQuote: false
- id: pepProb
  doc: top peptide probability threshold for the FDR filtering (default 0.7)
  type:
  - 'null'
  - float
  default: 0.7
  inputBinding:
    prefix: --pepProb
    position: 6
    shellQuote: false
- id: picked
  doc: apply the picked FDR algorithm before the protein scoring
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --picked
    position: 8
    shellQuote: false
- id: prot
  doc: protein FDR level
  type:
  - 'null'
  - float
  default: 0.05
  inputBinding:
    prefix: --prot
    position: 9
    shellQuote: false
  sbg:toolDefaultValue: '0.05'
- id: protProb
  doc: |-
    protein probability threshold for the FDR filtering (not used with the razor algorithm) (default 0.5)
  type:
  - 'null'
  - float
  default: 0.05
  inputBinding:
    prefix: --protProb
    position: 10
    shellQuote: false
- id: protxml
  doc: protXML file path
  type: File
  inputBinding:
    prefix: --protxml
    position: 11
    shellQuote: false
- id: psm
  doc: psm FDR level (default 0.01)
  type:
  - 'null'
  - float
  default: 0.01
  inputBinding:
    prefix: --psm
    position: 12
    shellQuote: false
- id: razor
  doc: use razor peptides for protein FDR scoring
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --razor
    position: 13
    shellQuote: false
- id: sequential
  doc: |-
    alternative algorithm that estimates FDR using both filtered PSM and protein lists
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --sequential
    position: 14
    shellQuote: false
- id: tag
  doc: decoy tag (default "rev_")
  type:
  - 'null'
  - string
  default: rev_
  inputBinding:
    prefix: --tag
    position: 15
    shellQuote: false
- id: weight
  doc: threshold for defining peptide uniqueness (default 1)
  type:
  - 'null'
  - float
  default: 1
  inputBinding:
    prefix: --weight
    position: 16
    shellQuote: false
- id: workspace_in
  type: File

outputs:
- id: workspace_out
  type: Directory
  outputBinding:
    glob: $(inputs.workspace_in.metadata["Plex or dataset name"])
    loadListing: no_listing
stdout: filter.log

baseCommand:
- bash philosopher_filter.sh

hints:
- class: sbg:SaveLogs
  value: '*.sh'
- class: sbg:SaveLogs
  value: '*.log'
id: david.roberson/pdc-webinar-devl-2/filter/13
sbg:appVersion:
- v1.1
sbg:content_hash: a2444b2d0f9cc6f9926eaafb450df16b65f37100a373ac10578409be1643dd8e9
sbg:contributors:
- prvst
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1617710972
sbg:id: david.roberson/pdc-webinar-devl-2/filter/13
sbg:image_url:
sbg:latestRevision: 13
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618487126
sbg:project: david.roberson/pdc-webinar-devl-2
sbg:projectName: PDC Webinar Devl 2
sbg:publisher: sbg
sbg:revision: 13
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617710972
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: 
    commit: (uncommitted file)
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617711027
  sbg:revision: 1
  sbg:revisionNotes: tar c is not compressing now
- sbg:modifiedBy: prvst
  sbg:modifiedOn: 1617718272
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617947732
  sbg:revision: 3
  sbg:revisionNotes: added dir output
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617949777
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617950053
  sbg:revision: 5
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618461563
  sbg:revision: 6
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618461822
  sbg:revision: 7
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618463165
  sbg:revision: 8
  sbg:revisionNotes: corrected default
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618463325
  sbg:revision: 9
  sbg:revisionNotes: tar not compressing and fix default prot
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618463841
  sbg:revision: 10
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618464080
  sbg:revision: 11
  sbg:revisionNotes: required prot
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618485757
  sbg:revision: 12
  sbg:revisionNotes: dir is now output
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618487126
  sbg:revision: 13
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
