require "./spec_helper"

describe "SimilarLogs.new" do
  describe "(invalid rate)" do
    it "aborts" do
      expect_raises(ArgumentError) { SimilarLogs.new(rate: -1.0) }
      expect_raises(ArgumentError) { SimilarLogs.new(rate: 2.0) }
    end
  end

  describe "(rate: 0.0)" do
    it "merges all logs into 1" do
      logs = SimilarLogs.new(rate: 0.0)
      logs << "foo"
      logs << "bar"
      logs << "baz"

      logs.map(&.msg).should eq(["foo"])
    end
  end

  describe "(rate: 1.0)" do
    it "never merges logs" do
      logs = SimilarLogs.new(rate: 1.0)
      logs << "foo"
      logs << "bar"
      logs << "baz"

      logs.map(&.msg).should eq(["foo", "bar", "baz"])
    end
  end

  describe "(rate: default = 0.5)" do
    it "merges logs with rate 50% or higher" do
      logs = SimilarLogs.new
      logs << "foo"
      logs << "bar"
      logs << "baz"

      logs.size.should eq(2)
      logs.map(&.msg).should eq(["foo", "bar"])
    end
  end
end
