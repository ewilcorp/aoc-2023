require 'benchmark'

class Test
  def initialize
    self
      .methods
      .filter { |m| m.start_with? 'test_'}
      .map { |t| [t, benchmarked(t)] }
      .delete_if(&:pop)
      .then do |res|
      raise "Test errors #{res}" if res.length > 0
    end
  end

  def benchmarked(method)
    ret = nil
    time = Benchmark.measure(method) do
      ret = self.send(method) rescue false
    end
    print "#{self.class}::#{method} finished in #{time.format("%r")}s\n"
    ret
  end

  def expect(*args)
    return yield args if block_given?
    args.all?
  end
end

class TestRunner
  def self.run
    Test.subclasses.each { |c| c.send :new}
  end
end
