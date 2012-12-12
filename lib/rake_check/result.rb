module RakeCheck
  class Result
    def initialize
      @checks = []
    end

    def each
      @checks.each do |checker|
        yield checker
      end
    end

    def success?
      @checks.all?(&:success?)
    end

    def failed?
      !success?
    end

    def run(checker)
      @checks << checker
      checker.run
    end
  end
end