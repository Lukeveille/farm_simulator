require_relative "farm"
require "pry-nav"

class MainMenu
  def initialize
    print "\e[H\e[2J"
    breakline
    question_loop
  end

  # Main loop, will ask main menu options until exit is chosen.
  def question_loop
    @home_farm = Farm.new

    loop do
      questions
      menu_select
    end
  end

  # Prints the main menu options.
  def questions
    puts "Options:"
    puts "field -> adds a new field"
    puts "harvest -> harvests crops and adds to total harvested"
    puts "status -> displays some information about the farm"
    puts "relax -> provides lovely descriptions of your fields"
    puts "exit -> exits the program"
    breakline
    puts ""
  end

  # Will accept user input and direct the method execution.
  def menu_select
    print ">> "
    selection = gets.chomp.downcase

    case selection
    when "field", "1"
      field
    when "harvest", "2"
      print_harvest
    when "status", "3"
      status
    when "relax", "4"
      print_relax_message
    when "exit", "5"
      puts "Exiting..."
      exit!
    end
  end

  # Will add a new field if food type and size is valid.
  def field
    field_type = @home_farm.verify_food

    if field_type == nil
      return
    end

    size = @home_farm.size_field

    if size == nil
      return
    end

    @home_farm.grow_field(field_type, size)

    puts "Added a #{field_type} field of #{size} hectares!"
    breakline
  end

  # Will harvest food and print the new total.
  def print_harvest
    @home_farm.harvest
    harvest_total
    breakline
  end

  # Displays food type and field size.
  def status
    @home_farm.fields.each do |field|
      puts "#{titleize(field.type)} field is #{field.field_size} hectars."
    end
    harvest_total
    breakline
  end

  # Prints the relaxation message associate with every field's food type.
  def print_relax_message
    @home_farm.relax
    puts ""
    breakline
  end

  # Helper method to capitalize first letter.
  def titleize(str)
    str = str.slice(0, 1).capitalize + str.slice(1..-1)
  end

  # Helper method to display harvest total.
  def harvest_total
    puts "The farm has #{@home_farm.food} harvested food so far."
  end

  # Helper method to to print a break line.
  def breakline
    puts "--------------------"
  end
end

MainMenu.new
