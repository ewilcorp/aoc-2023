# REEEEE

### Solve 1-1:
```ruby
'<filename>'.aoc.map(&:parse_calibration_1).reduce(:+)
```

### Solve 1-2:
```ruby
'<filename>'.aoc.map(&:parse_calibration_2).reduce(:+)
```

### Solve 2-1:
```ruby
'<filename>'.aoc.map(&:parse_gems_1).reduce({}, :merge).possible_games_1({red: 99, blue: 99, green: 99}).reduce(:+)
```

### Solve 5-2
Just run `./lib/solver.spec.rb#test_5_2` with file input instead of `fixture`


## Testing

Run `test.rb`
