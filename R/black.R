#' Style Python Code directly
#'
#' Takes Python code directly into the function and formats it with black.
#'
#' @param code character text of Python code
#'
#' @returns character formatted Python code
style_black <- function(code) {
  # Write code into temporary file
  tmpFile <- tempfile(fileext = ".py")
  writeLines(code, tmpFile)

  # Setup use of local configuration for black
  black_config_path <- file.path(getwd(), "pyproject.toml")
  black_config <- ifelse(
    file.exists(black_config_path),
    paste("--config", normalizePath(black_config_path), sep = " "),
    ""
  )

  # Run black on code
  x <- suppressWarnings(system2(
    "black",
    c(
      "-v",  # Return more verbose stdout and stderr, used for troubleshooting
      black_config,  # Use config if it exists in the working directory
      tmpFile
    ),
    stdout = TRUE,
    stderr = TRUE
  ))

  if (!is.null(attr(x, "status"))) {
    message("Make sure your code is still valid Python.")
    stop("Failed to reformat.")
  }

  # Read Python code and return results
  pretty_code <- suppressWarnings(readLines(tmpFile))
  contents <- paste0(pretty_code, collapse = "\n")
  return(contents)
}


#' Apply black formatting to highlighted code
#'
#' @returns None
#'
#' @importFrom magrittr %>% extract2
style_black_selection <- function() {
  if(Sys.which("black") == ""){
    stop(
      "This function requires `black`. ",
      "Either it is not installed, or it is not found."
    )
  }

  # Grab code highlighted
  capture <- rstudioapi::getSourceEditorContext()

  # Get Python code to parse
  code <-
    capture %>%
    extract2("selection") %>%
    extract2(1) %>%
    extract2("text")

  # Style extracted code and replace highlighted code with formatted
  contents <- style_black(code)
  rstudioapi::modifyRange(
    location = capture[["selection"]][[1]][["range"]],
    text = contents,
    id = capture[["id"]])
}

#' Style entire active file
#'
#' Assumes file is a standard RMarkdown or Quarto document with Python-labeled
#' code blocks.
#'
#' Code credit: Alex Rossell Hayes (https://github.com/rossellhayes)
style_active_file_black <- function() {
  # Grab file name of open file
  capture <- rstudioapi::getSourceEditorContext()
  file <- capture$path

  # Read in Markdown file
  document <- parsermd::parse_rmd(file, parse_yaml = FALSE)

  # Parse Python code blocks and style it with black
  document <- purrr::modify_if(
    document,
    .p = function(chunk) {
      inherits(chunk, "rmd_chunk") && identical(chunk$engine, "python")
    },
    .f = function(chunk) {
      chunk$code <- style_black(chunk$code)
      chunk
    }
  )

  writeLines(parsermd::as_document(document), file)
}
