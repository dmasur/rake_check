require 'colored'
##
# CoffeeLint Checker looks for smells in your Coffeescript code
#
# @author dmasur
class CoffeeLintChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = begin
      files = Dir["**/*.coffee"]
      if files.empty?
        ""
      else
        `coffeelint #{files.join(" ")}`
      end
    rescue Errno::ENOENT
      "CoffeeLint not found"
    end
    { type: :coffeelint, check_output: @shell_output, status: status }
  end

  private

  ##
  # Gives the Check Status
  #
  # @return [String] Checkstatus
  # @author dmasur
  def status
    return 'No CoffeeScript Files found' if @shell_output == ""
    @violations = violation_count
    if @violations > 0
      print_violation
    elsif @violations == 0
      'OK'.green
    else
      'N/A'
    end
  end

  def violation_count
    @shell_output.scan(/(\d*) errors? and (\d*) warnings? in .+ files?/).flatten.
      map(&:to_i).inject(0){ |sum, value| sum += value }
  end

  def print_violoations
    color_violations
    "#{@violations} Style Violations"
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
