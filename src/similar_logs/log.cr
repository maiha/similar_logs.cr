class SimilarLogs
  class Log
    getter msg, count

    def initialize(@msg : String, @count : Int32 = 1)
    end

    def to_s(io : IO)
      io << @msg + (@count > 1 ? " (#{@count - 1} more)" : "")
    end

    def <<(msg : String)
      @count += 1
    end
  end
end
