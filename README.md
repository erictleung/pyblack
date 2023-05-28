
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
remotes::install_github("erictleung/pyblack")
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

## Configuration

In your working directory, you can have a `pyproject.toml` file that
`black` will read.

Below is an example `pyproject.toml` file that changes the line-length
from the default of 88 to 80.

    [tool.black]
    line-length = 80

Other settings available to change can be found by running
`black --help`.

You can read more about this
[here](https://black.readthedocs.io/en/stable/usage_and_configuration/the_basics.html#configuration-format).

## License

MIT
