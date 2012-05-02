require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/yard_checker')

describe YardChecker do
  it "gives N/A on Error" do
    subject.stub('`' => 'Error')
    subject.result.should == { type: :yard, check_output: 'Error', status: 'N/A' }
  end
  it "gives OK with no Errors" do
    subject.stub('`' => '100.00% documented')
    subject.result.should == { type: :yard,
                               check_output: '',
                               status: "\e[32m100.0%\e[0m documented" }
  end
  describe "Code Coverage" do
    it "is green over 90%" do
      subject.stub('`' => "93.00% documented")
      subject.result.should == { type: :yard,
                                 check_output: '',
                                 status: "\e[32m93.0%\e[0m documented" }
    end
    it "is green over 70%" do
      subject.stub('`' => "73.00% documented")
      subject.result.should == { type: :yard,
                                 check_output: '',
                                 status: "\e[33m73.0%\e[0m documented" }
    end
    it "is green over 10%" do
      subject.stub('`' => "13.00% documented")
      subject.result.should == { type: :yard,
                                 check_output: '',
                                 status: "\e[31m13.0%\e[0m documented" }
    end
  end
end
