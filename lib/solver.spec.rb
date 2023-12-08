

class SolverTest < Test

  def xtest_parse_calibration_1
    fixture = %w(1abc2 pqr3stu8vwx a1b2c3d4e5f treb7uchet)
    fixture.map(&:parse_calibration_1).reduce(:+).eql? 142
  end

  def xtest_parse_calibration_2
    fixture = %w[two1nine eightwothree abcone2threexyz xtwone3four 4nineeightseven2 zoneight234 7pqrstsixteen pcg91vqrfpxxzzzoneightzt]
    fixture.map(&:parse_calibration_2).reduce(:+).eql? 379
  end

  def xtest_possible_games_1
    fixture = [
      "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green",
      "Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue",
      "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
      "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
      "Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green",
      "Game 6: 8 red, 2 blue; 11 red, 5 blue, 1 green; 12 red, 1 green, 5 blue; 1 blue; 2 blue, 9 red"
    ]

    fixture
      .map(&:parse_gems_1)
      .reduce({}, :merge)
      .possible_games_1({red:12, blue:14, green:13})
      .reduce(:+)
      .eql? 14
  end

  def xtest_seed_1
    fixture = %q(
      seeds: 79 14 55 13

      seed-to-soil map:
      50 98 2
      52 50 48

      soil-to-fertilizer map:
      0 15 37
      37 52 2
      39 0 15

      fertilizer-to-water map:
      49 53 8
      0 11 42
      42 0 7
      57 7 4

      water-to-light map:
      88 18 7
      18 25 70

      light-to-temperature map:
      45 77 23
      81 45 19
      68 64 13

      temperature-to-humidity map:
      0 69 1
      1 0 69

      humidity-to-location map:
      60 56 37
      56 93 4
    ).split("\n")

    maps = 3.aoc.parse_seed_location_1
    puts maps

    location = {}
    #seeds =  maps.find { |m| m.key? :seeds }[:seeds] ### TODO star 1
    seeds = maps.find { |m| m.key? :seeds }[:seeds].to_pairs.map { |p| NumberRange.new *p }
    puts "seeds"
    puts seeds

    new_bla = [seeds.shift]
    seeds.map do |b|
      newnew = new_bla.flat_map { |n| n.uncovered b }
      newnew.delete_if { |n| new_bla.any? { |m| n.overlap?(m) && !n.eql?(m) } }
      new_bla.push *newnew
    end
    puts "new seeds"
    puts new_bla

    return true
    seeds.each do |seed| ### TODO star 2
      puts "### New seed: #{seed}"
      input = [:seed, seed]
      while true
        mapper = maps.find { |m| m[:from].eql? input[0].to_s }
        break if mapper.nil?
        d = mapper[:map].map do |m|
          if input[-1].within? m[1], m[2]
            m[0] + input[-1] - m[1]
          end
        end.compact.run { |a| a.nil? ? input[-1] : a }
        input = [mapper[:to], d]
        input
      end

      location = {seed: seed, location: input[-1]} if location[:location].to_i > input[-1] || location[:location].nil?
    end

    puts "location"
    puts location

    true
  end

  def xtest_overlaps_real_seeds
    seeds = %w[1132132257 323430997 2043754183 4501055]# 2539071613 1059028389 1695770806 60470169 2220296232 251415938 1673679740 6063698 962820135 133182317 262615889 327780505 3602765034 194858721 2147281339 37466509].map(&:to_i)
    # seeds = %w[50 10 55 10 75 10 45 10 25 75]
    ranges = seeds.to_pairs.map { |p| NumberRange.new *p }
    puts ranges
    # first = ranges[0]
    covered_ranges = []

    # TODO only check ranges
    # check seed range against map range
    # create ranges per bucket

    # a from-to-map needs to be able to map ranges and create buckets for each range

    ranges.each do |range|
      # puts "range"
      range.each do |step|
        puts step
        # puts "step #{step}"
        next if covered_ranges.any? { |c| c.covered? step }
        # puts "step #{step} not covered"
        covering_range = covered_ranges.find { |r| r.next? step}
        # puts "covering_range", covering_range
        covering_range.inc && next if covering_range
        puts "c"
        covered_ranges.push NumberRange.new step, 1
      end
    end

    puts "###"
    puts covered_ranges





    # TODO DELETE OLD RANGE CLEANUP
    # final_ranges = [ranges.shift]
    # ranges.map do |range|
    #   puts "range", range
    #
    #   final_ranges.each do |fr|
    #     new_ranges = []
    #     has_overlap = fr.overlap? range
    #     if has_overlap
    #       before, after = fr.uncovered range
    #       final_ranges.push(before) unless final_ranges.any? { |r| r.overlap? before }
    #       final_ranges.push(after) unless final_ranges.any? { |r| r.overlap? after }
    #     end
    #   end
    #
    #   u = final_ranges.flat_map { |n| n.uncovered range }
    #   puts "u", u.length, u
    #   u.delete_if { |n| final_ranges.any? { |m| n.overlap?(m) && !n.eql?(m) } }
    #   final_ranges.push *u
    # end
    # puts "new seeds"
    # puts final_ranges

    true
  end

  def xtest_number_range_overlap
    # no overlap
    no = [
      [[5, 5], [10, 5]],
      [[10, 5], [15, 5]]
    ].map do |v|
      NumberRange.new(*v[0]).overlap?(NumberRange.new(*v[1])).eql? false
    end
    # overlap
    yes = [
      [[5, 6], [10, 5]],
      [[10, 5], [14, 5]],
      [[5, 5], [5, 5]],
      [[5, 5], [9, 5]],
      [[1, 20], [5, 5]],
      [[10, 10], [11, 3]],
    ].map do |v|
      NumberRange.new(*v[0]).overlap?(NumberRange.new(*v[1])).eql? true
    end

    (no + yes).all?
  end

  def xtest_seed_2
    seeds = [10, 10, 5, 10, 15, 10, 11, 2, 1, 100]

    bla = seeds.to_pairs.map { |p| NumberRange.new *p }

    new_bla = [bla.shift]
    bla.map do |b|
      newnew = new_bla.flat_map { |n| n.uncovered b }
      newnew.delete_if { |n| new_bla.any? { |m| n.overlap?(m) && !n.eql?(m) } }
      new_bla.push *newnew
    end

    puts "asdkfjlkasdf"
    puts new_bla.to_s
    puts new_bla.length
    puts new_bla.map(&:to_s)

    true
  end
end
