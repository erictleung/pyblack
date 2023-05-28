#' Apply black formatting to highlighted code
#'
#' @importFrom magrittr %>% extract2
#'
#' @export
style_black <- function() {
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

  # Run black on temporary file
  tmpFile <- tempfile(fileext = ".py")
  writeLines(code, tmpFile)
  black_config <- normalizePath(file.path(getwd(), "pyproject.toml"))
  x <- suppressWarnings(system2(
    "black",
    c(
      "-v",  # Return more verbose stdout and stderr, used for troubleshooting
      paste("--config", black_config, sep = " "),  # Use working dir config
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
  rstudioapi::modifyRange(
    location = capture[["selection"]][[1]][["range"]],
    text = contents,
    id = capture[["id"]])
}

#' TODO Style entire active file
#'
#' Assumes file is a standard RMarkdown or Quarto document with Python-labeled
#' codeblocks.
#'
#' Inspiration: https://github.com/r-lib/styler/blob/main/R/addins.R#L50
style_active_file_black <- function() {
  if(Sys.which("black") == ""){
    stop(
      "This function requires `black`. ",
      "Either it is not installed, or it is not found."
    )
  }

  # Grab code highlighted
  capture <- rstudioapi::getSourceEditorContext()
  capture

  # Parse through document to extract only Python code blocks
}
