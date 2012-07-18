require 'colored'
##
# Konacha Checker checks for konacha Errors in you Javascripttests
#
# @author dmasur
class KonachaChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = begin
      `rake konacha:run`
    rescue Errno::ENOENT
      "Konacha not found"
    end
    { type: :konacha, check_output: output, status: status }
  end

  private

  ##
  # Gives the Check Status
  #
  # @return [String] Checkstatus
  # @author dmasur
  def status
    @violations = violation_count
    if @violations > 0
      print_violations
    elsif @violations == 0
      'OK'.green
    else
      'N/A'
    end
  end

  def output
    violation_count > 0 ? @shell_output : ''
  end

  def violation_count
    @violations ||= @shell_output.scan(/(\d*) examples, (\d*) failures?/).flatten.last.to_i
  end

  def print_violations
    color_violations
    "#{@violations} Javascript Errors"
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
