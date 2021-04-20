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
  run:
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
      type:
      - 'null'
      - boolean
      default:
      inputBinding:
        prefix: --iprophet
        position: 0
        shellQuote: false
    - id: maxppmdiff
      doc: maximum peptide mass difference in ppm (default 2000000)
      type:
      - 'null'
      - int
      default: 2000000
      inputBinding:
        prefix: --maxppmdiff
        position: 1
        shellQuote: false
    - id: minprob
      doc: PeptideProphet probability threshold (default 0.05)
      type:
      - 'null'
      - float
      default: 0.05
      inputBinding:
        prefix: --minprob
        position: 2
        shellQuote: false
    - id: nonsp
      doc: do not use NSP model
      type:
      - 'null'
      - boolean
      inputBinding:
        prefix: --nonsp
        position: 3
        shellQuote: false
    - id: output
      doc: Output name (default "interact")
      type:
      - 'null'
      - string
      default: interact
      inputBinding:
        prefix: --output
        position: 4
        shellQuote: false
    - id: unmapped
      doc: report results for UNMAPPED proteins
      type:
      - 'null'
      - boolean
      inputBinding:
        prefix: --unmapped
        position: 5
        shellQuote: false
    - id: workspace_in
      type:
      - 'null'
      - type: array
        items: File

    outputs:
    - id: interact_protein_xml
      type:
      - 'null'
      - File
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
  out:
  - id: interact_protein_xml
  sbg:x: -100
  sbg:y: -96

hints:
- class: sbg:AWSInstanceType
  value: c5.2xlarge;ebs-gp2;200
id: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/commit-fragpipe-proteomics-pipeline-tutorial/FragPipe_ProteinProphet/1/raw/
sbg:appVersion:
- v1.1
sbg:categories:
- Proteomics
sbg:content_hash: a9732c3274149710590c5c3963f5f088ad111cb6ac24893839d6e07a60c7f185c
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618840236
sbg:id: |-
  david.roberson/commit-fragpipe-proteomics-pipeline-tutorial/FragPipe_ProteinProphet/1
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/commit-fragpipe-proteomics-pipeline-tutorial/FragPipe_ProteinProphet/1.png
sbg:latestRevision: 1
sbg:links:
- id: https://fragpipe.nesvilab.org/
  label: fragpipe.nesvilab.org
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618937802
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe_ProteinProphet/1/raw/
sbg:project: david.roberson/commit-fragpipe-proteomics-pipeline-tutorial
sbg:projectName: 'COMMIT: FragPipe Proteomics Pipeline Tutorial'
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: |-
  Uploaded using sbpack v2020.10.05. 
  Source: 
  repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
  file: FragPipe_ProteinProphet/FragPipe_ProteinProphet.cwl
  commit: da2bd4b
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618840236
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: apps/FragPipe_ProteinProphet/FragPipe_ProteinProphet.cwl
    commit: 2054e80
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618937802
  sbg:revision: 1
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: FragPipe_ProteinProphet/FragPipe_ProteinProphet.cwl
    commit: da2bd4b
sbg:sbgMaintained: false
sbg:toolAuthor: Felipe da Veiga Leprevost
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
sbg:wrapperAuthor: Felipe da Veiga Leprevost; Dave Roberson
