cwlVersion: v1.1
class: Workflow
label: 'FragPipe:  Convert - Identify - PeptideProphet'
doc: |-
  The first step of the workflow consists of converting the raw mass spectrometry data to the mzML format using msconvert, followed by the database search using MSFragger, and the peptide validation using PeptideProphet.

   MSFragger can only be used for academic research, non-commercial or educational purposes.
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ScatterFeatureRequirement
- class: InlineJavascriptRequirement
- class: StepInputExpressionRequirement

inputs:
- id: database_name
  label: database file (fas)
  doc: Path to the protein database file in FASTA format.
  type: File
  sbg:fileTypes: FAS
  sbg:x: 230
  sbg:y: 64
- id: raw_files
  label: RAW files
  type: File[]
  sbg:fileTypes: RAW
  sbg:x: 31
  sbg:y: 64
- id: decoy
  doc: |-
    semi-supervised mode, protein name prefix to identify decoy entries (default "rev_")
  type: string?
  sbg:exposed: true
- id: combine
  doc: combine the results from PeptideProphet into a single result file
  type: boolean?
  sbg:exposed: true
- id: accmass
  doc: use accurate mass model binning
  type: boolean?
  sbg:exposed: true
- id: decoyprobs
  doc: compute possible non-zero probabilities for decoy entries on the last iteration
  type: boolean?
  sbg:exposed: true
- id: expectscore
  doc: use expectation value as the only contributor to the f-value for modeling
  type: boolean?
  sbg:exposed: true
- id: nonparam
  doc: use semi-parametric modeling, must be used in conjunction with --decoy option
  type: boolean?
  sbg:exposed: true
- id: ppm
  doc: use ppm mass error instead of Daltons for mass modeling
  type: boolean?
  sbg:exposed: true
- id: precursor_mass_lower
  doc: Lower bound of the precursor mass window.
  type: int?
  sbg:exposed: true
- id: precursor_mass_upper
  doc: Upper bound of the precursor mass window.
  type: int?
  sbg:exposed: true
- id: precursor_mass_units
  doc: Precursor mass tolerance units (0 for Da, 1 for ppm).
  type: int?
  sbg:exposed: true
- id: precursor_true_tolerance
  doc: True precursor mass tolerance (window is +/- this value).
  type: int?
  sbg:exposed: true
- id: precursor_true_units
  doc: True precursor mass tolerance units (0 for Da, 1 for ppm).
  type: int?
  sbg:exposed: true
- id: fragment_mass_tolerance
  doc: Fragment mass tolerance (window is +/- this value).
  type: int?
  sbg:exposed: true
- id: fragment_mass_units
  doc: Fragment mass tolerance units (0 for Da, 1 for ppm).
  type: int?
  sbg:exposed: true
- id: calibrate_mass
  doc: |-
    Perform mass calibration (0 for OFF, 1 for ON, 2 for ON and find optimal parameters).
  type: int?
  sbg:exposed: true
- id: decoy_prefix
  doc: Prefix added to the decoy protein ID.
  type: string?
  sbg:exposed: true
- id: isotope_error
  doc: Also search for MS/MS events triggered on specified isotopic peaks.
  type: string?
  sbg:exposed: true
- id: search_enzyme_name
  doc: Name of enzyme to be written to the pepXML file.
  type: string?
  sbg:exposed: true
- id: search_enzyme_cutafter
  doc: Residues after which the enzyme cuts.
  type: string?
  sbg:exposed: true
- id: num_enzyme_termini
  doc: 0 for non-enzymatic, 1 for semi-enzymatic, and 2 for fully-enzymatic.
  type: int?
  sbg:exposed: true
- id: allowed_missed_cleavage
  doc: Allowed number of missed cleavages per peptide. Maximum value is 5.
  type: int?
  sbg:exposed: true
- id: variable_mod_01
  type: string?
  sbg:exposed: true
- id: variable_mod_02
  type: string?
  sbg:exposed: true
- id: variable_mod_03
  type: string?
  sbg:exposed: true
- id: variable_mod_04
  type: string?
  sbg:exposed: true
- id: output_report_topN
  doc: Reports top N PSMs per input spectrum.
  type: int?
  sbg:exposed: true
- id: precursor_charge
  doc: |-
    Assumed range of potential precursor charge states. Only relevant when override_charge is set to 1.
  type: string?
  sbg:exposed: true
- id: digest_min_length
  doc: Minimum length of peptides to be generated during in-silico digestion.
  type: int?
  sbg:exposed: true
- id: digest_max_length
  doc: Maximum length of peptides to be generated during in-silico digestion.
  type: int?
  sbg:exposed: true
- id: max_fragment_charge
  doc: Maximum charge state for theoretical fragments to match (1-4).
  type: int?
  sbg:exposed: true
- id: deisotope
  doc: Perform deisotoping or not.
  type: int?
  sbg:exposed: true
- id: add_Cterm_peptide
  type: float?
  sbg:exposed: true
- id: add_Nterm_peptide
  type: float?
  sbg:exposed: true
- id: add_Cterm_protein
  type: float?
  sbg:exposed: true
- id: add_Nterm_protein
  type: float?
  sbg:exposed: true
- id: add_G_glycine
  type: float?
  sbg:exposed: true
- id: add_A_alanine
  type: float?
  sbg:exposed: true
- id: add_S_serine
  type: float?
  sbg:exposed: true
- id: add_P_proline
  type: float?
  sbg:exposed: true
- id: add_V_valine
  type: float?
  sbg:exposed: true
- id: add_T_threonine
  type: float?
  sbg:exposed: true
- id: add_C_cysteine
  type: float?
  sbg:exposed: true
- id: add_L_leucine
  type: float?
  sbg:exposed: true
- id: add_I_isoleucine
  type: float?
  sbg:exposed: true
- id: add_N_asparagine
  type: float?
  sbg:exposed: true
- id: add_D_aspartic_acid
  type: float?
  sbg:exposed: true
- id: add_Q_glutamine
  type: float?
  sbg:exposed: true
- id: add_K_lysine
  type: float?
  sbg:exposed: true
- id: add_E_glutamic_acid
  type: float?
  sbg:exposed: true
- id: add_M_methionine
  type: float?
  sbg:exposed: true
- id: add_H_histidine
  type: float?
  sbg:exposed: true
- id: add_F_phenylalanine
  type: float?
  sbg:exposed: true
- id: add_R_arginine
  type: float?
  sbg:exposed: true
- id: add_Y_tyrosine
  type: float?
  sbg:exposed: true
- id: add_W_tryptophan
  type: float?
  sbg:exposed: true
- id: add_B_user_amino_acid
  type: float?
  sbg:exposed: true
- id: add_J_user_amino_acid
  type: float?
  sbg:exposed: true
- id: add_O_user_amino_acid
  type: float?
  sbg:exposed: true
- id: add_U_user_amino_acid
  type: float?
  sbg:exposed: true
- id: add_X_user_amino_acid
  type: float?
  sbg:exposed: true
- id: add_Z_user_amino_acid
  type: float?
  sbg:exposed: true

outputs:
- id: peptide_prophet_folder_archive
  type: File?
  outputSource:
  - peptide_prophet/peptide_prophet_folder_archive
  sbg:x: 913
  sbg:y: -84
- id: peptide_archive_with_mzml
  type: File?
  outputSource:
  - peptide_prophet/peptide_archive_with_mzml
  sbg:x: 958
  sbg:y: 176

steps:
- id: peptide_prophet
  label: Philosopher PeptideProphet
  in:
  - id: accmass
    default: true
    source: accmass
  - id: combine
    default: true
    source: combine
  - id: --database
    source: database_name
  - id: decoy
    default: rev_
    source: decoy
  - id: decoyprobs
    default: true
    source: decoyprobs
  - id: expectscore
    default: true
    source: expectscore
  - id: nonparam
    default: true
    source: nonparam
  - id: ppm
    default: true
    source: ppm
  - id: pepXML
    source:
    - msfragger/pepxml
  - id: mzML
    source:
    - msconvert/mzML
  - id: workspace_in
    source: database/workspace
  run:
    cwlVersion: v1.1
    class: CommandLineTool
    label: Philosopher PeptideProphet
    doc: |-
      ```
      Peptide assignment validation

      Usage:
        philosopher peptideprophet [flags]

      Flags:
            --accmass            use accurate mass model binning
            --clevel int         set Conservative Level in neg_stdev from the neg_mean, low numbers are less conservative, high numbers are more conservative
            --combine            combine the results from PeptideProphet into a single result file
            --database string    path to the database
            --decoy string       semi-supervised mode, protein name prefix to identify decoy entries (default "rev_")
            --decoyprobs         compute possible non-zero probabilities for decoy entries on the last iteration
            --enzyme string      enzyme used in sample
            --expectscore        use expectation value as the only contributor to the f-value for modeling
            --glyc               enable peptide glyco motif model
        -h, --help               help for peptideprophet
            --ignorechg string   use comma to separate the charge states to exclude from modeling
            --masswidth float    model mass width (default 5)
            --minpeplen int      minimum peptide length not rejected (default 7)
            --minprob float      report results with minimum probability (default 0.05)
            --nomass             disable mass model
            --nonmc              disable NMC missed cleavage model
            --nonparam           use semi-parametric modeling, must be used in conjunction with --decoy option
            --nontt              disable NTT enzymatic termini model
            --output string      output name prefix (default "interact")
            --phospho            enable peptide phospho motif model
            --ppm                use ppm mass error instead of Daltons for mass modeling```


      ```
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: LoadListingRequirement
    - class: ResourceRequirement
      coresMin: 1
      ramMin: 2000
    - class: DockerRequirement
      dockerPull: prvst/philosopher:latest
    - class: InitialWorkDirRequirement
      listing:
      - $(inputs.pepXML)
      - $(inputs.mzML)
      - $(inputs.workspace_in)
      - entryname: philosopher_peptideprophet.sh
        writable: false
        entry: |-
          tar -xvzf $(inputs.workspace_in.path) -C ./

          mv *.mzML *.pepXML *pep.xml $(inputs.workspace_in.metadata["Plex or dataset name"])

          cd $(inputs.workspace_in.metadata["Plex or dataset name"])

          philosopher peptideprophet $@

          cd ../

          tar -cvzf $(inputs.workspace_in.metadata["Plex or dataset name"]).for_filter.tar.gz $(inputs.workspace_in.metadata["Plex or dataset name"])

          rm $(inputs.workspace_in.metadata["Plex or dataset name"])/*.mzML 

          tar -cvzf $(inputs.workspace_in.metadata["Plex or dataset name"]).for_protein.tar.gz $(inputs.workspace_in.metadata["Plex or dataset name"])
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
    - id: accmass
      doc: use accurate mass model binning
      type: boolean?
      inputBinding:
        prefix: --accmass
        position: 0
        shellQuote: false
    - id: combine
      doc: combine the results from PeptideProphet into a single result file
      type: boolean?
      inputBinding:
        prefix: --combine
        position: 1
        shellQuote: false
    - id: --database
      doc: path to the database
      type: File
      inputBinding:
        prefix: --database
        position: 2
        shellQuote: false
    - id: decoy
      doc: |-
        semi-supervised mode, protein name prefix to identify decoy entries (default "rev_")
      type: string?
      default: rev_
      inputBinding:
        prefix: --decoy
        position: 3
        shellQuote: false
    - id: decoyprobs
      doc: compute possible non-zero probabilities for decoy entries on the last iteration
      type: boolean?
      inputBinding:
        prefix: --decoyprobs
        position: 4
        shellQuote: false
    - id: enzyme
      doc: enzyme used in sample
      type: string?
      default: trypsin
      inputBinding:
        prefix: --enzyme
        position: 5
        shellQuote: false
    - id: expectscore
      doc: use expectation value as the only contributor to the f-value for modeling
      type: boolean?
      inputBinding:
        prefix: --expectscore
        position: 6
        shellQuote: false
    - id: masswidth
      doc: model mass width (default 5)
      type: float?
      default: 5
      inputBinding:
        prefix: --masswidth
        position: 7
        shellQuote: false
    - id: minpeplen
      doc: minimum peptide length not rejected (default 7)
      type: int?
      default: 7
      inputBinding:
        prefix: --minpeplen
        position: 8
        shellQuote: false
    - id: minprob
      doc: report results with minimum probability (default 0.05)
      type: float?
      default: 0.05
      inputBinding:
        prefix: --minprob
        position: 9
        shellQuote: false
    - id: nonparam
      doc: use semi-parametric modeling, must be used in conjunction with --decoy
        option
      type: boolean?
      inputBinding:
        prefix: --nonparam
        position: 10
        shellQuote: false
    - id: nontt
      doc: disable NTT enzymatic termini model
      type: boolean?
      inputBinding:
        prefix: --nontt
        position: 11
        shellQuote: false
    - id: ppm
      doc: use ppm mass error instead of Daltons for mass modeling
      type: boolean?
      inputBinding:
        prefix: --ppm
        position: 12
        shellQuote: false
    - id: pepXML
      type: File[]
    - id: mzML
      type: File[]
    - id: workspace_in
      type: File

    outputs:
    - id: peptide_prophet_log
      type: File
      outputBinding:
        glob: $(inputs.pepXML[0].metadata["Plex or dataset name"]).peptide_prophet.log
        outputEval: $(inheritMetadata(self, inputs.pepXML))
    - id: output_xml
      type: File[]
      outputBinding:
        glob: '*pep.xml'
        outputEval: $(inheritMetadata(self, inputs.pepXML))
    - id: peptide_prophet_folder_archive
      type: File?
      outputBinding:
        glob: "*.for_protein.tar.gz\n\n"
        outputEval: $(inheritMetadata(self, inputs.pepXML))
    - id: peptide_archive_with_mzml
      type: File?
      outputBinding:
        glob: '*for_filter.tar.gz'
        outputEval: $(inheritMetadata(self, inputs.pepXML))

    baseCommand:
    - bash philosopher_peptideprophet.sh
    arguments:
    - prefix: ''
      position: 90
      valueFrom: '*.pepXML'
      shellQuote: false
    - prefix: ''
      position: 91
      valueFrom: '> $(inputs.workspace_in.metadata["Plex or dataset name"]).peptide_prophet.log'
      shellQuote: false

    hints:
    - class: sbg:SaveLogs
      value: '*.sh'
    - class: sbg:SaveLogs
      value: '*.log'
    id: david.roberson/pdc-webinar-dev/peptide-prophet/6
    sbg:appVersion:
    - v1.1
    sbg:categories:
    - Proteomics
    sbg:content_hash: a10eb2794a4421cb1aec28abd7ceec09963fe078734a55c478d1e091662dcd3b0
    sbg:contributors:
    - david.roberson
    sbg:createdBy: david.roberson
    sbg:createdOn: 1616618434
    sbg:id: david.roberson/pdc-webinar-dev/peptide-prophet/6
    sbg:image_url:
    sbg:latestRevision: 6
    sbg:links:
    - id: https://github.com/Nesvilab/philosopher
      label: Github Project
    sbg:modifiedBy: david.roberson
    sbg:modifiedOn: 1616681184
    sbg:project: david.roberson/pdc-webinar-dev
    sbg:projectName: PDC Webinar Dev
    sbg:publisher: sbg
    sbg:revision: 6
    sbg:revisionNotes: ''
    sbg:revisionsInfo:
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616618434
      sbg:revision: 0
      sbg:revisionNotes: |-
        Uploaded using sbpack v2020.10.05. 
        Source: 
        repo: https://github.com/davidroberson/shotgun_proteomics.git
        file: tools/peptide-prophet/peptide_prophet.cwl
        commit: 1eb0cff
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616623591
      sbg:revision: 1
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616629192
      sbg:revision: 2
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616635332
      sbg:revision: 3
      sbg:revisionNotes: better glob
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616677096
      sbg:revision: 4
      sbg:revisionNotes: added archive in
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616677216
      sbg:revision: 5
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616681184
      sbg:revision: 6
      sbg:revisionNotes: ''
    sbg:sbgMaintained: false
    sbg:toolAuthor: Felipe da Veiga Leprevost
    sbg:toolkitVersion: Philosopher
    sbg:validationErrors: []
    sbg:wrapperAuthor: Felipe da Veiga Leprevost; David Roberson
  out:
  - id: peptide_prophet_log
  - id: output_xml
  - id: peptide_prophet_folder_archive
  - id: peptide_archive_with_mzml
  sbg:x: 749
  sbg:y: 56
- id: workspace
  label: Philosopher Workspace
  in:
  - id: init
    default: true
  - id: nocheck
    default: false
  - id: meta_data_files
    source:
    - raw_files
  run:
    cwlVersion: v1.1
    class: CommandLineTool
    label: Philosopher Workspace
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: LoadListingRequirement
    - class: ResourceRequirement
      coresMin: 1
      ramMin: 100
    - class: DockerRequirement
      dockerPull: prvst/philosopher:3.2.3
    - class: InitialWorkDirRequirement
      listing:
      - $(inputs.pepXML)
      - entryname: philosopher_workspace.sh
        writable: false
        entry: |2-

          mkdir $(inputs.meta_data_files[0].metadata["Plex or dataset name"])

          cd $(inputs.meta_data_files[0].metadata["Plex or dataset name"])

          philosopher workspace $@

          cd ../

          tar -cvzf $(inputs.meta_data_files[0].metadata["Plex or dataset name"]).tar.gz $(inputs.meta_data_files[0].metadata["Plex or dataset name"])
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
    - id: init
      doc: Initialize the workspace
      type: boolean?
      default:
      inputBinding:
        prefix: --init
        position: 1
        shellQuote: false
    - id: analytics
      doc: reports when a workspace is created for usage estimation (default true)
      type: boolean?
      inputBinding:
        prefix: --analytics
        position: 1
        shellQuote: false
    - id: backup
      doc: create a backup of the experiment meta data
      type: boolean?
      inputBinding:
        prefix: --backup
        position: 1
        shellQuote: false
    - id: clean
      doc: remove the workspace and all meta data. Experimental file are kept intact
      type: boolean?
      inputBinding:
        prefix: --clean
        position: 1
        shellQuote: false
    - id: nocheck
      doc: do not check for new versions
      type: boolean?
      inputBinding:
        prefix: --nocheck
        position: 1
        shellQuote: false
    - id: meta_data_files
      type: File[]
      inputBinding:
        position: 0
        valueFrom: ./$(self[0].metadata["Plex or dataset name"])
        shellQuote: false

    outputs:
    - id: workspace
      type: File?
      outputBinding:
        glob: '*.tar.gz'
        outputEval: $(inheritMetadata(self, inputs.meta_data_files))
    stdout: std.out

    baseCommand:
    - bash philosopher_workspace.sh

    hints:
    - class: sbg:SaveLogs
      value: '*.sh'
    - class: sbg:SaveLogs
      value: std.out
    id: david.roberson/pdc-webinar-dev/workspace/5
    sbg:appVersion:
    - v1.1
    sbg:content_hash: a04c6999346eef832c6aee72c9f54d427ac8f57881e6d5731fd842444398ea973
    sbg:contributors:
    - david.roberson
    sbg:createdBy: david.roberson
    sbg:createdOn: 1616629639
    sbg:id: david.roberson/pdc-webinar-dev/workspace/5
    sbg:image_url:
    sbg:latestRevision: 5
    sbg:modifiedBy: david.roberson
    sbg:modifiedOn: 1617114475
    sbg:project: david.roberson/pdc-webinar-dev
    sbg:projectName: PDC Webinar Dev
    sbg:publisher: sbg
    sbg:revision: 5
    sbg:revisionNotes: ''
    sbg:revisionsInfo:
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616629639
      sbg:revision: 0
      sbg:revisionNotes: |-
        Uploaded using sbpack v2020.10.05. 
        Source: 
        repo: https://github.com/davidroberson/shotgun_proteomics.git
        file: tools/workspace/workspace.cwl
        commit: 31fdf12
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616629985
      sbg:revision: 1
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616674457
      sbg:revision: 2
      sbg:revisionNotes: added tar
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616674508
      sbg:revision: 3
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616677891
      sbg:revision: 4
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1617114475
      sbg:revision: 5
      sbg:revisionNotes: ''
    sbg:sbgMaintained: false
    sbg:validationErrors: []
  out:
  - id: workspace
  sbg:x: 243.94737243652344
  sbg:y: -122.02381896972656
- id: msconvert
  label: msconvert
  in:
  - id: raw_files
    source: raw_files
  scatter:
  - raw_files
  run:
    cwlVersion: v1.1
    class: CommandLineTool
    label: msconvert
    doc: |-
      ```
      Usage: msconvert [options] [filemasks]
      Convert mass spec data file formats.

      Return value: # of failed files.

      Options:
        -f [ --filelist ] arg              : specify text file containing filenames
        -o [ --outdir ] arg (=.)           : set output directory ('-' for stdout) 
                                           [.]
        -c [ --config ] arg                : configuration file (optionName=value)
        --outfile arg                      : Override the name of output file.
        -e [ --ext ] arg                   : set extension for output files 
                                           [mzML|mzXML|mgf|txt|mz5]
        --mzML                             : write mzML format [default]
        --mzXML                            : write mzXML format
        --mz5                              : write mz5 format
        --mgf                              : write Mascot generic format
        --text                             : write ProteoWizard internal text format
        --ms1                              : write MS1 format
        --cms1                             : write CMS1 format
        --ms2                              : write MS2 format
        --cms2                             : write CMS2 format
        -v [ --verbose ]                   : display detailed progress information
        --64                               : set default binary encoding to 64-bit 
                                           precision [default]
        --32                               : set default binary encoding to 32-bit
                                         precision [default]
        --32                               : set default binary encoding to 32-bit 
                                           precision
        --mz64                             : encode m/z values in 64-bit precision 
                                           [default]
        --mz32                             : encode m/z values in 32-bit precision
        --inten64                          : encode intensity values in 64-bit 
                                           precision
        --inten32                          : encode intensity values in 32-bit 
                                           precision [default]
        --noindex                          : do not write index
        -i [ --contactInfo ] arg           : filename for contact info
        -z [ --zlib ]                      : use zlib compression for binary data
        --numpressLinear [=arg(=2e-09)]    : use numpress linear prediction 
                                           compression for binary mz and rt data 
                                           (relative accuracy loss will not exceed 
                                           given tolerance arg, unless set to 0)
        --numpressLinearAbsTol [=arg(=-1)] : desired absolute tolerance for linear 
                                           numpress prediction (e.g. use 1e-4 for a 
                                           mass accuracy of 0.2 ppm at 500 m/z, 
                                           default uses -1.0 for maximal accuracy). 
                                           Note: setting this value may substantially
                                           reduce file size, this overrides relative 
                                           accuracy tolerance.
        --numpressPic                      : use numpress positive integer 
                                           compression for binary intensities 
                                           (absolute accuracy loss will not exceed 
                                           0.5)
        --numpressSlof [=arg(=0.0002)]     : use numpress short logged float 
                                           compression for binary intensities 
                                           (relative accuracy loss will not exceed 
                                           given tolerance arg, unless set to 0)
        -n [ --numpressAll ]               : same as --numpressLinear --numpressSlof 
                                           (see https://github.com/fickludd/ms-numpre
                                           ss for more info)
        -g [ --gzip ]                      : gzip entire output file (adds .gz to
                                          filename)
        --filter arg                       : add a spectrum list filter
        --chromatogramFilter arg           : add a chromatogram list filter
        --merge                            : create a single output file from 
                                           multiple input files by merging file-level
                                           metadata and concatenating spectrum lists
        --runIndexSet arg                  : for multi-run sources, select only the 
                                           specified run indices
        --simAsSpectra                     : write selected ion monitoring as 
                                           spectra, not chromatograms
        --srmAsSpectra                     : write selected reaction monitoring as 
                                           spectra, not chromatograms
        --combineIonMobilitySpectra        : write all drift bins/scans in a 
                                           frame/block as one spectrum instead of 
                                           individual spectra
        --acceptZeroLengthSpectra          : some vendor readers have an efficient 
                                           way of filtering out empty spectra, but it
                                           takes more time to open the file
        --ignoreUnknownInstrumentError     : if true, if an instrument cannot be 
                                           determined from a vendor file, it will not
                                           be an error
        --stripLocationFromSourceFiles     : if true, sourceFile elements will be 
                                           stripped of location information, so the 
                                           same file converted from different 
                                           locations will produce the same mzML
        --stripVersionFromSoftware         : if true, software elements will be 
                                           stripped of version information, so the 
                                           same file converted with different 
                                           versions will produce the same mzML
        --singleThreaded                   : if true, reading and writing spectra 
                                           will be done on a single thread
        --help                             : show this message, with extra detail on 
                                           filter options
                                        filter options
        --help-filter arg                  : name of a single filter to get detailed 
                                           help for

      FILTER OPTIONS
      run this command with --help to see more detail
      index <index_value_set>
      id <id_set>
      msLevel <mslevels>
      chargeState <charge_states>
      precursorRecalculation 
      mzRefiner input1.pepXML input2.mzid [msLevels=<1->]
      [thresholdScore=<CV_Score_Name>] [thresholdValue=<floatset>]
      [thresholdStep=<float>] [maxSteps=<count>]
      lockmassRefiner mz=<real> mzNegIons=<real (mz)> tol=<real (1.0 Daltons)>
      precursorRefine 
      peakPicking [<PickerType> [snr=<minimum signal-to-noise ratio>]
      [peakSpace=<minimum peak spacing>] [msLevel=<ms_levels>]]
      scanNumber <scan_numbers>
      scanEvent <scan_event_set>
      scanTime <scan_time_range>
      sortByScanTime 
      stripIT 
      metadataFixer 
      titleMaker <format_string>
      threshold <type> <threshold> <orientation> [<mslevels>]
      mzWindow <mzrange>
      mzPrecursors <precursor_mz_list> [mzTol=<mzTol (10 ppm)>]
      [target=<selected|isolated> (selected)] [mode=<include|exclude (include)>]
      defaultArrayLength <peak_count_range>
      zeroSamples <mode> [<MS_levels>]
      mzPresent <mz_list> [mzTol=<tolerance> (0.5 mz)] [type=<type> (count)]
      [threshold=<threshold> (10000)] [orientation=<orientation> (most-intense)]
      [mode=<include|exclude (include)>]
      scanSumming [precursorTol=<precursor tolerance>] [scanTimeTol=<scan time
      tolerance in seconds>] [ionMobilityTol=<ion mobility tolerance>]
      thermoScanFilter <exact|contains> <include|exclude> <match string>
      MS2Denoise [<peaks_in_window> [<window_width_Da>
      [multicharge_fragment_relaxation]]]
      MS2Deisotope [hi_res [mzTol=<mzTol>]] [Poisson [minCharge=<minCharge>]
      [maxCharge=<maxCharge>]]
      ETDFilter [<removePrecursor> [<removeChargeReduced> [<removeNeutralLoss>
      [<blanketRemoval> [<matchingTolerance> ]]]]]
      demultiplex massError=<tolerance and units, eg 0.5Da (default 10ppm)>
      nnlsMaxIter=<int (50)> nnlsEps=<real (1e-10)> noWeighting=<bool (false)>
      demuxBlockExtra=<real (0)> variableFill=<bool (false)> noSumNormalize=<bool
      (false)> optimization=<(none)|overlap_only> interpolateRT=<bool (true)>
      minWindowSize=<real (0.2)>
      chargeStatePredictor [overrideExistingCharge=<true|false (false)>]
      [maxMultipleCharge=<int (3)>] [minMultipleCharge=<int (2)>]
      [singleChargeFractionTIC=<real (0.9)>] [maxKnownCharge=<int (0)>]
      [makeMS2=<true|false (false)>]
      turbocharger [minCharge=<minCharge>] [maxCharge=<maxCharge>]
      [precursorsBefore=<before>] [precursorsAfter=<after>] [halfIsoWidth=<half-width
      of isolation window>] [defaultMinCharge=<defaultMinCharge>]
      [defaultMaxCharge=<defaultMaxCharge>] [useVendorPeaks=<useVendorPeaks>]
      activation <precursor_activation_type>
      analyzer <analyzer>
      analyzerType <analyzer>
      polarity <polarity>


      Examples:

      # convert data.RAW to data.mzML
      msconvert data.RAW
      # convert data.RAW to data.mzXML
      msconvert data.RAW --mzXML

      # put output file in my_output_dir
      msconvert data.RAW -o my_output_dir

      # combining options to create a smaller mzML file, much like the old ReAdW converter program
      msconvert data.RAW --32 --zlib --filter "peakPicking true 1-" --filter "zeroSamples removeExtra"

      # extract scan indices 5...10 and 20...25
      msconvert data.RAW --filter "index [5,10] [20,25]"

      # extract MS1 scans only
      msconvert data.RAW --filter "msLevel 1"

      # extract MS2 and MS3 scans only
      msconvert data.RAW --filter "msLevel 2-3"

      # extract MSn scans for n>1
      msconvert data.RAW --filter "msLevel 2-"

      # apply ETD precursor mass filter
      msconvert data.RAW --filter ETDFilter

      # remove non-flanking zero value samples
      msconvert data.RAW --filter "zeroSamples removeExtra"

      # remove non-flanking zero value samples in MS2 and MS3 only
      msconvert data.RAW --filter "zeroSamples removeExtra 2 3"

      # add missing zero value samples (with 5 flanking zeros) in MS2 and MS3 only
      msconvert data.RAW --filter "zeroSamples addMissing=5 2 3"

      # keep only HCD spectra from a decision tree data file
      msconvert data.RAW --filter "activation HCD"

      # keep the top 42 peaks or samples (depending on whether spectra are centroid or profile):
      msconvert data.RAW --filter "threshold count 42 most-intense"

      # multiple filters: select scan numbers and recalculate precursors
      msconvert data.RAW --filter "scanNumber [500,1000]" --filter "precursorRecalculation"

      # multiple filters: apply peak picking and then keep the bottom 100 peaks:
      msconvert data.RAW --filter "peakPicking true 1-" --filter "threshold count 100 least-intense"

      # multiple filters: apply peak picking and then keep all peaks that are at least 50% of the intensity of the base peak:
      msconvert data.RAW --filter "peakPicking true 1-" --filter "threshold bpi-relative .5 most-intense"

      # use a configuration file
      msconvert data.RAW -c config.txt

      # example configuration file
      mzXML=true
      zlib=true
      filter="index [3,7]"
      filter="precursorRecalculation"


      Questions, comments, and bug reports:
      https://github.com/ProteoWizard
      support@proteowizard.org

      ProteoWizard release: 3.0.20066 (729ef9c41)
      Build date: Mar  6 2020 23:32:05
      ```
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: ResourceRequirement
      ramMin: 2000
    - class: DockerRequirement
      dockerPull: chambm/pwiz-skyline-i-agree-to-the-vendor-licenses:3.0.20066-729ef9c41
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
    - id: raw_files
      type: File
      inputBinding:
        position: 0
        shellQuote: false
      sbg:fileTypes: RAW

    outputs:
    - id: std_out
      type: File?
      outputBinding:
        glob: std.out
        outputEval: $(inheritMetadata(self, inputs.raw_files))
    - id: mzML
      type: File
      outputBinding:
        glob: '*mzML'
        outputEval: $(inheritMetadata(self, inputs.raw_files))
    stdout: std.out

    baseCommand:
    - wine msconvert --mzML --64 --mz64 --inten64 --filter "peakPicking true 1-"
    id: david.roberson/pdc-webinar-dev/msconvert/1
    sbg:appVersion:
    - v1.1
    sbg:content_hash: a7a3ea8b627ed923820f98e7fd7e3856402d96c9e9a7e0d62e4f73d44c1cc8323
    sbg:contributors:
    - david.roberson
    sbg:createdBy: david.roberson
    sbg:createdOn: 1616632419
    sbg:id: david.roberson/pdc-webinar-dev/msconvert/1
    sbg:image_url:
    sbg:latestRevision: 1
    sbg:modifiedBy: david.roberson
    sbg:modifiedOn: 1616632573
    sbg:project: david.roberson/pdc-webinar-dev
    sbg:projectName: PDC Webinar Dev
    sbg:publisher: sbg
    sbg:revision: 1
    sbg:revisionNotes: 2GB of RAM and one CPU
    sbg:revisionsInfo:
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616632419
      sbg:revision: 0
      sbg:revisionNotes: |-
        Uploaded using sbpack v2020.10.05. 
        Source: 
        repo: https://github.com/davidroberson/shotgun_proteomics.git
        file: tools/msconvert/msconvert.cwl
        commit: 31fdf12
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1616632573
      sbg:revision: 1
      sbg:revisionNotes: 2GB of RAM and one CPU
    sbg:sbgMaintained: false
    sbg:validationErrors: []
  out:
  - id: std_out
  - id: mzML
  sbg:x: 260.87890625
  sbg:y: 296.21453857421875
- id: database
  label: Philosopher Database
  in:
  - id: annotate
    source: database_name
  - id: workspace_in
    source: workspace/workspace
  run:
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
      type: string?
      default:
      inputBinding:
        prefix: --add
        position: 0
        shellQuote: false
    - id: annotate
      doc: process a ready-to-use database
      type: File?
      inputBinding:
        prefix: --annotate
        position: 1
        shellQuote: false
    - id: contam
      doc: add common contaminants
      type: boolean?
      inputBinding:
        prefix: --contam
        position: 3
        shellQuote: false
    - id: custom
      doc: use a pre-formatted custom database
      type: string?
      inputBinding:
        prefix: --custom
        position: 0
        shellQuote: false
    - id: enzyme
      doc: |-
        enzyme for digestion (trypsin, lys_c, lys_n, glu_c, chymotrypsin) (default "trypsin")
      type: string?
      default: trypsin
      inputBinding:
        prefix: --enzyme
        position: 5
        shellQuote: false
    - id: id
      doc: UniProt proteome ID
      type: string?
      inputBinding:
        prefix: --id
        position: 6
        shellQuote: false
    - id: isoform
      doc: add isoform sequences
      type: boolean?
      inputBinding:
        prefix: --isoform
        position: 7
        shellQuote: false
    - id: nodecoys
      doc: don't add decoys to the database
      type: boolean?
      inputBinding:
        prefix: --nodecoys
        position: 8
        shellQuote: false
    - id: prefix
      type: string?
      default: rev_
      inputBinding:
        prefix: --prefix
        position: 9
        shellQuote: false
    - id: reviewed
      type: boolean?
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
      type: File?
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
  out:
  - id: output
  - id: workspace
  sbg:x: 478
  sbg:y: -133
- id: msfragger
  label: MSFragger
  in:
  - id: database_name
    source: database_name
  - id: precursor_mass_lower
    default: -20
    source: precursor_mass_lower
  - id: precursor_mass_upper
    default: 20
    source: precursor_mass_upper
  - id: precursor_mass_units
    default: 1
    source: precursor_mass_units
  - id: precursor_true_tolerance
    default: 20
    source: precursor_true_tolerance
  - id: precursor_true_units
    default: 1
    source: precursor_true_units
  - id: fragment_mass_tolerance
    default: 20
    source: fragment_mass_tolerance
  - id: fragment_mass_units
    default: 1
    source: fragment_mass_units
  - id: calibrate_mass
    default: 0
    source: calibrate_mass
  - id: decoy_prefix
    default: rev_
    source: decoy_prefix
  - id: isotope_error
    default: -1/0/1/2/3
    source: isotope_error
  - id: precursor_mass_mode
    default: selected
  - id: localize_delta_mass
    default: '0'
  - id: fragment_ion_series
    default: b,y
  - id: search_enzyme_name
    default: stricttrypsin
    source: search_enzyme_name
  - id: search_enzyme_cutafter
    default: KR
    source: search_enzyme_cutafter
  - id: num_enzyme_termini
    default: 2
    source: num_enzyme_termini
  - id: allowed_missed_cleavage
    default: 2
    source: allowed_missed_cleavage
  - id: clip_nTerm_M
    default: 1
  - id: variable_mod_01
    default: 15.99490_M_3
    source: variable_mod_01
  - id: variable_mod_02
    default: 42.01060_[^_1
    source: variable_mod_02
  - id: variable_mod_03
    default: 229.162932_n^_1
    source: variable_mod_03
  - id: variable_mod_04
    default: 229.162932_S_1
    source: variable_mod_04
  - id: allow_multiple_variable_mods_on_residue
    default: 0
  - id: max_variable_mods_per_peptide
    default: 3
  - id: max_variable_mods_combinations
    default: 5000
  - id: output_file_extension
    default: pepXML
  - id: output_format
    default: pepXML
  - id: output_report_topN
    default: 1
    source: output_report_topN
  - id: output_max_expect
    default: 50
  - id: report_alternative_proteins
    default: 0
  - id: precursor_charge
    default: '1_6'
    source: precursor_charge
  - id: override_charge
    default: 0
  - id: digest_min_length
    default: 7
    source: digest_min_length
  - id: digest_max_length
    default: 50
    source: digest_max_length
  - id: digest_mass_range
    default: 500.0_5000.0
  - id: max_fragment_charge
    default: 2
    source: max_fragment_charge
  - id: track_zero_topN
    default: 0
  - id: zero_bin_accept_expect
    default: 0
  - id: zero_bin_mult_expect
    default: 1
  - id: add_topN_complementary
    default: 0
  - id: minimum_peaks
    default: 15
  - id: use_topN_peaks
    default: 300
  - id: deisotope
    default: 1
    source: deisotope
  - id: min_fragments_modelling
    default: 3
  - id: min_matched_fragments
    default: 4
  - id: minimum_ratio
    default: 0.01
  - id: clear_mz_range
    default: 125.5_131.5
  - id: remove_precursor_peak
    default: 0
  - id: add_Cterm_peptide
    source: add_Cterm_peptide
  - id: add_Nterm_peptide
    source: add_Nterm_peptide
  - id: add_Cterm_protein
    source: add_Cterm_protein
  - id: add_Nterm_protein
    source: add_Nterm_protein
  - id: add_G_glycine
    source: add_G_glycine
  - id: add_A_alanine
    source: add_A_alanine
  - id: add_S_serine
    source: add_S_serine
  - id: add_P_proline
    source: add_P_proline
  - id: add_V_valine
    source: add_V_valine
  - id: add_T_threonine
    source: add_T_threonine
  - id: add_C_cysteine
    default: 57.021464
    source: add_C_cysteine
  - id: add_L_leucine
    source: add_L_leucine
  - id: add_I_isoleucine
    source: add_I_isoleucine
  - id: add_N_asparagine
    source: add_N_asparagine
  - id: add_D_aspartic_acid
    source: add_D_aspartic_acid
  - id: add_Q_glutamine
    source: add_Q_glutamine
  - id: add_K_lysine
    default: 229.162932
    source: add_K_lysine
  - id: add_E_glutamic_acid
    source: add_E_glutamic_acid
  - id: add_M_methionine
    source: add_M_methionine
  - id: add_H_histidine
    source: add_H_histidine
  - id: add_F_phenylalanine
    source: add_F_phenylalanine
  - id: add_R_arginine
    source: add_R_arginine
  - id: add_Y_tyrosine
    source: add_Y_tyrosine
  - id: add_W_tryptophan
    source: add_W_tryptophan
  - id: add_B_user_amino_acid
    source: add_B_user_amino_acid
  - id: add_J_user_amino_acid
    source: add_J_user_amino_acid
  - id: add_O_user_amino_acid
    source: add_O_user_amino_acid
  - id: add_U_user_amino_acid
    source: add_U_user_amino_acid
  - id: add_X_user_amino_acid
    source: add_X_user_amino_acid
  - id: add_Z_user_amino_acid
    source: add_Z_user_amino_acid
  - id: mzML
    source:
    - msconvert/mzML
  - id: diagnostic_intensity_filter
    default: 0
  - id: restrict_deltamass_to
    default: all
  - id: labile_search_mode
    default: off
  - id: mass_diff_to_variable_mod
    default: 0
  - id: intensity_transform
    default: 0
  run:
    cwlVersion: v1.1
    class: CommandLineTool
    label: MSFragger
    doc: |-
      ```
      To perform a search either use a parameter file:
                      1) java -jar MSFragger.jar <parameter file> <list of mzML/mzXML/MGF/RAW/.d files>
              Or specify options on the command line:
                      2) java -jar MSFragger.jar <options> <list of mzML/mzXML/MGF/RAW/.d files>

      To generate default parameter files use --config flag. E.g. "java -jar MSFragger.jar --config"

      ```
    $namespaces:
      sbg: https://sevenbridges.com

    requirements:
    - class: ShellCommandRequirement
    - class: ResourceRequirement
      coresMin: 2
      ramMin: 8000
    - class: DockerRequirement
      dockerPull: cgc-images.sbgenomics.com/david.roberson/msfragger:3.2
    - class: InitialWorkDirRequirement
      listing:
      - $(inputs.mzML)
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
    - id: database_name
      doc: Path to the protein database file in FASTA format.
      type: File
      inputBinding:
        prefix: --database_name
        position: 5
        shellQuote: false
    - id: precursor_mass_lower
      doc: Lower bound of the precursor mass window.
      type: int?
      default: -20
      inputBinding:
        prefix: --precursor_mass_lower
        position: 5
        shellQuote: false
    - id: precursor_mass_upper
      doc: Upper bound of the precursor mass window.
      type: int?
      default: 20
      inputBinding:
        prefix: --precursor_mass_upper
        position: 5
        shellQuote: false
    - id: precursor_mass_units
      doc: Precursor mass tolerance units (0 for Da, 1 for ppm).
      type: int?
      default: 1
      inputBinding:
        prefix: --precursor_mass_units
        position: 5
        shellQuote: false
    - id: precursor_true_tolerance
      doc: True precursor mass tolerance (window is +/- this value).
      type: int?
      default: 20
      inputBinding:
        prefix: --precursor_true_tolerance
        position: 5
        shellQuote: false
    - id: precursor_true_units
      doc: True precursor mass tolerance units (0 for Da, 1 for ppm).
      type: int?
      default: 1
      inputBinding:
        prefix: --precursor_true_units
        position: 5
        shellQuote: false
      sbg:toolDefaultValue: '1'
    - id: fragment_mass_tolerance
      doc: Fragment mass tolerance (window is +/- this value).
      type: int?
      default: 20
      inputBinding:
        prefix: --fragment_mass_tolerance
        position: 6
        shellQuote: false
    - id: fragment_mass_units
      doc: Fragment mass tolerance units (0 for Da, 1 for ppm).
      type: int?
      default: 1
      inputBinding:
        prefix: --fragment_mass_units
        position: 7
        shellQuote: false
    - id: calibrate_mass
      doc: |-
        Perform mass calibration (0 for OFF, 1 for ON, 2 for ON and find optimal parameters).
      type: int?
      default: 0
      inputBinding:
        prefix: --calibrate_mass
        position: 8
        shellQuote: false
    - id: write_calibrated_mgf
      doc: Write calibrated MS2 scan to a MGF file (0 for No, 1 for Yes).
      type: int?
      default: 1
      inputBinding:
        prefix: --write_calibrated_mgf
        position: 9
        shellQuote: false
    - id: decoy_prefix
      doc: Prefix added to the decoy protein ID.
      type: string?
      default: rev_
      inputBinding:
        prefix: --decoy_prefix
        position: 10
        shellQuote: false
    - id: isotope_error
      doc: Also search for MS/MS events triggered on specified isotopic peaks.
      type: string?
      default: 0/1/2
      inputBinding:
        prefix: --isotope_error
        position: 11
        shellQuote: false
      sbg:toolDefaultValue: -1/0/1/2/3
    - id: mass_offsets
      doc: Creates multiple precursor tolerance windows with specified mass offsets.
      type: int?
      default: 0
      inputBinding:
        prefix: --mass_offsets
        position: 12
        shellQuote: false
    - id: precursor_mass_mode
      doc: One of isolated/selected/recalculated.
      type: string?
      default: selected
      inputBinding:
        prefix: --precursor_mass_mode
        position: 13
        shellQuote: false
    - id: localize_delta_mass
      doc: |-
        Include fragment ions mass-shifted by unknown modifications (recommended for open and mass offset searches) (0 for OFF, 1 for ON).
      type: string?
      inputBinding:
        prefix: --localize_delta_mass
        position: 14
        shellQuote: false
      sbg:toolDefaultValue: 'false'
    - id: fragment_ion_series
      doc: Ion series used in search, specify any of a,b,c,x,y,z (comma separated).
      type: string?
      default: b,y
      inputBinding:
        prefix: --fragment_ion_series
        position: 15
        shellQuote: false
    - id: search_enzyme_name
      doc: Name of enzyme to be written to the pepXML file.
      type: string?
      default: Trypsin
      inputBinding:
        prefix: --search_enzyme_name
        position: 16
        shellQuote: false
    - id: search_enzyme_cutafter
      doc: Residues after which the enzyme cuts.
      type: string?
      default: KR
      inputBinding:
        prefix: --search_enzyme_cutafter
        position: 17
        shellQuote: false
    - id: search_enzyme_butnotafter
      doc: Residues that the enzyme will not cut before.
      type: string?
      default: P
      inputBinding:
        prefix: --search_enzyme_butnotafter
        position: 18
        shellQuote: false
    - id: num_enzyme_termini
      doc: 0 for non-enzymatic, 1 for semi-enzymatic, and 2 for fully-enzymatic.
      type: int?
      default: 2
      inputBinding:
        prefix: --num_enzyme_termini
        position: 19
        shellQuote: false
    - id: allowed_missed_cleavage
      doc: Allowed number of missed cleavages per peptide. Maximum value is 5.
      type: int?
      default: 1
      inputBinding:
        prefix: --allowed_missed_cleavage
        position: 20
        shellQuote: false
    - id: clip_nTerm_M
      doc: |-
        Specifies the trimming of a protein N-terminal methionine as a variable modification (0 or 1).
      type: int?
      default: 1
      inputBinding:
        prefix: --clip_nTerm_M
        position: 21
        shellQuote: false
    - id: variable_mod_01
      type: string?
      default: 15.99490_M_3
      inputBinding:
        prefix: --variable_mod_01
        position: 22
        shellQuote: false
    - id: variable_mod_02
      type: string?
      default: 42.01060_[^_1
      inputBinding:
        prefix: --variable_mod_02
        position: 23
        shellQuote: false
    - id: variable_mod_03
      type: string?
      inputBinding:
        prefix: --variable_mod_03
        position: 24
        shellQuote: false
    - id: variable_mod_04
      type: string?
      inputBinding:
        prefix: --variable_mod_04
        position: 25
        shellQuote: false
    - id: variable_mod_05
      type: string?
      inputBinding:
        prefix: --variable_mod_05
        position: 26
        shellQuote: false
    - id: allow_multiple_variable_mods_on_residue
      doc: Allow each residue to be modified by multiple variable modifications (0
        or 1).
      type: int?
      inputBinding:
        prefix: --allow_multiple_variable_mods_on_residue
        position: 27
        shellQuote: false
    - id: max_variable_mods_per_peptide
      doc: Maximum total number of variable modifications per peptide.
      type: int?
      default: 3
      inputBinding:
        prefix: --max_variable_mods_per_peptide
        position: 28
        shellQuote: false
    - id: max_variable_mods_combinations
      doc: Maximum number of modified forms allowed for each peptide (up to 65534).
      type: int?
      default: 5000
      inputBinding:
        prefix: --max_variable_mods_combinations
        position: 29
        shellQuote: false
    - id: output_file_extension
      doc: File extension of output files.
      type: string?
      default: pepXML
      inputBinding:
        prefix: --output_file_extension
        position: 30
        shellQuote: false
    - id: output_format
      doc: File format of output files (pepXML or tsv).
      type: string?
      default: pepXML
      inputBinding:
        prefix: --output_format
        position: 31
        shellQuote: false
    - id: output_report_topN
      doc: Reports top N PSMs per input spectrum.
      type: int?
      default: 1
      inputBinding:
        prefix: --output_report_topN
        position: 32
        shellQuote: false
    - id: output_max_expect
      doc: |-
        Suppresses reporting of PSM if top hit has expectation value greater than this threshold.
      type: int?
      default: 50
      inputBinding:
        prefix: --output_max_expect
        position: 33
        shellQuote: false
    - id: report_alternative_proteins
      doc: |-
        Report alternative proteins for peptides that are found in multiple proteins (0 for no, 1 for yes).
      type: int?
      default: 0
      inputBinding:
        prefix: --report_alternative_proteins
        position: 34
        shellQuote: false
    - id: precursor_charge
      doc: |-
        Assumed range of potential precursor charge states. Only relevant when override_charge is set to 1.
      type: string?
      default: '1_4'
      inputBinding:
        prefix: --precursor_charge
        position: 35
        shellQuote: false
    - id: override_charge
      doc: |-
        Ignores precursor charge and uses charge state specified in precursor_charge range (0 or 1).
      type: int?
      default: 0
      inputBinding:
        prefix: --override_charge
        position: 36
        shellQuote: false
    - id: digest_min_length
      doc: Minimum length of peptides to be generated during in-silico digestion.
      type: int?
      default: 7
      inputBinding:
        prefix: --digest_min_length
        position: 37
        shellQuote: false
    - id: digest_max_length
      doc: Maximum length of peptides to be generated during in-silico digestion.
      type: int?
      default: 50
      inputBinding:
        prefix: --digest_max_length
        position: 38
        shellQuote: false
    - id: digest_mass_range
      doc: Mass range of peptides to be generated during in-silico digestion in Daltons.
      type: string?
      default: 500.0_5000.0
      inputBinding:
        prefix: --digest_mass_range
        position: 39
        shellQuote: false
    - id: max_fragment_charge
      doc: Maximum charge state for theoretical fragments to match (1-4).
      type: int?
      default: 2
      inputBinding:
        prefix: --max_fragment_charge
        position: 40
        shellQuote: false
    - id: track_zero_topN
      doc: |-
        Track top N unmodified peptide results separately from main results internally for boosting features. Should be set to a number greater than output_report_topN if zero bin boosting is desired.
      type: int?
      default: 0
      inputBinding:
        prefix: --track_zero_topN
        position: 41
        shellQuote: false
    - id: zero_bin_accept_expect
      doc: |-
        Ranks a zero-bin hit above all non-zero-bin hit if it has expectation less than this value.
      type: float?
      default: 0
      inputBinding:
        prefix: --zero_bin_accept_expect
        position: 42
        shellQuote: false
    - id: zero_bin_mult_expect
      doc: |-
        Multiplies expect value of PSMs in the zero-bin during  results ordering (set to less than 1 for boosting).
      type: float?
      default: 1
      inputBinding:
        prefix: --zero_bin_mult_expect
        position: 43
        shellQuote: false
    - id: add_topN_complementary
      doc: |-
        Inserts complementary ions corresponding to the top N most intense fragments in each experimental spectra.
      type: int?
      default: 0
      inputBinding:
        prefix: --add_topN_complementary
        position: 44
        shellQuote: false
    - id: minimum_peaks
      doc: Minimum number of peaks in experimental spectrum for matching.
      type: int?
      default: 15
      inputBinding:
        prefix: --minimum_peaks
        position: 45
        shellQuote: false
    - id: use_topN_peaks
      doc: Pre-process experimental spectrum to only use top N peaks.
      type: int?
      default: 150
      inputBinding:
        prefix: --use_topN_peaks
        position: 46
        shellQuote: false
    - id: deisotope
      doc: Perform deisotoping or not.
      type: int?
      default: 0
      inputBinding:
        prefix: --deisotope
        position: 47
        shellQuote: false
    - id: min_fragments_modelling
      doc: Minimum number of matched peaks in PSM for inclusion in statistical modeling.
      type: int?
      default: 2
      inputBinding:
        prefix: --min_fragments_modelling
        position: 48
        shellQuote: false
    - id: min_matched_fragments
      doc: Minimum number of matched peaks for PSM to be reported.
      type: int?
      default: 4
      inputBinding:
        prefix: --min_matched_fragments
        position: 49
        shellQuote: false
    - id: minimum_ratio
      doc: |-
        Filters out all peaks in experimental spectrum less intense than this multiple of the base peak intensity.
      type: float?
      default: 0.01
      inputBinding:
        prefix: --minimum_ratio
        position: 50
        shellQuote: false
    - id: clear_mz_range
      doc: Removes peaks in this m/z range prior to matching.
      type: string?
      default: 0.0_0.0
      inputBinding:
        prefix: --clear_mz_range
        position: 51
        shellQuote: false
    - id: remove_precursor_peak
      doc: |-
        Remove precursor peaks from tandem mass spectra. 0 = not remove; 1 = remove the peak with precursor charge; 2 = remove the peaks with all charge states.
      type: int?
      default: 0
      inputBinding:
        prefix: --remove_precursor_peak
        position: 52
        shellQuote: false
    - id: add_Cterm_peptide
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Cterm_peptide
        position: 53
        shellQuote: false
    - id: add_Nterm_peptide
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Nterm_peptide
        position: 54
        shellQuote: false
    - id: add_Cterm_protein
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Cterm_protein
        position: 55
        shellQuote: false
    - id: add_Nterm_protein
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Nterm_protein
        position: 56
        shellQuote: false
    - id: add_G_glycine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_G_glycine
        position: 57
        shellQuote: false
    - id: add_A_alanine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_A_alanine
        position: 58
        shellQuote: false
    - id: add_S_serine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_S_serine
        position: 59
        shellQuote: false
    - id: add_P_proline
      type: float?
      default: 0
      inputBinding:
        prefix: --add_P_proline
        position: 60
        shellQuote: false
    - id: add_V_valine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_V_valine
        position: 61
        shellQuote: false
    - id: add_T_threonine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_T_threonine
        position: 62
        shellQuote: false
    - id: add_C_cysteine
      type: float?
      default: 57.021464
      inputBinding:
        prefix: --add_C_cysteine
        position: 63
        shellQuote: false
    - id: add_L_leucine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_L_leucine
        position: 64
        shellQuote: false
    - id: add_I_isoleucine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_I_isoleucine
        position: 65
        shellQuote: false
    - id: add_N_asparagine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_N_asparagine
        position: 66
        shellQuote: false
    - id: add_D_aspartic_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_D_aspartic_acid
        position: 67
        shellQuote: false
    - id: add_Q_glutamine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Q_glutamine
        position: 68
        shellQuote: false
    - id: add_K_lysine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_K_lysine
        position: 69
        shellQuote: false
    - id: add_E_glutamic_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_E_glutamic_acid
        position: 70
        shellQuote: false
    - id: add_M_methionine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_M_methionine
        position: 71
        shellQuote: false
    - id: add_H_histidine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_H_histidine
        position: 72
        shellQuote: false
    - id: add_F_phenylalanine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_F_phenylalanine
        position: 73
        shellQuote: false
    - id: add_R_arginine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_R_arginine
        position: 74
        shellQuote: false
    - id: add_Y_tyrosine
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Y_tyrosine
        position: 75
        shellQuote: false
    - id: add_W_tryptophan
      type: float?
      default: 0
      inputBinding:
        prefix: --add_W_tryptophan
        position: 76
        shellQuote: false
    - id: add_B_user_amino_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_B_user_amino_acid
        position: 77
        shellQuote: false
    - id: add_J_user_amino_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_J_user_amino_acid
        position: 78
        shellQuote: false
    - id: add_O_user_amino_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_O_user_amino_acid
        position: 79
        shellQuote: false
    - id: add_U_user_amino_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_U_user_amino_acid
        position: 80
        shellQuote: false
    - id: add_X_user_amino_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_X_user_amino_acid
        position: 81
        shellQuote: false
    - id: add_Z_user_amino_acid
      type: float?
      default: 0
      inputBinding:
        prefix: --add_Z_user_amino_acid
        position: 82
        shellQuote: false
    - id: Xmx
      type: int?
      default: 8
    - id: mzML
      type: File[]
    - id: input
      type: File?
      inputBinding:
        position: 300
        shellQuote: false
    - id: diagnostic_intensity_filter
      label: diagnostic intensity filter
      doc: |-
        nglycan/labile search_mode only]. Minimum relative intensity for SUM of all detected oxonium ions to achieve for spectrum to contain diagnostic fragment evidence. Calculated relative to spectrum base peak. Default (0).
      type: int?
      default: 0
      inputBinding:
        prefix: --diagnostic_intensity_filter
        position: 5
        shellQuote: false
    - id: restrict_deltamass_to
      label: restrict deltamass to
      doc: |-
        Specify amino acids on which delta masses (mass offsets or search modifications) can occur. Allowed values are single letter codes (e.g. ACD). Default (all).
      type: string?
      default: all
      inputBinding:
        prefix: --restrict_deltamass_to
        position: 5
        shellQuote: false
    - id: labile_search_mode
      label: labile search mode
      doc: |-
        type of search (nglycan, labile, or off). Off means non-labile/typical search. Default (off).
      type: string?
      default: off
      inputBinding:
        prefix: --labile_search_mode
        position: 5
        shellQuote: false
    - id: mass_diff_to_variable_mod
      label: mass diff to variable mod
      doc: |-
        Put mass diff as a variable modification. 0 for no; 1 for yes and change the original mass diff and the calculated mass accordingly; 2 for yes but do not change the original mass diff. Default (0).
      type: int?
      default: -1
      inputBinding:
        prefix: --mass_diff_to_variable_mod
        position: 5
        shellQuote: false
    - id: intensity_transform
      label: intensity transform
      doc: |-
        transform peaks intensities with sqrt root. 0=not transform; 1=transform using sqrt root. Default (0).
      type: int?
      default: 0
      inputBinding:
        prefix: --intensity_transform
        position: 5
        shellQuote: false

    outputs:
    - id: standard_out
      type: File
      outputBinding:
        glob: $(inputs.mzML[0].metadata["Plex or dataset name"]).msfragger.log
        outputEval: $(inheritMetadata(self, inputs.mzML))
    - id: pepxml
      type: File[]
      outputBinding:
        glob: '*.pepXML'
        outputEval: $(inheritMetadata(self, inputs.mzML))
    - id: mgf
      type: File?
      outputBinding:
        glob: '*.mgf'
        outputEval: $(inheritMetadata(self, inputs.mzML))
    stdout: $(inputs.mzML[0].metadata["Plex or dataset name"]).msfragger.log

    baseCommand:
    - java
    arguments:
    - prefix: -Xmx
      position: 3
      valueFrom: $(inputs.Xmx)G
      separate: false
      shellQuote: false
    - prefix: -jar
      position: 3
      valueFrom: /data/MSFragger-3.2/MSFragger-3.2.jar *.mzML
      shellQuote: false
    id: david.roberson/pdc-webinar-dev/msfragger/6
    'null':
    sbg:appVersion:
    - v1.1
    sbg:content_hash: aea7d16747cb29b1e820f9c2a4305373a8088a3b765e7a0495c6e55b139d25048
    sbg:contributors:
    - david.roberson
    - prvst
    sbg:createdBy: david.roberson
    sbg:createdOn: 1617031664
    sbg:id: david.roberson/pdc-webinar-dev/msfragger/6
    sbg:image_url:
    sbg:latestRevision: 6
    sbg:modifiedBy: prvst
    sbg:modifiedOn: 1617294992
    sbg:project: david.roberson/pdc-webinar-dev
    sbg:projectName: PDC Webinar Dev
    sbg:publisher: sbg
    sbg:revision: 6
    sbg:revisionNotes: ''
    sbg:revisionsInfo:
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1617031664
      sbg:revision: 0
      sbg:revisionNotes: |-
        Uploaded using sbpack v2020.10.05. 
        Source: 
        repo: https://github.com/davidroberson/shotgun_proteomics.git
        file: tools/msfragger/msfragger.cwl
        commit: 31fdf12
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1617033967
      sbg:revision: 1
      sbg:revisionNotes: updated docker
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1617033983
      sbg:revision: 2
      sbg:revisionNotes: updated docker
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1617092887
      sbg:revision: 3
      sbg:revisionNotes: ''
    - sbg:modifiedBy: prvst
      sbg:modifiedOn: 1617121674
      sbg:revision: 4
      sbg:revisionNotes: ''
    - sbg:modifiedBy: david.roberson
      sbg:modifiedOn: 1617288472
      sbg:revision: 5
      sbg:revisionNotes: corrected positions of some new flags
    - sbg:modifiedBy: prvst
      sbg:modifiedOn: 1617294992
      sbg:revision: 6
      sbg:revisionNotes: ''
    sbg:sbgMaintained: false
    sbg:validationErrors: []
  out:
  - id: standard_out
  - id: pepxml
  - id: mgf
  sbg:x: 455
  sbg:y: 64

hints:
- class: sbg:maxNumberOfParallelInstances
  value: '1'
- class: sbg:AWSInstanceType
  value: c5.4xlarge;ebs-gp2;200
id: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe_Convert_Identify_PeptideProphet/1/raw/
sbg:appVersion:
- v1.1
sbg:categories:
- Proteomics
sbg:content_hash: a4184df8fd552927e503c19b244c94babcc6f00f1182c23200e44910dabbfcd33
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618924744
sbg:id: |-
  david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe_Convert_Identify_PeptideProphet/1
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/FragPipe_Convert_Identify_PeptideProphet/1.png
sbg:latestRevision: 1
sbg:license: EULA for MSFragger
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618928636
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/pdc-workshop/conversion-and-peptide-prophet/6/raw/
sbg:project: david.roberson/build-fragpipe-proteomics-pipeline-tutorial
sbg:projectName: 'BUILD: FragPipe Proteomics Pipeline Tutorial'
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: added a tag
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618924744
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: apps/FragPipe_Convert_Identify_PeptideProphet/FragPipe_Convert_Identify_PeptideProphet.cwl
    commit: 2054e80
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618928636
  sbg:revision: 1
  sbg:revisionNotes: added a tag
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
