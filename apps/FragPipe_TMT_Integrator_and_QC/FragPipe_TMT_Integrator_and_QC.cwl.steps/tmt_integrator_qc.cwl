cwlVersion: v1.1
class: CommandLineTool
label: TMT-Integrator QC
$namespaces:
  sbg: https://sevenbridges.com

requirements:
- class: DockerRequirement
  dockerPull: rocker/verse:4.0.4
- class: InitialWorkDirRequirement
  listing:
  - entryname: gene_report.Rmd
    writable: false
    entry: |+
      ---
      title: "TMT-Integrator Quality Control"
      date: "`r Sys.Date()`"
      output:
        html_document: default
      editor_options: 
        chunk_output_type: console
      ---

      ```{r setup, include=FALSE}
      library(tidyverse)
      library(RColorBrewer)
      ```

      ```{r, include=FALSE}
      source("input.R")

      wide_data = read_tsv(file = gene_report_path) %>% # load the TMT-Integrator gene report
        drop_na() %>%   # remove rows containing NAs and pivot 
        glimpse()
        
      long_data = wide_data %>%   
        pivot_longer(-names(.)[1:5], names_to = "variable", values_to="value") %>% 
        group_by(variable) %>% #create variable group num
        mutate(variable_num = cur_group_id()) %>% 
        ungroup() %>% 
        select(variable_num, everything()) %>% 
        glimpse()

      ```


      ```{r message = FALSE, fig.height = 8, fig.width = 12, echo=FALSE}
      long_data %>%
        filter(variable_num %in% c(1:20)) %>% #filter for first 20 channels
      ggplot(aes(x = variable, y = value)) +
        geom_boxplot(outlier.colour = NA, alpha = 0.2, fill = "lightcyan") +
        stat_boxplot(geom = 'errorbar', linetype = 1, width = 0.1) +
        labs(title = "Protein Intensities variance and distribution") +
        theme(text = 
              element_text(size = 9),
              axis.text.x = element_text(size = 9, angle = 45, hjust = 1),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              panel.border = element_rect(colour = "black", fill = NA, size = 1))

      ```


      ```{r message=FALSE, echo=FALSE, fig.heigh = 8, fig.width = 14}

      long_data %>% 
        #filter(variable_num %in% c(1:10)) %>% #filter for first 10 channels
        ggplot() +
        geom_density(aes(x = value, color = variable)) +
        labs(title = "Protein Intensities variance and distribution", color = "samples") +
        theme(text = element_text(size = 9),
              axis.text = element_text(size = 9),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              legend.position = "none",
              panel.border = element_rect(colour = "black", fill = NA, size = 1))
      ```

      ```{r, message=FALSE, echo=FALSE, fig.height = 16, fig.width = 12}


      wide_data %>% 
        select(6:ncol(.)) %>% 
        as.matrix() %>% 
      heatmap(Rowv = NA, col = colorRampPalette(brewer.pal(8, "Blues"))(25), margins = c(16,10))
      ```








  - entryname: input.R
    writable: false
    entry: gene_report_path = "$(inputs.tmt_gene_report.path)"
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
- id: tmt_gene_report
  type: File

outputs:
- id: tmt_qc_report
  label: TMT QC Report
  type: File?
  outputBinding:
    glob: '*.html'
    outputEval: $(inheritMetadata(self, inputs.tmt_gene_report))
stdout: markdown.log

baseCommand:
- Rscript
- -e
- "'require(rmarkdown);"
- render("gene_report.Rmd")'

hints:
- class: sbg:SaveLogs
  value: '*.R'
- class: sbg:SaveLogs
  value: '*.log'
id: david.roberson/pdc-webinar-devl-2/tmt-integrator-qc/8
sbg:appVersion:
- v1.1
sbg:content_hash: a812f4daebbb5c2ea3e209dc9ffcbffec95187a0060b6d3c51f2d40c0d4d942fe
sbg:contributors:
- david.roberson
sbg:createdBy: david.roberson
sbg:createdOn: 1618447418
sbg:id: david.roberson/pdc-webinar-devl-2/tmt-integrator-qc/8
sbg:image_url:
sbg:latestRevision: 8
sbg:modifiedBy: david.roberson
sbg:modifiedOn: 1618501572
sbg:project: david.roberson/pdc-webinar-devl-2
sbg:projectName: PDC Webinar Devl 2
sbg:publisher: sbg
sbg:revision: 8
sbg:revisionNotes: removed glimpse
sbg:revisionsInfo:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618447418
  sbg:revision: 0
  sbg:revisionNotes:
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618487828
  sbg:revision: 1
  sbg:revisionNotes: added report
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618487853
  sbg:revision: 2
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618488399
  sbg:revision: 3
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618494102
  sbg:revision: 4
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618496433
  sbg:revision: 5
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618499775
  sbg:revision: 6
  sbg:revisionNotes: ''
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618500945
  sbg:revision: 7
  sbg:revisionNotes: added parenthesis
- sbg:modifiedBy: david.roberson
  sbg:modifiedOn: 1618501572
  sbg:revision: 8
  sbg:revisionNotes: removed glimpse
sbg:sbgMaintained: false
sbg:validationErrors: []
