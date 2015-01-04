require 'rubygems'
require 'bundler/setup'
require 'benchmark/ips'

puts "Ruby version: #{RUBY_VERSION}"

ENUM = [4, [8], 15, [16], [23], 42]

def hash_merge
  (1..42).inject({}) { |hash, i| hash.merge(i => i) }
end

def hash_merge!
  (1..42).inject({}) { |hash, i| hash.merge!(i => i) }
end

def hash_equal
  (1..42).inject({}) { |hash, i| hash[i] = i; hash }
end

Benchmark.ips do |x|
  x.report('hash_merge') { hash_merge }
  x.report('hash_merge!') { hash_merge! }
  x.report('hash_equal') { hash_equal }
  x.compare!
end

# Ruby version: 2.2.0
# Calculating -------------------------------------
#           hash_merge   221.000  i/100ms
#          hash_merge!     2.448k i/100ms
#           hash_equal     6.584k i/100ms
# -------------------------------------------------
#           hash_merge      2.202k (± 5.7%) i/s -     11.050k
#          hash_merge!     24.678k (± 4.1%) i/s -    124.848k
#           hash_equal     68.629k (± 7.4%) i/s -    342.368k

# Comparison:
#           hash_equal:    68629.4 i/s
#          hash_merge!:    24678.3 i/s - 2.78x slower
#           hash_merge:     2202.4 i/s - 31.16x slower
