require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/cane_checker')

describe CaneChecker do
  it "gives N/A on Error" do
    subject.stub(:`).and_return('Error')
    subject.result.should == { type: :cane, check_output: 'Error', status: 'N/A' }
  end
  it "gives OK with no Errors" do
    subject.stub(:`).and_return('')
    subject.result.should == { type: :cane,
                               check_output: '',
                               status: "\e[32mOK\e[0m" }
  end
  it "adds Class and Line violations" do
    shell_output = "Lines violated style requirements (10):\nClasses are not documented (1):"
    subject.stub(:`).and_return(shell_output)
    subject.result.should == { type: :cane,
                               check_output: shell_output,
                               status: "\e[31m11\e[0m Style Violations" }
  end
  it "dont count other infos" do
    shell_output = "Lines violated style requirements (1):
    app/models/foo.rb:14  Line is >100 characters (115)"
    subject.stub(:`).and_return(shell_output)
    subject.result.should == { type: :cane,
                               check_output: shell_output,
                               status: "\e[33m1\e[0m Style Violations" }
  end
  it "is yellow under 10 Violations" do
    shell_output = "Lines violated style requirements (10):"
    subject.stub(:`).and_return(shell_output)
    subject.result.should == { type: :cane,
                               check_output: shell_output,
                               status: "\e[31m10\e[0m Style Violations" }
  end
  it "is red under 10 Violations" do
    shell_output = "Lines violated style requirements (9):"
    subject.stub(:`).and_return(shell_output)
    subject.result.should == { type: :cane,
                               check_output: shell_output,
                               status: "\e[33m9\e[0m Style Violations" }
  end
end
