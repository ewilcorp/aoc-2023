class NilClass
  def values
    []
  end

  # helper for methods like String#shift causing NoMethodError warning
  def and
    ""
  end
end
