#!/usr/bin/env Rscript
require("rmarkdown");

render(
    "main.rmd",
    output_format = "html_document",
    output_file = "index.html",
    output_dir = "docs/",
    run_pandoc = TRUE,
    encoding = "UTF-8"
);
