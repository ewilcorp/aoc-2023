
class Test
  def initialize
    self
      .methods
      .filter { |m| m.start_with? 'test_'}
      .map { |t| [t, self.send(t)] }
      .delete_if(&:pop)
      .then do |res|
        raise "Test errors #{res}" if res.length > 0
    end
  end
end

class SolverTest < Test
  def initialize
    super
  end

  def xtest_parse_calibration_1
    fixture = %w(1abc2 pqr3stu8vwx a1b2c3d4e5f treb7uchet)
    fixture.map(&:parse_calibration_1).reduce(:+).eql? 142
  end

  def xtest_parse_calibration_2
    fixture = %w[two1nine eightwothree abcone2threexyz xtwone3four 4nineeightseven2 zoneight234 7pqrstsixteen pcg91vqrfpxxzzzoneightzt]
    fixture.map(&:parse_calibration_2).reduce(:+).eql? 379
  end

  def test_possible_games_1
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
end
