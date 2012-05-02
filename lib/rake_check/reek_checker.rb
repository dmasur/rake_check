require 'colored'
##
# ReekChecker checks the Output of reek for Code Smells
#
# @author dmasur
class ReekChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    shell_output = `reek app lib -y 2>/dev/null`
    @shell_output = shell_output.split("\n").
      delete_if{|line| line.include?('already initialized constant') }.join("\n")
    {:type => :reek, :check_output => output, :status => status}
  end

  private
    # Gives the Check Status
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      if @shell_output.empty?
        'OK'.green
      elsif not @shell_output.include? '---'
        'N/A'.red
      else
        error_count = YAML.parse(@shell_output).children.first.children.count
        "#{error_count} Codesmell".yellow
      end
    end

    ##
    # Gives the check output
    #
    # @return [String] Output
    # @author dmasur
    def output
      unless @shell_output.include? '---'
        @shell_output
      else
        ''
      end
    end
end
