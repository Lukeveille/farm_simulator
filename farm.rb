require_relative "field"

class Farm
  def initialize
    @food_info = {
      "corn" => 20,
      "wheat" => 30,
    }
    @fields = []
    @food = 0
  end

  # Grows a field with the defined type.
  def grow_field(type, size)
    new_field = Field.new(type, size)
    @fields << new_field
  end

  # Will ask for a food type, loops again if input is an invalid value. Will return nil if input left blank.
  def verify_food
    loop do
      # Generates a grammatically correct sentence based on number of food options.
      print "What kind of field is it:"
      self.food_info.each_with_index do |food, index|
        print " #{food[0]}"
        if index == self.food_info.length - 2
          print " or"
        elsif index == self.food_info.length - 1
          print "?\n"
        else
          print ", "
        end
      end

      field_type = gets.chomp.downcase

      # Will accept either the food type name, or a number corresponding to the order the options were printed.
      if self.food_info.has_key?(field_type)
        return field_type
      elsif field_type.to_i > 0 && field_type.to_i <= self.food_info.length
        food_type = self.food_info.keys
        return food_type[field_type.to_i - 1]
      elsif field_type == ""
        return nil
      else
        puts "Can't grow that type of food!"
      end
    end
  end

  # Makes sure the size of the field is greater than 0 hectars. Will return nil if input left blank.
  def size_field
    loop do
      puts "How large is the field in hectares?"
      size = gets.chomp
      if size == ""
        return nil
      end

      size = size.to_i

      if size > 0
        return size
      else
        puts "Size must be a number greater than 0!"
      end
    end
  end

  # Harvest all fields, return food yield.
  def harvest
    total = 0
    self.fields.each do |field|
      harvest_yield = field.field_size * self.food_info[field.type]
      puts "Harvesting #{harvest_yield} food from #{field.field_size} hectare corn field."
      total += harvest_yield
    end

    @food += total
  end

  def relax
    self.fields.each do |field|
      case field.type
      when "corn"
        puts "#{field.field_size} hectares of tall green stalks rustling in the breeze fill your horizon."
      when "wheat"
        puts "The sun hangs low, casting an orange glow on a sea of #{field.field_size} hectares of wheat."
      end
    end
  end

  attr_reader :food_info, :fields
  attr_accessor :food
end
