require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/rspec_checker')

describe RspecChecker do
  it "gives N/A on Error" do
    subject.stub('`' => 'Error')
    subject.result.should == { type: "spec", check_output: 'Error', status: 'N/A' }
  end
  it "gives OK with no Errors" do
    subject.stub('`' => '6 examples, 0 failures')
    subject.result.should == { type: "spec", check_output: '', status: "\e[32mOK\e[0m" }
  end
  it "gives warning message with Errors" do
    subject.stub('`' => '6 examples, 3 failures')
    subject.result.should == { type: "spec", check_output: '6 examples, 3 failures',
                                    status: "\e[31m3 failures\e[0m" }
  end
  it "gives warning message with one Error" do
    subject.stub('`' => '6 examples, 1 failure')
    subject.result.should == { type: "spec", check_output: '6 examples, 1 failure',
                                    status: "\e[31m1 failure\e[0m" }
  end
  describe "Code Coverage" do
    it "is green over 90%" do
      check_output = "6 examples, 0 failures
Coverage report generated for RSpec to /foo/bar/coverage. 38 / 38 LOC (93.90%) covered."
      subject.stub('`' => check_output)
      subject.result.should == { type: "spec", check_output: '',
                                      status: "\e[32mOK\e[0m with \e[32m93.9%\e[0m Code Coverage" }
    end
    it "is green over 70%" do
      check_output = "6 examples, 0 failures
Coverage report generated for RSpec to /foo/bar/coverage. 38 / 38 LOC (73.90%) covered."
      subject.stub('`' => check_output)
      subject.result.should == { type: "spec", check_output: '',
                                      status: "\e[32mOK\e[0m with \e[33m73.9%\e[0m Code Coverage" }
    end
    it "is green over 10%" do
      check_output = "6 examples, 0 failures
Coverage report generated for RSpec to /foo/bar/coverage. 38 / 38 LOC (13.90%) covered."
      subject.stub('`' => check_output)
      subject.result.should == { type: "spec", check_output: '',
                                      status: "\e[32mOK\e[0m with \e[31m13.9%\e[0m Code Coverage" }
    end
  end
end
