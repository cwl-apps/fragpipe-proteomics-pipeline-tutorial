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
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --accmass
    position: 0
    shellQuote: false
- id: combine
  doc: combine the results from PeptideProphet into a single result file
  type:
  - 'null'
  - boolean
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
  type:
  - 'null'
  - string
  default: rev_
  inputBinding:
    prefix: --decoy
    position: 3
    shellQuote: false
- id: decoyprobs
  doc: compute possible non-zero probabilities for decoy entries on the last iteration
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --decoyprobs
    position: 4
    shellQuote: false
- id: enzyme
  doc: enzyme used in sample
  type:
  - 'null'
  - string
  default: trypsin
  inputBinding:
    prefix: --enzyme
    position: 5
    shellQuote: false
- id: expectscore
  doc: use expectation value as the only contributor to the f-value for modeling
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --expectscore
    position: 6
    shellQuote: false
- id: masswidth
  doc: model mass width (default 5)
  type:
  - 'null'
  - float
  default: 5
  inputBinding:
    prefix: --masswidth
    position: 7
    shellQuote: false
- id: minpeplen
  doc: minimum peptide length not rejected (default 7)
  type:
  - 'null'
  - int
  default: 7
  inputBinding:
    prefix: --minpeplen
    position: 8
    shellQuote: false
- id: minprob
  doc: report results with minimum probability (default 0.05)
  type:
  - 'null'
  - float
  default: 0.05
  inputBinding:
    prefix: --minprob
    position: 9
    shellQuote: false
- id: nonparam
  doc: use semi-parametric modeling, must be used in conjunction with --decoy option
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --nonparam
    position: 10
    shellQuote: false
- id: nontt
  doc: disable NTT enzymatic termini model
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --nontt
    position: 11
    shellQuote: false
- id: ppm
  doc: use ppm mass error instead of Daltons for mass modeling
  type:
  - 'null'
  - boolean
  inputBinding:
    prefix: --ppm
    position: 12
    shellQuote: false
- id: pepXML
  type:
    type: array
    items: File
- id: mzML
  type:
    type: array
    items: File
- id: workspace_in
  type: File

outputs:
- id: peptide_prophet_log
  type: File
  outputBinding:
    glob: $(inputs.pepXML[0].metadata["Plex or dataset name"]).peptide_prophet.log
    outputEval: $(inheritMetadata(self, inputs.pepXML))
- id: output_xml
  type:
    type: array
    items: File
  outputBinding:
    glob: '*pep.xml'
    outputEval: $(inheritMetadata(self, inputs.pepXML))
- id: peptide_prophet_folder_archive
  type:
  - 'null'
  - File
  outputBinding:
    glob: "*.for_protein.tar.gz\n\n"
    outputEval: $(inheritMetadata(self, inputs.pepXML))
- id: peptide_archive_with_mzml
  type:
  - 'null'
  - File
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
