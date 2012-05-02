require 'colored'
##
# CaneChecker checks the output code smells with cane
#
# @author dmasur
class CaneChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = `cane`
    { :type => :cane, :check_output => @shell_output, :status => status }
  end

  private
    ##
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      @violations = @shell_output.scan(/\((\d*)\):/).flatten.map(&:to_i).
        inject(0){ |sum, value| sum += value }
      if @violations > 0
        color_violations
        "#{@violations} Style Violations"
      elsif @shell_output.empty?
        'OK'.green
      else
        'N/A'
      end
    end

    ##
    # Color Code Validation Count
    #
    # @return [String] Colored Validation Count
    # @author dmasur
    def color_violations
      color = case @violations
      when 1..9 then :yellow
      else :red
      end
      @violations = @violations.to_s.send color
    end
end
