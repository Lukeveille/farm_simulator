class Field
  def initialize(type, field_size)
    @type = type
    @field_size = field_size
  end

  attr_reader :type, :field_size
end
