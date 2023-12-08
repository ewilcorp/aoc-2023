# frozen_string_literal: true

# Hacky ways for early puzzles

class String
  def parse_calibration_1
    self.chars.map { |s| Integer s rescue nil }.compact.values_at(0, -1).rotate.map.with_index { |v, i| v * 10.pow(i) }.sum
  end

  def parse_calibration_2
    a = self.parse_first_target(numbers_written.keys + numbers_digits.keys).to_number
    b = self.chars.reverse.join.parse_first_target(numbers_written_reversed.keys + numbers_digits.keys).to_number
    "#{a}#{b}".to_i
  end

  def parse_gems_1
    self.split(":").map(&:strip).run do |game, gem_sets|
      {
        game.split(" ").pop => gem_sets.split(";").map.with_index do |gem_set, i|
          { i => gem_set.split(",").map { |g| g = g.split(" "); { g[-1].to_sym => g[0] } } }
        end.reduce({}, :merge)
      }
    end
  end

  protected def parse_first_target(targets)
    targets
      .map(&:to_s)
      .map {|v| {self.index(v) => v} }
      .delete_if { |v| v.keys.compact.length == 0 }
      .reduce {|memo, v| v.keys[0] < memo.keys[0] ? v : memo }
      .values
      .pop
  end

  def test(&block)
    yield self
  end
end

class Hash
  def possible_games_1(limits = {})
    self.map do |game, gems|
      gems.values.flatten.reduce do |memo, v|
        memo.merge! v if memo[v.keys.pop].to_i < v.values.pop.to_i
        memo
      end.run do |k, v|
        limits[k.to_sym].to_i >= v.to_i ? nil : false
      end.compact.length.eql?(0) ? game : nil
    end.compact.map(&:to_i)
  end
end

class Array
  def parse_seed_location_1
    self.map(&:strip).delete_if(&:empty?).then do |data|
      throw Error if data.length.eql?(0)
      seeds = data.shift.split(" ").map { |v| Integer v rescue nil}.compact
      maps = []
      data.each do |line|
        unless line[0].is_digit?
          from, to = line.split(" ")[0].split("-to-")
          map = {}
          map[:from] = from
          map[:to] = to
          map[:map] = []
          maps.push map
          next
        end
        m = maps[-1]
        next if m.nil?
        m[:map].push line.split(" ").map(&:to_i)
      end
      maps.push({seeds: seeds})
      maps
    end
  end
end

