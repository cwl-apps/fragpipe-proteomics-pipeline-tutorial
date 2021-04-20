cwlVersion: v1.1
class: Workflow
label: 'FragPipe: Filter - Quant - Report'
doc: |-
  This workflow takes the PeptideProphet, and the ProteinProphet output files, and applies a stringent False Discovery Rate (FDR) filtering. Peptide and proteins are filtered individually at 1% FDR. The high-quality PSMs, peptides, and proteins are then quantified using a label-free algorithm that uses the apex peak intensity as a measurement. Finally, the isobaric tags are quantified and annotated with the correct sample labels.
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: LoadListingRequirement
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement
- class: SubworkflowFeatureRequirement

inputs:
- id: protxml
  doc: protXML file path
  type:
  - 'null'
  - File
  sbg:x: 307.5377502441406
  sbg:y: 194.25794982910156
- id: workspace_and_annotation
  label: Workspace and Annotation Files
  type:
    type: array
    items: File
  sbg:fileTypes: TXT, TAR.GZ
  sbg:x: 147.0626678466797
  sbg:y: -3.1828291416168213

outputs:
- id: report_outputs
  type:
  - 'null'
  - type: array
    items: File
  outputSource:
  - report/report_outputs
  sbg:x: 1298.3404541015625
  sbg:y: 53.6875

steps:
- id: filter
  label: Philosopher Filter
  in:
  - id: protxml
    source: protxml
  - id: workspace_in
    valueFrom: |-
      ${if (self[0].nameext == '.gz') {
          
          return self[0]} else {
              
              return self[1]
              
          }
      }
    source: workspace_and_annotation
  run: FragPipe-Filter-Quant-Report.cwl.steps/filter.cwl
  out:
  - id: workspace_out
  sbg:x: 536.1303100585938
  sbg:y: -77.54839324951172
- id: label_quant
  label: Philosopher Labelquant
  in:
  - id: workspace_in
    source: filter/workspace_out
  - id: annotation
    valueFrom: |-
      ${if (self[0].nameext == '.txt') {
          
          return self[0]} else {
              
              return self[1]
              
          }
      }
    source: workspace_and_annotation
  run: FragPipe-Filter-Quant-Report.cwl.steps/label_quant.cwl
  out:
  - id: workspace_out
  sbg:x: 719.0609130859375
  sbg:y: 14.672959327697754
- id: freequant
  label: Philosopher Freequant
  in:
  - id: workspace_in
    source: label_quant/workspace_out
  run: FragPipe-Filter-Quant-Report.cwl.steps/freequant.cwl
  out:
  - id: workspace_out
  sbg:x: 917.020263671875
  sbg:y: -55.280818939208984
- id: report
  label: Philosopher Report
  in:
  - id: msstats
    default: true
  - id: workspace_in
    source: freequant/workspace_out
  - id: interact_protein_xml
    source: protxml
  run: FragPipe-Filter-Quant-Report.cwl.steps/report.cwl
  out:
  - id: report_outputs
  sbg:x: 1094.7764892578125
  sbg:y: 60.23155212402344

hints:
- class: sbg:maxNumberOfParallelInstances
  value: '1'
- class: sbg:AWSInstanceType
  value: m5.2xlarge;ebs-gp2;150
sbg:appVersion:
- v1.1
sbg:categories:
- Proteomics
sbg:content_hash: a1d0c62f4d53523e5f2ebe463beb6caf2092eedf766ffc5c8d0ea0e674f584602
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618958061
sbg:id: |-
  david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe-Filter-Quant-Report/0
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe-Filter-Quant-Report/0.png
sbg:latestRevision: 0
sbg:links:
- id: https://fragpipe.nesvilab.org/
  label: fragpipe.nesvilab.org
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618958061
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe-Filter-Quant-Report/0/raw/
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
  sbg:modifiedOn: 1618958061
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
