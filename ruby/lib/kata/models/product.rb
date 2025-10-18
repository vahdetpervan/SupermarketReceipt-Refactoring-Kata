class Kata::Product
  attr_reader :name, :unit

  def initialize(name, unit)
    @name = name
    @unit = unit
  end
end
