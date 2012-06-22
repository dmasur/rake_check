require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/rbp_checker')

describe RbpChecker do
  it "gives N/A on Error" do
    subject.stub(:`).and_return('Error')
    subject.result.should == { type: :rbp, check_output: 'Error', status: 'N/A' }
  end
  it "gives OK with no Errors" do
    subject.stub(:`).and_return('No warning found. Cool!')
    subject.result.should == { type: :rbp, check_output: '', status: "\e[32mOK\e[0m" }
  end
  it "gives warning message with Errors" do
    subject.stub(:`).and_return('Found 1 warnings.')
    subject.result.should == { type: :rbp,
                               check_output: 'Found 1 warnings.',
                               status: "\e[31mFound 1 warnings\e[0m" }
  end
end
