require "levenshtein"
require "./similar_logs/*"

class SimilarLogs
  include Enumerable(Log)
  include Iterable(Log)

  def initialize(@rate : Float64 = 0.5)
    raise ArgumentError.new "Invalid range for rate: expected 0..1, but got #{@rate}" unless (0.0 .. 1.0) === @rate
    @logs = Hash(String, Log).new
  end

  def <<(msg : String)
    if log = similar_log?(msg)
      log << msg
    else
      @logs[msg] = Log.new(msg, 1)
    end
  end

  # Enumerable
  def each
    @logs.each do |key, val|
      yield val
    end
  end

  # Iterable
  def each
    @logs.each_value
  end

  def [](index : Int) : Log
    case val = each.skip(index).next
    when Iterator::Stop::INSTANCE
      raise IndexError.new(index.to_s)
    else
      val.as(Log)
    end
  end
  
  private def similar_log?(msg) : Log?
    case log = best_log?(msg)
    when Log
      dist = Levenshtein.distance(msg, log.msg)
      size = [msg.size, log.msg.size].max
      rate = (size - dist).to_f / size
      return log if @rate <= rate
    end

    return nil
  end

  private def best_log?(msg) : Log?
    return nil if @logs.empty?
    finder = Levenshtein::Finder.new(msg, msg.size)
    @logs.each_key{|str| finder.test(str)}
    return finder.best_match.try{|s| @logs[s]}
  end
end
