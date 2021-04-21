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
  type:
  - 'null'
  - File
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
