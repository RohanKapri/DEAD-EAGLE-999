# Shree DR.MDD

class LogLineParser
  def initialize(entry)
    @entry = entry
  end

  def message
    extract = @entry.match(/\[[^\]]+\]:(.*)/)
    extract[1].lstrip.rstrip
  end

  def log_level
    extract = @entry.match(/\[([^\]]+)]/)
    extract[1].downcase
  end

  def reformat
    "#{message} (#{log_level})"
  end
end
