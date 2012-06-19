require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/brakeman_checker')

describe BrakemanChecker do
  it "gives N/A on no Rails Apps" do
    subject.stub('`' => '')
    subject.result.should == { type: :brakeman, check_output: '', status: 'N/A' }
  end
  it "gives N/A on Error" do
    subject.stub('`' => 'Error')
    subject.result.should == { type: :brakeman, check_output: 'Error', status: 'Parse Error' }
  end
  it "gives OK with no Errors" do
    shell_output = File.read(File.expand_path(File.dirname(__FILE__) +
                                              '/../../files/brakeman_ok.json'))
    subject.stub('`' => shell_output)
    subject.result.should == { type: :brakeman,
                               check_output: '',
                               status: "\e[32m0\e[0m Warnings, \e[32m0\e[0m Errors" }
  end
  describe "Code Coverage" do
    it "is red with errors" do
      shell_output = File.read(File.expand_path(File.dirname(__FILE__) +
                                                '/../../files/brakeman_error.json'))
      subject.stub('`' => shell_output)
      output = 'unterminated string meets end of file. near line 13:' +
        ' "" While processing /path/to/app/controllers/admin/admins_controller.rb'
      subject.result.should == { type: :brakeman,
                                 check_output: output,
                                 status: "\e[32m0\e[0m Warnings, \e[31m1\e[0m Errors" }
    end
    it "is red with warnings" do
      shell_output = File.read(File.expand_path(File.dirname(__FILE__) +
                                                '/../../files/brakeman_warning.json'))
      subject.stub('`' => shell_output)
      subject.result.should == { type: :brakeman,
                                 check_output: 'Possible SQL injection',
                                 status: "\e[31m1\e[0m Warnings, \e[32m0\e[0m Errors" }
    end
  end
end
