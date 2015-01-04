require 'rubygems'
require 'bundler/setup'
require 'benchmark/ips'

puts "Ruby version: #{RUBY_VERSION}"

def proc_call(&block)
  block.call
end

def yield_
  yield
end

Benchmark.ips do |x|
  x.report('proc_call') { proc_call {} }
  x.report('yield') { yield_ {} }
  x.compare!
end

# Ruby version: 2.2.0
# Calculating -------------------------------------
#            proc_call    75.603k i/100ms
#                yield   135.562k i/100ms
# -------------------------------------------------
#            proc_call      1.421M (± 2.3%) i/s -      7.107M
#                yield      6.640M (± 1.6%) i/s -     33.213M

# Comparison:
#                yield:  6639806.2 i/s
#            proc_call:  1420541.3 i/s - 4.67x slower
