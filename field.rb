class Field
  def initialize(name, field_size)
    @name = name
    @field_size = field_size
  end

  attr_reader :name, :field_size
end
