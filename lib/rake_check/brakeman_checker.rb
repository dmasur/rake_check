require 'colored'
require 'json'
require 'brakeman'
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
    begin
      previous_stderr, $stderr = $stderr, StringIO.new
      @tracker = Brakeman.run('.')
      $stderr = previous_stderr
    rescue SystemExit
      return { type: :brakeman, check_output: "", status: "Rails App not found".green }
    end
    { type: :brakeman, check_output: output, status: status }
  end

  private
    ##
    # Color the Coverage
    #
    # @return [String] colored Coverage
    # @author dmasur
    def self.color_count(count)
      count = count.to_s
      case count
      when "0" then count.green
      else count.red
      end
    end

    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      if @tracker.nil?
        return 'N/A'
      else
        "#{BrakemanChecker.color_count @tracker.checks.warnings.count} Warnings"
      end
    end

    ##
    # Gives the check output
    #
    # @return [String] Output
    # @author dmasur
    def output
      if @tracker.nil?
        ''
      else
        if @tracker.checks.warnings.empty?
          return ''
        else
          return @tracker.report
        end
      end
    end
end
