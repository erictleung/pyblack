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
  x <- suppressWarnings(system2(
    "black", tmpFile,
    stdout = TRUE, stderr = TRUE
  ))

  if (!is.null(attr(x, "status"))) {
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

#' TODO
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
}