
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pyblack

<!-- badges: start -->

[![R-CMD-check](https://github.com/erictleung/pyblack/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/erictleung/pyblack/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Style Python code blocks with [black](https://github.com/psf/black) in
RStudio.

![Demo of the pyblack RStudio addin to help format Python code in
RMarkdown](man/figures/pyblack.gif)

## Installation

``` r
devtools::install_github("erictleung/pyblack")
```

You must have black installed and accessible in your path for this addin
to work.

``` bash
pip install black
```

## Usage

In your text editor, highlight the relevant Python code you wish to
format.

Then navigate in RStudio to Addins \> PYBLACK \> Style selection with
black.

## License

MIT
