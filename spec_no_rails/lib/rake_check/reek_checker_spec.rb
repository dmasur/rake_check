require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/reek_checker')
describe ReekChecker do
  it "gives N/A on Error" do
    require 'ruby_parser'
    subject.stub('`' => 'Error')
    subject.result.should == { type: :reek, check_output: 'Error', status: "\e[31mN/A\e[0m" }
  end
  it "gives OK on no Error" do
    subject.stub('`' => 'warning: already initialized constant ENC_UTF8')
    subject.result.should == { type: :reek, check_output: '', status: "\e[32mOK\e[0m" }
  end
  it "gives Error with on Codesmells" do
    shell_output = File.read(File.expand_path(File.dirname(__FILE__) +
                                              '/../../files/reek_output.yaml'))
    subject.stub('`' => shell_output)
    check_output = "DuplicateMethodCall: ReekChecker#status@19, 20, 21, 22, 23\n"
    check_output += "TooManyStatements: ReekChecker#status@17"
    subject.result.should == { type: :reek,
                               check_output: check_output, status: "\e[33m2 Codesmell\e[0m" }
  end
end
