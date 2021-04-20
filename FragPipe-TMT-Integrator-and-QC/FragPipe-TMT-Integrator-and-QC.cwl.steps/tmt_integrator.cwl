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
  - entryname: Dockerfile
    writable: false
    entry: |
      FROM ubuntu:18.04

      # MAINTAINER Felipe da Veiga Leprevost <felipevl@umich.edu>

      # Set noninterative mode
      ENV DEBIAN_FRONTEND noninteractive

      # apt update and install global requirements
      RUN apt-get clean all &&  \
          apt-get update &&     \
          apt-get upgrade -y && \
          apt-get install -y    \
          openjdk-8-jre


      # create shared folders
      RUN mkdir /data

      # Add $HOME/bin to path
      ENV PATH=$PATH:/data

      # Share default volumes
      VOLUME ["/data", "/config"]

      # Overwrite this with 'CMD []' in a dependent Dockerfile
      CMD ["/bin/bash"]

      # change workdir
      WORKDIR /data

      ADD https://github.com/Nesvilab/TMT-Integrator/releases/download/2.4.0/TMTIntegrator_v2.4.0.jar /data
      ADD https://github.com/Nesvilab/TMT-Integrator/releases/download/2.4.0/tmt-i_param_v2.4.0.yml /data

      ENV PATH /data/:$PATH
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
  type:
    type: array
    items: File
  inputBinding:
    position: 0
    shellQuote: false
  sbg:fileTypes: TSV
- id: database
  type: File
  sbg:fileTypes: FAS

outputs:
- id: all_report_files
  type:
  - 'null'
  - type: array
    items: File
  outputBinding:
    glob: '*tsv'
    outputEval: $(inheritMetadata(self, inputs.psm_file))
- id: abundance_by_gene_report
  type:
  - 'null'
  - File
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
id: david.roberson/build-fragpipe-proteomics-pipeline-tutorial/tmt_integrator/1
sbg:appVersion:
- v1.1
sbg:content_hash: a48c0d8277d6ea77fc88d98f7a34ca77d55a137702303d0e525603d18fa192f57
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618936765
sbg:id: david.roberson/build-fragpipe-proteomics-pipeline-tutorial/tmt_integrator/1
sbg:image_url:
sbg:latestRevision: 1
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618936850
sbg:project: david.roberson/build-fragpipe-proteomics-pipeline-tutorial
sbg:projectName: 'BUILD: FragPipe Proteomics Pipeline Tutorial'
sbg:publisher: sbg
sbg:revision: 1
sbg:revisionNotes: added dockerfile
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618936765
  sbg:revision: 0
  sbg:revisionNotes: |-
    Uploaded using sbpack v2020.10.05. 
    Source: 
    repo: https://github.com/davidroberson/fragpipe-proteomics-pipeline-tutorial.git
    file: 
    commit: (uncommitted file)
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618936850
  sbg:revision: 1
  sbg:revisionNotes: added dockerfile
sbg:sbgMaintained: false
sbg:toolkit: FragPipe
sbg:validationErrors: []
