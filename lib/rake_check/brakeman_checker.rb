require 'colored'
require 'json'
##
# BrakemanChecker checks the output for undocumented classes and methods
#
# @author dmasur
class BrakemanChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = begin
      `brakeman -f json 2>/dev/null`
    rescue Errno::ENOENT
      "Brakeman not found"
    end
    {:type => :brakeman, :check_output => output, :status => status}
  end

  private
    ##
    # Color the Coverage
    #
    # @return [String] colored Coverage
    # @author dmasur
    def color_count count
      case count
      when 0 then count.to_s.green
      else count.to_s.red
      end
    end

    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      if @shell_output == ''
        return 'N/A'
      else
        begin
          warnings_string = "#{color_count data["warnings"].count} Warnings"
          errors_string = "#{color_count data["errors"].count} Errors"
          return "#{warnings_string}, #{errors_string}"
        rescue JSON::ParserError
          return 'Parse Error'
        end
      end
    end

    ##
    # Parses the JSON Output
    #
    # @author dmasur
    def data
      raise JSON::ParserError if @shell_output.empty?
      json_string = @shell_output.split("Generating report...").last
      json = JSON.parse(json_string)
    end

    ##
    # Gives the check output
    #
    # @return [String] Output
    # @author dmasur
    def output
      if @shell_output == ''
        return ''
      else
        begin
          (data["warnings"].map { |warning| warning["message"] } +
          data["errors"].map { |error| error["error"] }).join(", ")
        rescue JSON::ParserError
          return @shell_output
        end
      end
    end
end
