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
      `cucumber`
    rescue Errno::ENOENT
      "Cucumber not found"
    end
    {:type => :cucumber, :check_output => '', :status => status}
  end

  private

    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      if @shell_output.include? 'scenarios'
        match_data = /\d+ scenarios \((\d+) failed, \d+ passed\)/.match(@shell_output)
        if match_data
          failed_scenarios = match_data[1]
          "#{failed_scenarios} failed scenarios".red
        else
          "OK".green
        end
      else
        'N/A'
      end
    end
end
