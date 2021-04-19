cwlVersion: v1.1
class: CommandLineTool
label: tmt_integrator
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: ShellCommandRequirement
- class: ResourceRequirement
  ramMin: 30000
- class: DockerRequirement
  dockerPull: cgc-images.sbgenomics.com/david.roberson/tmt-integrator:2.4.0
- class: InitialWorkDirRequirement
  listing:
  - entryname: tmt-i.yml
    writable: false
    entry: |
      tmtintegrator:
        memory: 30                                      # memory allocation, in Gb
        protein_database: 2020-03-30-decoys-reviewed-contam-UP000005640.fas                            # protein fasta file
        output: ./                         # the location of output files
        channel_num: 10                                 # number of channels in the multiplex (e.g. 10, 11)
        ref_tag: pool                                  # unique tag for identifying the reference channel (Bridge sample added to each multiplex)
        groupby: -1                                     # level of data summarization(0: PSM aggregation to the gene level; 1: protein; 2: peptide sequence; 3: multiple PTM sites; 4: single PTM site; -1: generate reports at all levels)
        psm_norm: false                                 # perform additional retention time-based normalization at the PSM level
        outlier_removal: true                           # perform outlier removal
        prot_norm:  1                                   # normalization (0: None; 1: MD (median centering); 2: GN (median centering + variance scaling); -1: generate reports with all normalization options)
        min_pep_prob: 0.9                               # minimum PSM probability threshold (in addition to FDR-based filtering by Philosopher)
        min_purity: 0.5                                 # ion purity score threshold
        min_percent: 0.05                               # remove low intensity PSMs (e.g. value of 0.05 indicates removal of PSMs with the summed TMT reporter ions intensity in the lowest 5% of all PSMs)
        unique_pep: false                               # allow PSMs with unique peptides only (if true) or unique plus razor peptides (if false), as classified by Philosopher and defined in PSM.tsv files
        unique_gene: 0                                  # additional, gene-level uniqueness filter (0: allow all PSMs; 1: remove PSMs mapping to more than one GENE with evidence of expression in the dataset; 2:remove all PSMs mapping to more than one GENE in the fasta file)
        best_psm: true                                  # keep the best PSM only (highest summed TMT intensity) among all redundant PSMs within the same LC-MS run
        prot_exclude: none                              # exclude proteins with specified tags at the beginning of the accession number (e.g. none: no exclusion; sp|,tr| : exclude protein with sp| or tr|)
        allow_overlabel: true                           # allow PSMs with TMT on S (when overlabeling on S was allowed in the database search)
        allow_unlabeled: false                          # allow PSMs without TMT tag or acetylation on the peptide n-terminus 
        mod_tag: none                                   # PTM info for generation of PTM-specific reports (none: for Global data; S[167],T[181],Y[243]: for Phospho; K[170]: for K-Acetyl)
        min_site_prob: -1                               # site localization confidence threshold (-1: for Global; 0: as determined by the search engine; above 0 (e.g. 0.75): PTMProphet probability, to be used with phosphorylation only)
        ms1_int: true                                   # use MS1 precursor ion intensity (if true) or MS2 reference intensity (if false) as part of the reference sample abundance estimation 
        top3_pep: true                                  # use top 3 most intense peptide ions as part of the reference sample abundance estimation
        print_RefInt: false                             # print individual reference sample abundance estimates for each multiplex in the final reports (in addition to the combined reference sample abundance estimate)
        add_Ref: -1                                     # add an artificial reference channel if there is no reference channel or export raw abundance (-1: don't add the reference; 0: use summation as the reference; 1: use average as the reference; 2: use median as the reference; 3: export raw abundance)
        max_pep_prob_thres: 0                           # the threshold for maximum peptide probability
        min_ntt: 0                                      # minimum allowed number of enzymatic termini
  - $(inputs.database)
  - entryname: rename_reports.sh
    writable: false
    entry: "for file in *.tsv; do mv \"$file\" `echo $file | tr '=' '_'` ; done\n"
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
- id: psm_file
  type: File[]
  inputBinding:
    position: 0
    shellQuote: false
  sbg:fileTypes: TSV
- id: database
  type: File
  sbg:fileTypes: FAS

outputs:
- id: all_report_files
  type: File[]?
  outputBinding:
    glob: '*tsv'
    outputEval: $(inheritMetadata(self, inputs.psm_file))
- id: abundance_by_gene_report
  type: File?
  outputBinding:
    glob: '*Report_abundance_groupby_gene_protNorm_MD_gu_0.tsv'

baseCommand:
- java
- -Xmx30G
- -jar
- /data/TMTIntegrator_v2.4.0.jar
- tmt-i.yml
arguments:
- prefix: ''
  position: 99
  valueFrom: '&& bash rename_reports.sh'
  shellQuote: false

hints:
- class: sbg:SaveLogs
  value: '*.yml'
id: david.roberson/pdc-webinar-devl-2/tmt-integrator/17
sbg:appVersion:
- v1.1
sbg:content_hash: a830bb074c4c6a8f3271ea0cb33b80301f58cbd128bd158f85fa3a886acf38f92
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1617304592
sbg:id: david.roberson/pdc-webinar-devl-2/tmt-integrator/17
sbg:image_url:
sbg:latestRevision: 17
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618499393
sbg:project: david.roberson/pdc-webinar-devl-2
sbg:projectName: PDC Webinar Devl 2
sbg:publisher: sbg
sbg:revision: 17
sbg:revisionNotes: 30GB
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617304592
  sbg:revision: 0
  sbg:revisionNotes: Copy of david.roberson/pdc-webinar-dev/tmt-integrator/1
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617304814
  sbg:revision: 1
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617305397
  sbg:revision: 2
  sbg:revisionNotes: added Dockerfile
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617579206
  sbg:revision: 3
  sbg:revisionNotes: cgc-images.sbgenomics.com/david.roberson/tmt-integrator:2.4.0
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617583188
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1617995459
  sbg:revision: 5
  sbg:revisionNotes: 'reg_tag: pool'
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618422147
  sbg:revision: 6
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618488299
  sbg:revision: 7
  sbg:revisionNotes: rename files
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618488492
  sbg:revision: 8
  sbg:revisionNotes: added file types
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618488602
  sbg:revision: 9
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618490417
  sbg:revision: 10
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618493242
  sbg:revision: 11
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618496575
  sbg:revision: 12
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618496609
  sbg:revision: 13
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618498837
  sbg:revision: 14
  sbg:revisionNotes: rename reports
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618498936
  sbg:revision: 15
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618499214
  sbg:revision: 16
  sbg:revisionNotes: 12G java
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618499393
  sbg:revision: 17
  sbg:revisionNotes: 30GB
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:validationErrors: []
