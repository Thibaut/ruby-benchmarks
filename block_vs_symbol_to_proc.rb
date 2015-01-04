require 'rubygems'
require 'bundler/setup'
require 'benchmark/ips'

puts "Ruby version: #{RUBY_VERSION}"

def block
  (1..42).map { |i| i.to_s }
end

def symbol_to_proc
  (1..42).map(&:to_s)
end

Benchmark.ips do |x|
  x.report('block') { block }
  x.report('symbol_to_proc') { symbol_to_proc }
  x.compare!
end

# Ruby version: 2.2.0
# Calculating -------------------------------------
#                block    10.910k i/100ms
#       symbol_to_proc    12.383k i/100ms
# -------------------------------------------------
#                block    114.335k (± 8.5%) i/s -    567.320k
#       symbol_to_proc    134.661k (± 2.1%) i/s -    681.065k

# Comparison:
#       symbol_to_proc:   134660.5 i/s
#                block:   114334.8 i/s - 1.18x slower
