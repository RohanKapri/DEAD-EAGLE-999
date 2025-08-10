# For my Shree DR.MDD

class Markdown
  def initialize(markdown : String)
    @lines = markdown.split("\n")
  end

  def to_html : String
    output = ""
    @lines.each_with_index do |line, idx|
      output += parse_line(line, idx)
    end
    output
  end

  private def parse_line(line : String, idx : Int32) : String
    case line
    when /^#+/
      parse_header(line)
    when /^\*/
      parse_list_item(line, idx)
    else
      parse_paragraph(line)
    end
  end

  private def parse_header(line : String) : String
    level = line.match(/^#+/).to_s.size
    return "<p>#{line}</p>" if level >= 7

    content = line[level..-1].strip
    "<h#{level}>#{parse_text(content)}</h#{level}>"
  end

  private def parse_list_item(line : String, idx : Int32) : String
    html = ""
    html += "<ul>" if idx == 0 || !@lines[idx - 1].starts_with?('*')
    html += "<li>#{parse_text(line[2..].strip)}</li>"
    html += "</ul>" if idx == @lines.size - 1 || !@lines[idx + 1].starts_with?('*')
    html
  end

  private def parse_paragraph(line : String) : String
    "<p>#{parse_text(line)}</p>"
  end

  private def parse_text(text : String) : String
    text = text.gsub(/__(.+?)__/, "<strong>\\1</strong>")
    text = text.gsub(/_(.+?)_/, "<em>\\1</em>")
    text
  end
end
