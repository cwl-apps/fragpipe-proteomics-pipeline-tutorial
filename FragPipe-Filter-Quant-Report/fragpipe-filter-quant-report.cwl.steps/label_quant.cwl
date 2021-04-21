cwlVersion: v1.1
class: CommandLineTool
label: Philosopher Labelquant
doc: "Wiki    \n\nhttps://github.com/Nesvilab/philosopher/wiki/Labelquant"
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
  - entryname: philosopher_labelquant.sh
    writable: false
    entry: |-
      cp -al $(inputs.workspace_in.path) $(inputs.workspace_in.basename)

      cd $(inputs.workspace_in.basename)

      philosopher labelquant $@ --dir ./
- class: InlineJavascriptRequirement

inputs:
- id: bestpsm
  doc: select the best PSMs for protein quantification
  type:
  - 'null'
  - boolean
  default: true
  inputBinding:
    prefix: --bestpsm
    position: 1
    shellQuote: false
- id: brand
  doc: isobaric labeling brand (tmt, itraq)
  type:
  - 'null'
  - string
  default: tmt
  inputBinding:
    prefix: --brand
    position: 2
    shellQuote: false
- id: level
  doc: ms level for the quantification (default 2)
  type:
  - 'null'
  - int
  default: 2
  inputBinding:
    prefix: --level
    position: 4
    shellQuote: false
- id: minprob
  doc: only use PSMs with the specified minimum probability score (default 0.7)
  type:
  - 'null'
  - float
  default: 0.7
  inputBinding:
    prefix: --minprob
    position: 5
    shellQuote: false
- id: plex
  doc: number of reporter ion channels
  type:
  - 'null'
  - int
  default: 10
  inputBinding:
    prefix: --plex
    position: 6
    shellQuote: false
- id: purity
  doc: ion purity threshold (default 0.5)
  type:
  - 'null'
  - float
  default: 0.5
  inputBinding:
    prefix: --purity
    position: 7
    shellQuote: false
- id: removelow
  doc: |-
    ignore the lower % of PSMs based on their summed abundances. 0 means no removal, entry value must be a decimal
  type:
  - 'null'
  - float
  default: 0.03
  inputBinding:
    prefix: --removelow
    position: 8
    shellQuote: false
- id: tol
  doc: m/z tolerance in ppm (default 20)
  type:
  - 'null'
  - float
  default: 20
  inputBinding:
    prefix: --tol
    position: 9
    shellQuote: false
- id: uniqueonly
  doc: report quantification based only on unique peptides
  type:
  - 'null'
  - boolean
  default: true
  inputBinding:
    prefix: --uniqueonly
    position: 9
    shellQuote: false
- id: workspace_in
  type: Directory
  loadListing: no_listing
- id: annotation
  doc: Replaces channel numbers with sample names.  TXT file with two columns.
  type:
  - 'null'
  - File
  inputBinding:
    prefix: --annot
    position: 0
    shellQuote: false
  sbg:fileTypes: TXT

outputs:
- id: workspace_out
  type: Directory
  outputBinding:
    glob: $(inputs.workspace_in.basename)
    loadListing: no_listing
stdout: label_quant.log

baseCommand:
- bash
- philosopher_labelquant.sh

hints:
- class: sbg:SaveLogs
  value: '*.sh'
- class: sbg:SaveLogs
  value: '*.log'
id: david.roberson/pdc-webinar-devl-2/label_quant/10
sbg:appVersion:
- v1.1
sbg:content_hash: a71d550793b0512df039f419077a61c5e7242790b79a212c11c5fcf5463120a29
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618461420
sbg:id: david.roberson/pdc-webinar-devl-2/label_quant/10
sbg:image_url:
sbg:latestRevision: 10
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618487188
sbg:project: david.roberson/pdc-webinar-devl-2
sbg:projectName: PDC Webinar Devl 2
sbg:publisher: sbg
sbg:revision: 10
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618461420
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: filter_quant_and_report_wf.cwl.steps/philosopher_labelquant.cwl
    commit: 3bc2af0
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618463937
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618464136
  sbg:revision: 2
  sbg:revisionNotes: required workspace in
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618464361
  sbg:revision: 3
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: filter_quant_report.steps/labelquant.cwl
    commit: 3bc2af0
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618464757
  sbg:revision: 4
  sbg:revisionNotes: tar output
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618467379
  sbg:revision: 5
  sbg:revisionNotes: added std out log
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618468863
  sbg:revision: 6
  sbg:revisionNotes: symbolic link
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618470696
  sbg:revision: 7
  sbg:revisionNotes: dir output
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618486222
  sbg:revision: 8
  sbg:revisionNotes: input is dir
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618486241
  sbg:revision: 9
  sbg:revisionNotes: input is dir
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618487188
  sbg:revision: 10
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:validationErrors: []
