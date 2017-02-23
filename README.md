# similar_logs.cr

Compact Array(String) with Levenshtein for [Crystal](http://crystal-lang.org/).

- crystal: 0.20.4

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  similar_logs:
    github: maiha/similar_logs.cr
    version: 0.1.0
```

## Usage

```crystal
require "similar_logs"
```

Use `SimilarLogs.new` rather than `Array(String).new`.

```crystal
logs = SimilarLogs.new
logs << "RedisError: port=7001"
logs << "RedisError: port=7002"
logs << "Connection Error"
logs << "RedisError: port=7003"

logs.size # => 2
logs[0]   # => #<SimilarLogs::Log:0xa78980 @count=3, @msg="RedisError: port=7001">
logs[1]   # => #<SimilarLogs::Log:0xa788e0 @count=1, @msg="Connection Error">

logs.each do |log|
  puts log
end
# RedisError: port=7001 (2 more)
# Connection Error
```

#### Rate

Give similarity rate by from `0.0` to `1.0`. (default: `0.5`)

```
logs = SimilarLogs.new(rate: 0.5)  # default
logs << "foo"
logs << "bar"
logs << "baz"

# when rate: 0.0
logs.map(&.msg) # => ["foo"]

# when rate: 1.0
logs.map(&.msg) # => ["foo", "bar", "baz"]

# when rate: 0.5 (default)
logs.map(&.msg) # => ["foo", "bar"]
```

## Contributing

1. Fork it ( https://github.com/maiha/similar_logs.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [maiha](https://github.com/maiha) maiha - creator, maintainer
