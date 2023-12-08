

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


  def test_5_2
    # NOT REAL TEST! USED TO SOLVE PUZZLE! I'M JUST HAPPY IT'S OVER!
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

    input = fixture.parse_5_1.to_5_2

    map_from = :seed
    map_to = :location
    input_seeds = input[:seeds] # start seeds

    loop do
      input_maps = input[:maps].find { |m| m[:from].eql? map_from.to_s }
      map_from = input_maps[:to]
      mapped = []
      input_maps[:maps].each do |map|
        seeds = input_seeds.clone
        input_seeds = []
        while seeds.length > 0
          seed = seeds.pop
          result = map.cut seed
          mapped.push(result[:mapped]) unless result[:mapped].nil?
          input_seeds.push(result[:rest]).flatten!
        end
      end
      # add remaining seeds
      mapped.push(input_seeds).flatten!
      # set mapped seeds as new input for next iteration
      input_seeds = mapped.clean_ranges
      # break once end reached
      if input_maps[:to].eql? map_to.to_s
        break
      end
    end

    input_seeds.map { |range| range.start }.min.eql? 46
  end
end
