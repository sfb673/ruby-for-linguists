# encoding: utf-8
require 'benchmark'
n = 10 ** 6
Benchmark.bm do |b|
  b.report('+  ') { n.times { "a="+1.to_s+" und b=" + 2.0.to_s + " und c=" + "drei" } }
  b.report('#{}') { n.times { "a=#{1} und b=#{2.0} und c=#{'drei'}" } }
  b.report('%  ') { n.times { "a=%i und b=%f und c=%s" % [1, 2.0, 'drei']}}
end