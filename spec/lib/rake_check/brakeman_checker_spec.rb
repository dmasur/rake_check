require File.expand_path(File.dirname(__FILE__) + '/../../../lib/rake_check/brakeman_checker')

describe BrakemanChecker do
  let(:tracker) { stub("Tracker", checks: stub("Checks", warnings: [])) }
  it "gives N/A on no Rails Apps" do
    subject.result.should == { type: :brakeman, check_output: '', status: 'N/A' }
  end
  it "gives OK with no Errors" do
    Brakeman.should_receive(:run).and_return tracker
    subject.stub(:`)
    subject.result.should == { type: :brakeman,
                               check_output: '',
                               status: "\e[32m0\e[0m Warnings" }
  end
  describe "Code Coverage" do
    it "is red with warnings" do
      tracker.checks.stub(warnings: [stub("Warning")])
      tracker.stub(report: "Report")
      Brakeman.should_receive(:run).and_return tracker
      subject.result.should == { type: :brakeman,
                                 check_output: 'Report',
                                 status: "\e[31m1\e[0m Warnings" }
    end
  end
end
