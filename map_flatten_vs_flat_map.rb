require 'rubygems'
require 'bundler/setup'
require 'benchmark/ips'

puts "Ruby version: #{RUBY_VERSION}"

ENUM = [4, [8], 15, [16], [23], 42]

def map_flatten
  ENUM.map { |obj| obj }.flatten(1)
end

def flat_map
  ENUM.flat_map
end

Benchmark.ips do |x|
  x.report('map_flatten') { map_flatten }
  x.report('flat_map') { flat_map }
  x.compare!
end

# Ruby version: 2.2.0
# Calculating -------------------------------------
#          map_flatten    35.084k i/100ms
#             flat_map   101.816k i/100ms
# -------------------------------------------------
#          map_flatten    456.899k (± 2.2%) i/s -      2.316M
#             flat_map      2.474M (± 2.2%) i/s -     12.422M

# Comparison:
#             flat_map:  2474305.6 i/s
#          map_flatten:   456899.0 i/s - 5.42x slower
