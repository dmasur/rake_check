require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/cucumber_checker')

describe CucumberChecker do
  it "gives N/A on Error" do
    Dir.stub(:[] => [stub])
    subject.stub(:`).and_return('Error')
    subject.result.should == { type: :cucumber, check_output: '', status: 'N/A' }
  end
  it "gives OK with no Errors" do
    Dir.stub :[] => [stub]
    subject.stub(:`).and_return('8 scenarios (8 passed)')
    subject.result.should == { type: :cucumber,
                               check_output: '',
                               status: "\e[32mOK\e[0m" }
  end
  it "is red on Error" do
    Dir.stub :[] => [stub]
    subject.stub(:`).and_return('8 scenarios (1 failed, 7 passed)')
    subject.result.should == { type: :cucumber,
                               check_output: '8 scenarios (1 failed, 7 passed)',
                               status: "\e[31m1 failed scenarios\e[0m" }
  end
end
