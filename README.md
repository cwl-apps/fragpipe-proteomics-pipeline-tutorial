# FragPipe Proteomics Pipeline Tutorial
____  

FragPipe is a suite of computational tools enabling comprehensive analysis of mass spectrometry-based proteomics data. It is powered by [MSFragger](msfragger.nesvilab.org) - an ultrafast proteomic search engine suitable for both conventional and "open" (wide precursor mass tolerance) peptide identification. FragPipe includes the [Philosopher toolkit](philosopher.nesvilab.org) for downstream post-processing of MSFragger search results (PeptideProphet, iProphet, ProteinProphet), FDR filtering, label-based quantification, and multi-experiment summary report generation. Crystal-C and PTM-Shepherd are included to aid interpretation of open search results. Also included in FragPipe binary are [TMT-Integrator](tmt-integrator.nesvilab.org) for TMT/iTRAQ isobaric labeling-based quantification, IonQuant for label-free quantification with match-between-run (MBR) functionality, SpectraST and EasyPQP spectral library building modules, and DIA-Umpire SE module for direct analysis of data independent acquisition (DIA) data.


Goal: Use FragPipe Proteomics Pipeline to analyze the proteome of clear cell renal cell carcinoma samples.  
  
Steps:
1.  Run FragPipe Convert-Identify-PeptideProphet on 2 plexes
2.  Run FragPipe ProteinProphet on all 23 plex workspaces  in 1 task
3.  Run FragPipe Filter-Quant-Report on 2 plex workspaces  
4.  Run FragPipe TMT-Integrator and QC on all 23 PSM files  
5.  Use RStudio to interactively QC the outputs of TMT-Integrator and cluster (?) 
  
Please reach out during or after the workshop with any questions  
david.roberson@sevenbridges.com    
felipevl@umich.edu
    
[CGC Proteomics Workshop - April 21, 2021 · Discussion Board· Nesvilab/FragPipe](https://github.com/Nesvilab/FragPipe/discussions/354) 
