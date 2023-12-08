class Hash

  def run
    self.map do |k, v|
      yield k, v
    end
  end

  def and
    yield self
  end
end
