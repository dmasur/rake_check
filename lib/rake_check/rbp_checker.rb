require 'colored'
##
# Check the output of rails best pratices gem
#
# @author dmasur
class RbpChecker
  ##
  # Gives the Checkresult
  #
  # @return [Hash] Checkresult
  # @author dmasur
  def result
    @shell_output = begin
      `rails_best_practices --silent --spec`
    rescue Errno::ENOENT
      "Rails best practices not found"
    end
    { type: :rbp, check_output: output, status: status }
  end

  private
    ##
    # Gives the Checkoutput
    #
    # @return [String] Checkoutput
    # @author dmasur
    def output
      if state == :good
        ''
      else
        regexp = /Please go to .* to see more useful Rails Best Practices./
        output_lines = @shell_output.gsub(regexp, '').split(/\n/)
        (output_lines - ["\e[0m", "\e[32m", "\n"]).join("\n")
      end
    end

    ##
    # Gives the Checkstatus
    #
    # @return [String] Checkstatus
    # @author dmasur
    def status
      case state
      when :good then 'OK'.green
      when :error then 'N/A'
      else error_message.red
      end
    end

    ##
    # Gives the Error message
    #
    # @return [String] Errormessage
    # @author dmasur
    def error_message
      /Found \d+ warnings/.match(@shell_output)[0]
    end

    ##
    # Gives the Check state
    #
    # @return [Symbol] Checkstatus
    # @author dmasur
    def state
      if @shell_output.include? 'No warning found. Cool!'
        :good
      elsif @shell_output =~ /Found \d+ warnings/
        :failures
      else :error
      end
    end
end
