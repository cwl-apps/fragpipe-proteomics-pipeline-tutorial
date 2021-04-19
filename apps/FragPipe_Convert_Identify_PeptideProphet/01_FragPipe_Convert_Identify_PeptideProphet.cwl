cwlVersion: v1.1
class: Workflow
label: '01 FragPipe:  Convert - Identify - PeptideProphet'
doc: |-
  The first step of the workflow consists of converting the raw mass spectrometry data to the mzML format using msconvert, followed by the database search using MSFragger, and the peptide validation using PeptideProphet.
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
  run: 01_FragPipe_Convert_Identify_PeptideProphet.cwl.steps/peptide_prophet.cwl
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
  run: 01_FragPipe_Convert_Identify_PeptideProphet.cwl.steps/workspace.cwl
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
  run: 01_FragPipe_Convert_Identify_PeptideProphet.cwl.steps/msconvert.cwl
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
  run: 01_FragPipe_Convert_Identify_PeptideProphet.cwl.steps/database.cwl
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
  run: 01_FragPipe_Convert_Identify_PeptideProphet.cwl.steps/msfragger.cwl
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
sbg:appVersion:
- v1.1
sbg:content_hash: a657093fd574fffad4b4f4f5662630fb7a3429a3dca4ac4082b4f42640a3c457c
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618420234
sbg:id: david.roberson/pdc-workshop/conversion-and-peptide-prophet/6
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/pdc-workshop/conversion-and-peptide-prophet/6.png
sbg:latestRevision: 6
sbg:license: EULA for MSFragger
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618798917
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/pdc-workshop/conversion-and-peptide-prophet/6/raw/
sbg:project: david.roberson/pdc-workshop
sbg:projectName: PDC Workshop and Public Project Dev
sbg:publisher: sbg
sbg:revision: 6
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618420234
  sbg:revision: 0
  sbg:revisionNotes: Copy of david.roberson/pdc-webinar-devl-2/conversion-and-peptide-prophet/4
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618421363
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618421468
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618497340
  sbg:revision: 3
  sbg:revisionNotes: c5.2xlarge 200GB
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618503291
  sbg:revision: 4
  sbg:revisionNotes: c5.4xlarge 200GB 1 Max Instance
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618600962
  sbg:revision: 5
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618798917
  sbg:revision: 6
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
