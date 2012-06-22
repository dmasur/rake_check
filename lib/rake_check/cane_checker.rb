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
    @shell_output = begin
      `cane`
    rescue Errno::ENOENT
      "Cane not found"
    end
    { type: :cane, check_output: @shell_output, status: status }
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
      color = :red
      color = :yellow if @violations.between?(1, 9)
      @violations = @violations.to_s.send color
    end
end
