##
# ReekChecker checks the Output of reek for Code Smells
#
# @author dmasur
module RakeCheck
  module Checker
    class Reek < Base

      def run
        run_command "reek app/models lib -y"
      end

      #  =========================
      #  = OLD CODE: REFACTOR ME =
      #  =========================
      # ##
      # # Gives the Checkresult
      # #
      # # @return [Hash] Checkresult
      # # @author dmasur
      # def result
      #   require_dependencies
      #   @shell_output = begin
      #     `reek app/models lib -y 2>/dev/null`
      #   rescue Errno::ENOENT
      #     "Reek not found"
      #   end
      #   @shell_output = @shell_output.split("\n").delete_if do |line|
      #     line.include?('already initialized constant')
      #   end.join("\n")
      #   { type: :reek, check_output: output, status: status }
      # end

      # private
      #   ##
      #   # Require Dependencies
      #   #
      #   # @author dmasur
      #   def require_dependencies
      #     require 'reek'
      #     require 'colored'
      #     require 'yaml'
      #   end
      #   ##
      #   # Gives the Check Status
      #   #
      #   # @return [String] Checkstatus
      #   # @author dmasur
      #   def status
      #     if @shell_output.empty?
      #       'OK'.green
      #     elsif not @shell_output.include? '---'
      #       'N/A'.red
      #     else
      #       error_count = parsed_output.count
      #       "#{error_count} Codesmell".yellow
      #     end
      #   end

      #   ##
      #   # Parse the Output through YAML
      #   #
      #   # @return [Array] SmellWarnings
      #   # @author dmasur
      #   def parsed_output
      #     YAML::load(check_output)
      #   end

      #   ##
      #   # Format the SmellWarning for printing
      #   #
      #   # @return [String] Formated SmellWarning
      #   # @author dmasur
      #   def self.format_smell smell_warning
      #     location = smell_warning.location
      #     output = "#{smell_warning.smell["subclass"]}: "
      #     output += "#{location["context"]}@#{location["lines"].join(", ")}"
      #     return output
      #   end

      #   ##
      #   # Gives the check output
      #   #
      #   # @return [String] Output
      #   # @author dmasur
      #   def output
      #     if @shell_output.include? '---'
      #       parsed_output.map do |smell|
      #         ReekChecker.format_smell smell
      #       end.join("\n")
      #     else
      #       @shell_output
      #     end
      #   end
    end
  end
end