cwlVersion: v1.1
class: Workflow
label: 'FragPipe: ProteinProphet'
doc: |-
  This workflow step takes the PeptideProphet output files from the first step containing the peptide validation and calculates the protein inference using ProteinProphet.
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement

inputs:
- id: workspace_in
  label: Workspace
  doc: MZML files are optional.
  type:
    type: array
    items: File
  sbg:fileTypes: TAR.GZ
  sbg:x: -381
  sbg:y: -71
- id: minprob
  doc: PeptideProphet probability threshold (default 0.05)
  type:
  - 'null'
  - float
  sbg:exposed: true

outputs:
- id: interact_protein_xml
  type:
  - 'null'
  - File
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
  run: fragpipe-proteinprophet.cwl.steps/philosopher_proteinprophet.cwl
  out:
  - id: interact_protein_xml
  sbg:x: -100
  sbg:y: -96

hints:
- class: sbg:AWSInstanceType
  value: c5.2xlarge;ebs-gp2;200
sbg:appVersion:
- v1.1
sbg:categories:
- Proteomics
sbg:content_hash: a9732c3274149710590c5c3963f5f088ad111cb6ac24893839d6e07a60c7f185c
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618977888
sbg:id: |-
  david.roberson/build-fragpipe-proteomics-pipeline-tutorial/fragPipe-proteinprophet/0
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/fragPipe-proteinprophet/0.png
sbg:latestRevision: 0
sbg:links:
- id: https://fragpipe.nesvilab.org/
  label: fragpipe.nesvilab.org
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618977888
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/fragPipe-proteinprophet/0/raw/
sbg:project: david.roberson/build-fragpipe-proteomics-pipeline-tutorial
sbg:projectName: 'BUILD: FragPipe Proteomics Pipeline Tutorial'
sbg:publisher: sbg
sbg:revision: 0
sbg:revisionNotes: |-
  Uploaded using sbpack v2020.10.05. 
  Source: 
  repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
  file: 
  commit: (uncommitted file)
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618977888
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: 
    commit: (uncommitted file)
sbg:sbgMaintained: false
sbg:toolAuthor: Felipe da Veiga Leprevost
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
sbg:wrapperAuthor: Felipe da Veiga Leprevost; Dave Roberson
