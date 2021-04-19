cwlVersion: v1.1
class: CommandLineTool
label: Philosopher Freequant
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
  - entryname: philosopher_freequant.sh
    writable: false
    entry: |-
      cp -al $(inputs.workspace_in.path) $(inputs.workspace_in.basename)

      cd $(inputs.workspace_in.basename)

      philosopher freequant $@ --dir ./
- class: InlineJavascriptRequirement

inputs:
- id: isolated
  doc: use the isolated ion instead of the selected ion for quantification
  type: boolean?
  default: true
  inputBinding:
    prefix: --isolated
    position: 1
    shellQuote: false
- id: ptw
  doc: specify the time windows for the peak (minute) (default 0.4)
  type: float?
  default: 0.4
  inputBinding:
    prefix: --ptw
    position: 2
    shellQuote: false
- id: tol
  doc: m/z tolerance in ppm (default 10)
  type: int?
  inputBinding:
    prefix: --tol
    position: 3
    shellQuote: false
- id: workspace_in
  type: Directory
  loadListing: no_listing

outputs:
- id: workspace_out
  type: Directory?
  outputBinding:
    glob: $(inputs.workspace_in.basename)
    loadListing: no_listing
stdout: freequant.log

baseCommand:
- bash philosopher_freequant.sh

hints:
- class: sbg:SaveLogs
  value: '*.sh'
- class: sbg:SaveLogs
  value: '*.log'
id: david.roberson/pdc-webinar-devl-2/freequant/8
sbg:appVersion:
- v1.1
sbg:content_hash: aa5242f1adf59cef34d1090a1326bafb3b0148d33f20d9ae8f9dfa62797902bfd
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618469027
sbg:id: david.roberson/pdc-webinar-devl-2/freequant/8
sbg:image_url:
sbg:latestRevision: 8
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618476401
sbg:project: david.roberson/pdc-webinar-devl-2
sbg:projectName: PDC Webinar Devl 2
sbg:publisher: sbg
sbg:revision: 8
sbg:revisionNotes: cp
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618469027
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/shotgun_proteomics.git
    file: filter_quant_report.steps/freequant.cwl
    commit: 3bc2af0
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618469361
  sbg:revision: 1
  sbg:revisionNotes: symlink
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618470973
  sbg:revision: 2
  sbg:revisionNotes: dir in and out
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618470989
  sbg:revision: 3
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618473482
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618474638
  sbg:revision: 5
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618475546
  sbg:revision: 6
  sbg:revisionNotes: hardlink
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618475829
  sbg:revision: 7
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618476401
  sbg:revision: 8
  sbg:revisionNotes: cp
sbg:sbgMaintained: false
sbg:validationErrors: []
