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
  run:
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
  run:
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
  out:
  - id: workspace_out
  sbg:x: 719.0609130859375
  sbg:y: 14.672959327697754
- id: freequant
  label: Philosopher Freequant
  in:
  - id: workspace_in
    source: label_quant/workspace_out
  run:
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
      type:
      - 'null'
      - boolean
      default: true
      inputBinding:
        prefix: --isolated
        position: 1
        shellQuote: false
    - id: ptw
      doc: specify the time windows for the peak (minute) (default 0.4)
      type:
      - 'null'
      - float
      default: 0.4
      inputBinding:
        prefix: --ptw
        position: 2
        shellQuote: false
    - id: tol
      doc: m/z tolerance in ppm (default 10)
      type:
      - 'null'
      - int
      inputBinding:
        prefix: --tol
        position: 3
        shellQuote: false
    - id: workspace_in
      type: Directory
      loadListing: no_listing

    outputs:
    - id: workspace_out
      type:
      - 'null'
      - Directory
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
  run:
    cwlVersion: v1.1
    class: CommandLineTool
    label: Philosopher Report
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: LoadListingRequirement
    - class: ResourceRequirement
      coresMin: 0
      ramMin: 2000
    - class: DockerRequirement
      dockerPull: prvst/philosopher:latest
    - class: InitialWorkDirRequirement
      listing:
      - entryname: philosopher_report.sh
        writable: false
        entry: |
          ln -s $(inputs.workspace_in.path) ./

          cd $(inputs.workspace_in.basename)

          philosopher report $@

          cd ../

          mkdir report_files

          #peptide.tsv
          cp $(inputs.workspace_in.basename)/peptide.tsv report_files/$(inputs.workspace_in.basename)_peptide.tsv

          #ion.tsv
          cp $(inputs.workspace_in.basename)/ion.tsv report_files/$(inputs.workspace_in.basename)_ion.tsv

          #protein.tsv
          cp $(inputs.workspace_in.basename)/protein.tsv report_files/$(inputs.workspace_in.basename)_protein.tsv

          #psm.tsv
          cp $(inputs.workspace_in.basename)/psm.tsv report_files/$(inputs.workspace_in.basename)_psm.tsv
      - $(inputs.interact_protein_xml)
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
    - id: decoys
      type:
      - 'null'
      - boolean
      inputBinding:
        prefix: --decoys
        position: 0
        shellQuote: false
    - id: msstats
      type:
      - 'null'
      - boolean
      inputBinding:
        prefix: --msstats
        position: 1
        shellQuote: false
    - id: mzid
      type:
      - 'null'
      - boolean
      inputBinding:
        prefix: --mzid
        position: 2
        shellQuote: false
    - id: workspace_in
      type: Directory
      loadListing: deep_listing
    - id: interact_protein_xml
      type: File

    outputs:
    - id: report_outputs
      type:
      - 'null'
      - type: array
        items: File
      outputBinding:
        glob: 'report_files/* '
        outputEval: $(inheritMetadata(self, inputs.workspace_in))

    baseCommand:
    - bash philosopher_report.sh

    hints:
    - class: sbg:SaveLogs
      value: '*.sh'
    id: david.roberson/pdc-webinar-devl-2/report/1
    sbg:appVersion:
    - v1.1
    sbg:content_hash: a8b7aa718d70539999d8ef152cb2958106d15456ac257d49277c1ccccfdf0710b
    sbg:contributors:
    - david.roberson
    sbg:createdBy: david.roberson
    sbg:createdOn: 1618471798
    sbg:id: david.roberson/pdc-webinar-devl-2/report/1
    sbg:image_url:
    sbg:latestRevision: 1
    sbg:modifiedBy: david.roberson
    sbg:modifiedOn: 1618472791
    sbg:project: david.roberson/pdc-webinar-devl-2
    sbg:projectName: PDC Webinar Devl 2
    sbg:publisher: sbg
    sbg:revision: 1
    sbg:revisionNotes: ''
    sbg:revisionsInfo:
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1618471798
      sbg:revision: 0
      sbg:revisionNotes: |-
        Uploaded using sbpack v2020.10.05. 
        Source: 
        repo: https://github.com/davidroberson/shotgun_proteomics.git
        file: filter_quant_report.steps/report.cwl
        commit: 3bc2af0
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1618472791
      sbg:revision: 1
      sbg:revisionNotes: ''
    sbg:sbgMaintained: false
    sbg:validationErrors: []
  out:
  - id: report_outputs
  sbg:x: 1094.7764892578125
  sbg:y: 60.23155212402344

hints:
- class: sbg:maxNumberOfParallelInstances
  value: '1'
- class: sbg:AWSInstanceType
  value: m5.2xlarge;ebs-gp2;150
id: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/commit-fragpipe-proteomics-pipeline-tutorial/FragPipe_Filter_Quant_Report/1/raw/
sbg:appVersion:
- v1.1
sbg:categories:
- Proteomics
sbg:content_hash: a1d0c62f4d53523e5f2ebe463beb6caf2092eedf766ffc5c8d0ea0e674f584602
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618840177
sbg:id: |-
  david.roberson/commit-fragpipe-proteomics-pipeline-tutorial/FragPipe_Filter_Quant_Report/1
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/commit-fragpipe-proteomics-pipeline-tutorial/FragPipe_Filter_Quant_Report/1.png
sbg:latestRevision: 1
sbg:links:
- id: https://fragpipe.nesvilab.org/
  label: fragpipe.nesvilab.org
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618937758
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe_Filter_Quant_Report/3/raw/
sbg:project: david.roberson/commit-fragpipe-proteomics-pipeline-tutorial
sbg:projectName: 'COMMIT: FragPipe Proteomics Pipeline Tutorial'
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: |-
  Uploaded using sbpack v2020.10.05. 
  Source: 
  repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
  file: FragPipe_Filter_Quant_Report/FragPipe_Filter_Quant_Report.cwl
  commit: da2bd4b
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618840177
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: apps/FragPipe_Filter_Quant_Report/FragPipe_Filter_Quant_Report.cwl
    commit: 2054e80
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618937758
  sbg:revision: 1
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: FragPipe_Filter_Quant_Report/FragPipe_Filter_Quant_Report.cwl
    commit: da2bd4b
sbg:sbgMaintained: false
sbg:toolAuthor: Felipe da Veiga Leprevost
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
sbg:wrapperAuthor: Felipe da Veiga Leprevost; Dave Roberson
