copyOnClick <- function (text, class = "tag") {
  
  # Get rid of all white spaces for use as id
  id = gsub("[[:space:]]", "", text)
  
  # Create HTML string
  html.markup <- paste0('<span id="',id,'" class="',class,'" onclick="copy_data(',id,')">',text,'</span>')
  
  return(html.markup);
}

# copyOnClick("Mijn mooie tag")