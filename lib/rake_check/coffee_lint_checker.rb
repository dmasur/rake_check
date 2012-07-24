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
      config_file = File.exists?("clint_config.json") ? '-f clint_config.json' : ''
      `coffeelint -r . #{config_file}`
    rescue Errno::ENOENT
      "CoffeeLint not found"
    end
    { type: :coffeelint, check_output: output, status: status }
  end

  private

  def output
    violation_count > 0 ? @shell_output : ''
  end

  ##
  # Gives the Check Status
  #
  # @return [String] Checkstatus
  # @author dmasur
  def status
    return 'Not found'.green if @shell_output.include? "0 files"
    @violations = violation_count
    if @violations > 0
      print_violations
    elsif @violations == 0
      'OK'.green
    else
      'N/A'
    end
  end

  def violation_count
    @violations ||= @shell_output.scan(/(\d*) errors? and (\d*) warnings? in .+ files?/).flatten.
      map(&:to_i).inject(0){ |sum, value| sum += value }
  end

  def print_violations
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
