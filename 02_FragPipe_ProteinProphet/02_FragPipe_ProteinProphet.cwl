cwlVersion: v1.1
class: Workflow
label: '02 FragPipe: ProteinProphet'
doc: |-
  This workflow step takes the PeptideProphet output files from the first step containing the peptide validation and calculates the protein inference using ProteinProphet.
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement

inputs:
- id: workspace_in
  label: Workspace
  doc: MZML files are optional.
  type: File[]
  sbg:fileTypes: TAR.GZ
  sbg:x: -381
  sbg:y: -71
- id: minprob
  doc: PeptideProphet probability threshold (default 0.05)
  type: float?
  sbg:exposed: true

outputs:
- id: interact_protein_xml
  type: File?
  outputSource:
  - philosopher_proteinprophet/interact_protein_xml
  sbg:x: 191.3680877685547
  sbg:y: -100.5

steps:
- id: philosopher_proteinprophet
  label: Philosopher ProteinProphet
  in:
  - id: minprob
    default: 0.5
    source: minprob
  - id: workspace_in
    source:
    - workspace_in
  run: 02_FragPipe_ProteinProphet.cwl.steps/philosopher_proteinprophet.cwl
  out:
  - id: interact_protein_xml
  sbg:x: -100
  sbg:y: -96

hints:
- class: sbg:AWSInstanceType
  value: c5.2xlarge;ebs-gp2;200
sbg:appVersion:
- v1.1
sbg:content_hash: ae42bb04afc20206bee6facb7ad2fdcd36b5745d9f77ae66bf1bd2442bfd6be40
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618420225
sbg:id: david.roberson/pdc-workshop/protein-prophet-wf/5
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/pdc-workshop/protein-prophet-wf/5.png
sbg:latestRevision: 5
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618799247
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/pdc-workshop/protein-prophet-wf/5/raw/
sbg:project: david.roberson/pdc-workshop
sbg:projectName: PDC Workshop and Public Project Dev
sbg:publisher: sbg
sbg:revision: 5
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618420225
  sbg:revision: 0
  sbg:revisionNotes: Copy of david.roberson/pdc-webinar-devl-2/protein-prophet-wf/3
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618421429
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618497559
  sbg:revision: 2
  sbg:revisionNotes: c5.2xlarge 200GB
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618597760
  sbg:revision: 3
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618601011
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618799247
  sbg:revision: 5
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
