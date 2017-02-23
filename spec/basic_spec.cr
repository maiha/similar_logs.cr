require "./spec_helper"

describe SimilarLogs do
  it "example" do
    logs = SimilarLogs.new
    logs << "RedisError: port=7001"
    logs << "RedisError: port=7002"
    logs << "Connection Error"
    logs << "RedisError: port=7003"

    logs.size.should eq(2)
    logs[0].msg.should  eq("RedisError: port=7001")
    logs[0].to_s.should eq("RedisError: port=7001 (2 more)")

    logs.map(&.to_s).should eq(["RedisError: port=7001 (2 more)", "Connection Error"])

    # nothing raised
    logs.map(&.to_s)
    logs.each do |log|
      log
    end
  end

  it "empty" do
    logs = SimilarLogs.new
    logs.size.should eq(0)
    
    # nothing raised
    logs.map(&.to_s)
    logs.each do |log|
      log
    end
  end
end
