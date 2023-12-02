module Reader
  def aoc_lines(path)
    file = File.open path
    f = file.readlines.map(&:chomp)
    file.close
    f
  end
end


class Integer
  def aoc(path = 'input', type = 'txt')
    self.to_s.aoc(path, type)
  end
end

class String
  include Reader

  def aoc(path = 'input', type = 'txt')
    aoc_lines([[path, self].join('/'), type].join('.'))
  end
end
