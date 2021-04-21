cwlVersion: v1.1
class: Workflow
label: 'FragPipe:  Convert - Identify - PeptideProphet'
doc: |-
  The first step of the workflow consists of converting the raw mass spectrometry data to the mzML format using msconvert, followed by the database search using MSFragger, and the peptide validation using PeptideProphet.

  #End-user license agreement (EULA)

  A central tool in this workflow is MSFragger which can only be used for academic research, non-commercial or educational purposes.  To run this workflow you must accept the EULA below.

  ```
  #7143 - MSFragger - Academic and Research Education Use License

  This license includes a digital file, available for download after the license agreement has been executed and approved (if necessary) which includes the University of Michigan PROGRAM.


  NOTICE: MSFragger utilizes the MSFTBX library to read mzXML and mzML files. The MSFTBX uses third-party software that is subject to open source and/or third-party license terms. These terms are attached in the file LICENSE-3RD-PARTY.txt. By accepting the terms and conditions of this Agreement, LICENSEE will also be subject to those terms and conditions.


  PROGRAM: MSFragger UM # 7143 - Philosopher Pipeline Distribution Permissions - Cancer Genomics Cloud


  This Agreement is made by and between The Regents of The University of Michigan, a constitutional corporation of the state of Michigan (hereinafter "MICHIGAN") and LICENSEE.


  BACKGROUND

  1. Members of the University of Michigan’s Medical School Departments of Pathology and Computational Medicine and Bioinformatics have developed a proprietary software application and related documentation for peptide identification referred to as “MSFragger”, for use by trained individuals in bioinformatics and proteomics research (hereinafter referred to as "PROGRAM"); and

  2. LICENSEE desires to obtain, and MICHIGAN, consistent with its mission of education and research, desires to grant, a license to use the PROGRAM subject to the terms and conditions set forth below; and

  The parties therefore agree as follows:


  I. LICENSE

  MICHIGAN hereby grants to LICENSEE a non-exclusive, non-transferable right to use the PROGRAM solely for academic research, non-commercial or educational purposes within the LICENSEE’s department and subject to the terms and conditions of this Agreement. Commercial use of any kind of the PROGRAM is strictly prohibited. This license is solely for deployment of the PROGRAM in conjunction with the Cancer Genomics Cloud project. No other license rights are granted.


  II. LIMITATION OF LICENSE AND RESTRICTIONS

  A. LICENSEE shall not use, print, copy, translate, reverse engineer, decompile, disassemble, modify, create derivative works of or publicly display the PROGRAM, in whole or in part, unless expressly authorized by this Agreement.

  B. LICENSEE agrees that it shall use the PROGRAM only for LICENSEE'S sole and exclusive use, and shall not disclose, sell, license, or otherwise distribute the PROGRAM, in whole or in part, to any third party without the prior written consent of MICHIGAN. LICENSEE shall not assign this Agreement, and any attempt by LICENSEE to assign it shall be void from the beginning. LICENSEE agrees to secure and protect the PROGRAM and any copies of the PROGRAM in a manner consistent with the maintenance of MICHIGAN'S rights in the PROGRAM and to take appropriate action by instruction or agreement with its employees who are permitted access to the PROGRAM in order to satisfy LICENSEE'S obligations under this Agreement.

  C. LICENSEE may copy the PROGRAM for the purpose of using the PROGRAM on other devices and for archival purposes.

  D. Such license shall be only for its intended use and in accordance with applicable Food and Drug Administration (FDA) regulations for pre-clinical and clinical research, including, but not limited to, applicable investigational device exemption (IDE) regulations, institutional review board (IRB) approval, required protocols and monitoring of the study, required records and reports, and applicable protection of human subjects regulations.

  E. LICENSEE agrees to acknowledge MICHIGAN in scientific publications resulting (in part) of the use of the PROGRAM, by making reference to the publication of the PROGRAM when it becomes available in the scientific literature. Copyright notice should be as follows, “MSFragger © 2016 The Regents of the University of Michigan.”


  III. CONSIDERATION

  A no-cost option for the license rights granted in this Agreement.


  IV. TITLE AND OWNERSHIP

  A. No ownership rights of MICHIGAN in the PROGRAM are conferred upon LICENSEE by this Agreement.

  B. LICENSEE acknowledges MICHIGAN'S proprietary rights in the PROGRAM and agrees to reproduce all copyright notices supplied by MICHIGAN on all copies of the PROGRAM.

  C. LICENSEE agrees this license is explicitly for academic research applications only and that it cannot be used for commercial purposes of any kind. LICENSEE further acknowledges that any use in a commercial setting will be subject to prosecution to the fullest extent available under the law and remedies may include full recovery of legal, operational, economic and other losses which the LICENSEE will be directly liable for.


  V. DISCLAIMER OF WARRANTY AND LIMITATION OF LIABILITY

  A. THE PROGRAM IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. MICHIGAN DOES NOT WARRANT THAT THE FUNCTIONS CONTAINED IN THE PROGRAM WILL MEET LICENSEE'S REQUIREMENTS OR THAT OPERATION WILL BE UNINTERRUPTED OR ERROR FREE. MICHIGAN shall not be liable for special, indirect, incidental, or consequential damages with respect to any claim on account of or arising from this Agreement or use of the PROGRAM, even if MICHIGAN has been or is hereafter advised of the possibility of such damages. Because some states do not allow certain exclusions or limitations on implied warranties or of liability for consequential or incidental damages, the above exclusions may not apply to LICENSEE. In no event, however, will MICHIGAN be liable to LICENSEE, under any theory of recovery, in an amount in excess of the license fee paid by LICENSEE under this Agreement.

  B. LICENSEE agrees that MICHIGAN has no obligation to provide to LICENSEE any maintenance, support, or update services. Should MICHIGAN provide any revised versions of the PROGRAM to LICENSEE, LICENSEE agrees that this license agreement shall apply to such revised versions.


  VI. WARRANTY OF LICENSEE

  LICENSEE warrants and represents that it will carefully review any documentation or instructional material provided by MICHIGAN.


  VIII. TERMINATION

  If LICENSEE at any time fails to abide by the terms of this Agreement, MICHIGAN shall have the right to immediately terminate the license granted herein, require the return or destruction of all copies of the PROGRAM from LICENSEE and certification in writing as to such return or destruction, and pursue any other legal or equitable remedies available.


  VIII. MISCELLANEOUS

  A. This Agreement shall be construed in accordance with the laws of the state of Michigan. Should LICENSEE for any reason bring a claim, demand, or other action against MICHIGAN, its agents or employees, arising out of this Agreement or the PROGRAM licensed herein, LICENSEE agrees to bring said claim only in the Michigan Court of Claims.

  B. THIS AGREEMENT REPRESENTS THE COMPLETE AND EXCLUSIVE STATEMENT OF THE AGREEMENT BETWEEN MICHIGAN AND LICENSEE AND SUPERSEDES ALL PRIOR AGREEMENTS, PROPOSALS, REPRESENTATIONS AND OTHER COMMUNICATIONS, VERBAL OR WRITTEN, BETWEEN THEM WITH RESPECT TO USE OF THE PROGRAM. THIS AGREEMENT MAY BE MODIFIED ONLY WITH THE MUTUAL WRITTEN APPROVAL OF AUTHORIZED REPRESENTATIVES OF THE PARTIES.

  C. The terms and conditions of this Agreement shall prevail notwithstanding any different, conflicting, or additional terms or conditions which may appear in any purchase order or other document submitted by LICENSEE. LICENSEE agrees that such additional or inconsistent terms are deemed rejected by MICHIGAN.

  D. Unless otherwise exempt therefrom, LICENSEE agrees that it will be responsible for any sales, use or excise taxes imposed by any governmental unit in this transaction except income taxes.

  E. LICENSEE acknowledges that the PROGRAM is of United States origin. LICENSEE agrees to comply with all applicable international and national laws that apply to the PROGRAM, including the United States Export Administration Regulations, as well as end-user, end-use, and destination restrictions issued by the United States.

  F. MICHIGAN and LICENSEE agree that any xerographically or electronically reproduced copy of this fully-executed agreement shall have the same legal force and effect as any copy bearing original signatures of the parties.

  G. MSFragger utilizes the MSFTBX library to read mzXML and mzML files. The MSFTBX uses third-party software that is subject to open source and/or third-party license terms. These terms are attached in the file LICENSE-3RD-PARTY.txt. By accepting the terms and conditions of this Agreement, LICENSEE will also be subject to those terms and conditions
  ```
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
- id: EULA
  label: Accept End Level User Agreement
  type: boolean
  sbg:x: 36.55677032470703
  sbg:y: 223.6128692626953
- id: write_calibrated_mgf
  doc: Write calibrated MS2 scan to a MGF file (0 for No, 1 for Yes).
  type: int?
  sbg:exposed: true
- id: variable_mod_05
  type: string?
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
  run: fragpipe-convert-identify-peptideprophet.cwl.steps/peptide_prophet.cwl
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
  run: fragpipe-convert-identify-peptideprophet.cwl.steps/workspace.cwl
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
  run: fragpipe-convert-identify-peptideprophet.cwl.steps/msconvert.cwl
  out:
  - id: std_out
  - id: mzML
  sbg:x: 253.42431640625
  sbg:y: 336.7692565917969
- id: database
  label: Philosopher Database
  in:
  - id: annotate
    source: database_name
  - id: workspace_in
    source: workspace/workspace
  run: fragpipe-convert-identify-peptideprophet.cwl.steps/database.cwl
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
  - id: precursor_mass_upper
    default: 20
  - id: precursor_mass_units
    default: 1
  - id: precursor_true_tolerance
    default: 20
  - id: precursor_true_units
    default: 1
  - id: fragment_mass_units
    default: 1
  - id: calibrate_mass
    default: 0
  - id: write_calibrated_mgf
    source: write_calibrated_mgf
  - id: precursor_mass_mode
    default: selected
  - id: localize_delta_mass
    default: '0'
  - id: fragment_ion_series
    default: b,y
  - id: clip_nTerm_M
    default: 1
  - id: variable_mod_05
    source: variable_mod_05
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
  - id: output_max_expect
    default: 50
  - id: report_alternative_proteins
    default: 0
  - id: override_charge
    default: 0
  - id: digest_mass_range
    default: 500.0_5000.0
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
  - id: EULA
    source: EULA
  run: fragpipe-convert-identify-peptideprophet.cwl.steps/msfragger.cwl
  out:
  - id: standard_out
  - id: pepxml
  - id: mgf
  sbg:x: 493.7692565917969
  sbg:y: 65.94041442871094

hints:
- class: sbg:maxNumberOfParallelInstances
  value: '1'
- class: sbg:AWSInstanceType
  value: c5.4xlarge;ebs-gp2;200
sbg:appVersion:
- v1.1
sbg:categories:
- Proteomics
sbg:content_hash: a8e0d4641eb2bb8f3c48e5a48eba61ed8b7876ef33596722ac2d4bcfb5f9a049f
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618968733
sbg:id: |-
  david.roberson/build-fragpipe-proteomics-pipeline-tutorial/fragpipe-convert-identify-peptideprophet/2
sbg:image_url: |-
  https://cgc.sbgenomics.com/ns/brood/images/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/fragpipe-convert-identify-peptideprophet/2.png
sbg:latestRevision: 2
sbg:license: EULA for MSFragger
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618979582
sbg:original_source: |-
  https://cgc-api.sbgenomics.com/v2/apps/david.roberson/build-fragpipe-proteomics-pipeline-tutorial/fragpipe-convert-identify-peptideprophet/2/raw/
sbg:project: david.roberson/build-fragpipe-proteomics-pipeline-tutorial
sbg:projectName: 'BUILD: FragPipe Proteomics Pipeline Tutorial'
sbg:publisher: sbg
sbg:revision: 2
sbg:revisionNotes: ''
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618968733
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: 
    commit: (uncommitted file)
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618978447
  sbg:revision: 1
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: FragPipe-Convert-Identify-PeptideProphet/fragpipe-convert-identify-peptideprophet.cwl
    commit: f6161f0
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618979582
  sbg:revision: 2
  sbg:revisionNotes: ''
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:toolkitVersion: v15.0
sbg:validationErrors: []
