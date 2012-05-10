require 'colored'
##
# Check the Output of rspec and simplecov
#
# @author dmasur
class RspecChecker
  ##
  # Gives the Result Hash
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result directory="spec"
    @shell_output = `export COVERAGE=true; rspec #{directory}; export COVERAGE=`
    {:type => directory, :status => status + code_coverage, :check_output => output}
  end

  private
    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      case @shell_output
      when / 0 failures/
        'OK'.green
      when /failures?/
        /\d+ failures?/.match(@shell_output)[0].red
      else 'N/A'
      end
    end

    ##
    # Gives the check output
    #
    # @return [String] Output
    # @author dmasur
    def output
      case @shell_output
      when / 0 failures/ then ''
      else @shell_output
      end
    end

    ##
    # Gives the check codecoverage
    #
    # @return [String] Codecoverage
    def code_coverage
      if @shell_output.include?('Coverage report generated')
        @coverage = /LOC \((\d+\.\d+)%\) covered/.match(@shell_output)[1].to_f
        color_coverage
        " with #{@coverage} Code Coverage"
      else
        ""
      end
    end

    ##
    # Calculate the Codecoverage
    #
    # @return [String] Colored Codecoverage
    def color_coverage
      @coverage = case @coverage
      when 0..60 then "#{@coverage}%".red
      when 60..90 then "#{@coverage}%".yellow
      when 90..100 then "#{@coverage}%".green
      end
    end
end
