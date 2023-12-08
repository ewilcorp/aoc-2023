

class String
  def and
    return yield if block_given?
    self
  end
end
