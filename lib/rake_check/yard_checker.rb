require 'colored'
##
# YardChecker checks the output for undocumented classes and methods
#
# @author dmasur
class YardChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = `yardoc`
    {:type => :yard, :check_output => output, :status => status}
  end

  private
    ##
    # Color the Coverage
    #
    # @return [String] colored Coverage
    # @author dmasur
    def color_coverage
      @coverage = case @coverage
      when 0..60 then "#{@coverage}%".red
      when 60..90 then "#{@coverage}%".yellow
      when 90..100 then "#{@coverage}%".green
      end
    end

    ##
    # Parse the Code coverage
    #
    # @return [String] colored Codecoverage
    # @author dmasur
    def calc_yard_coverage
      @coverage = /(\d+\.\d+)% documented/.match(@shell_output)[1].to_f
      color_coverage
    end

    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      if @shell_output.include? 'documented'
        calc_yard_coverage
        "#{@coverage} documented"
      else
        'N/A'
      end
    end

    ##
    # Gives the check output
    #
    # @return [String] Output
    # @author dmasur
    def output
      if @shell_output.include? 'documented'
        ''
      else
        @shell_output
      end
    end
end
