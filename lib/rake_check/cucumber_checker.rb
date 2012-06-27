require 'colored'
##
# CucumberChecker checks the output for failed Scenarios
#
# @author dmasur
class CucumberChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = begin
      `export COVERAGE=true; cucumber; export COVERAGE=;`
    rescue Errno::ENOENT
      "Cucumber not found"
    end
    { type: :cucumber, check_output: output, status: status }
  end

  private

    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      if @shell_output.include? 'scenarios'
        regexp = /\d+ scenarios \((\d+) failed, \d+ passed\)/
        match_data = regexp.match(@shell_output)
        if match_data
          "#{match_data[1]} failed scenarios".red
        else
          "OK".green
        end
      else
        'N/A'
      end
    end

    ##
    # Cucumber Output
    #
    # @author dmasur
    def output
      case status
      when "N/A" then ''
      when 'OK'.green then ''
      else @shell_output
      end
    end
end
