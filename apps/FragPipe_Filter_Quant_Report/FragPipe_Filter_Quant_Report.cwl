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

inputs:
- id: protxml
  doc: protXML file path
  type: File?
  sbg:x: 307.5377502441406
  sbg:y: 194.25794982910156
- id: workspace_and_annotation
  label: Workspace and Annotation Files
  type: File[]
  sbg:fileTypes: TXT, TAR.GZ
  sbg:x: 147.0626678466797
  sbg:y: -3.1828291416168213

outputs:
- id: report_outputs
  type: File[]?
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
  run: FragPipe_Filter_Quant_Report.cwl.steps/filter.cwl
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
  run: FragPipe_Filter_Quant_Report.cwl.steps/label_quant.cwl
  out:
  - id: workspace_out
  sbg:x: 719.0609130859375
  sbg:y: 14.672959327697754
- id: freequant
  label: Philosopher Freequant
  in:
  - id: workspace_in
    source: label_quant/workspace_out
  run: FragPipe_Filter_Quant_Report.cwl.steps/freequant.cwl
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
  run: FragPipe_Filter_Quant_Report.cwl.steps/report.cwl
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
sbg:content_hash: acec8c2686296545e50d986b951743f54b3450245c454141b0470d02ce2d7e31e
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618420228
sbg:id: david.roberson/pdc-workshop/filter-report/5
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/pdc-workshop/filter-report/5.png
sbg:latestRevision: 5
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618601102
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/pdc-workshop/filter-report/5/raw/
sbg:project: david.roberson/pdc-workshop
sbg:projectName: PDC Workshop and Public Project Dev
sbg:publisher: sbg
sbg:revision: 5
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618420228
  sbg:revision: 0
  sbg:revisionNotes: Copy of david.roberson/pdc-webinar-devl-2/filter-report/14
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618421507
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618499560
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618597304
  sbg:revision: 3
  sbg:revisionNotes: removed file selector app
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618597431
  sbg:revision: 4
  sbg:revisionNotes: max parallel is 1
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618601102
  sbg:revision: 5
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
