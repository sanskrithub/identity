# A ruby program to generate index.html from the data/input.txt file.
$links = {}

def outputHeader(ofile)
  ofile.write "<!DOCTYPE HTML>"
  ofile.write "<html>"
  ofile.write "<head>"
  ofile.write "<title>Story by Sanskrit HUB</title>"
  ofile.write "<meta charset=\"utf-8\" />"
  ofile.write "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />"
  ofile.write "<link rel=\"stylesheet\" href=\"assets/css/main.css\" />"
  ofile.write "<noscript><link rel=\"stylesheet\" href=\"assets/css/noscript.css\" /></noscript>"
  ofile.write "</head>"
  ofile.write "<body class=\"is-preload\">"
  ofile.write "<div id=\"wrapper\" class=\"divided\">"
  ofile.write "<h2>Sanskrit - Empower by knowing yourself</h2>"
end

def outputFooter(ofile)
  ofile.write "</div>"
  ofile.write "</body>"
  ofile.write "</html>"
end

def outputTextLinkSectionHeader(ofile, title)
  ofile.write "<section class=\"wrapper style1 align-center\">"
  ofile.write "<div class=\"inner\">"
  ofile.write "<h2>"
  ofile.write title
  ofile.write "</h2>"
  ofile.write "<ul class=\"actions stacked\">"
end

def outputTextLinksSectionFooter(ofile)
  ofile.write "</ul>"
  ofile.write "</div>"
  ofile.write "</section>"
end

def outputVideoLinkSectionHeader(ofile, title)
  ofile.write "<section class=\"wrapper style1 align-center\">"
  ofile.write "<div class=\"inner\">"
  ofile.write "<h2>"
  ofile.write title
  ofile.write "</h2>"
  ofile.write "<p>"
  ofile.write "These are from IIT-Kanpur by various professors"
  ofile.write "</p>"
  ofile.write "<div class=\"items style1 medium\">"
end

def outputVideoLinksSectionFooter(ofile)
  ofile.write "</div>"
  ofile.write "</div>"
  ofile.write "</section>"
end

def outputLink(ofile, line, type)
    values = line.split(",")
    if type == nil
      ofile.write "<li>"
    else
      ofile.write "<section>"
    end
    ofile.write "<a href=\""
    ofile.write values[0]
    ofile.write "\""
    ofile.write " class=\"button big wide smooth-scroll-middle\">"
    ofile.write values[1]
    ofile.write "</a>"
    if type == nil
      ofile.write "</li>"
    else
      ofile.write "</section>"
    end
end

def outputLinks(ofile)

  # process textArray
  array = $links["textArray"]
  outputTextLinkSectionHeader(ofile, "HTML links around the globe")
  array.each do |line|
    outputLink(ofile, line, nil)
  end
  outputTextLinksSectionFooter(ofile)

  # process videoArray
  array = $links["videoArray"]
  outputVideoLinkSectionHeader(ofile, "Video links around the globe", )
  array.each do |line|
    outputLink(ofile, line, "video")
  end
  outputVideoLinksSectionFooter(ofile)
end

#Read input text file line by line into an array
def processInput()
  textArray = []
  videoArray = []
  File.foreach("./data/input.txt").with_index do |line, line_num|
    if line[0] == "#"
      puts "Found comment, ignoring"
      next   
     end

     nline = line.chomp
     values = nline.split(",")
     contentType = values[3]
     if contentType == "html" || contentType == "pdf" || contentType == "text"
       textArray.push(nline)
     elsif contentType == "video"
       videoArray.push(nline)
     else 
       puts "not found html line"
     end
  end

  # Re-populate hash-map
  $links["textArray"] = textArray 
  $links["videoArray"] = videoArray 
end

# Open output file
ofile = File.open("index.html", "w")

#Write html header
outputHeader(ofile)

#Read input data file
processInput()

#Write out links
outputLinks(ofile)

#Write html footer/closing tags
outputFooter(ofile)

ofile.close

