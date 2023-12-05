# REEEEE

Solve 1:
```ruby
'<filename>'.aoc.map(&:parse_calibration_1).reduce(:+)
```

Solve 2:
```ruby
'<filename>'.aoc.map(&:parse_calibration_2).reduce(:+)
```

Solve 3:
```ruby
'<filename>'.aoc.map(&:parse_gems_1).reduce({}, :merge).possible_games_1({red: 99, blue: 99, green: 99}).reduce(:+)
```


## Testing

Run `test.rb`
