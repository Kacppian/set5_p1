require './constants'
require './utils'
require './question'
require './kingdom'
require './universe_of_southeros'

# Start of the command line interface for the user
# Parses and processess the inputs accordingly
class Cli
  attr_accessor :question, :universe_of_southeros, :attacking_kingdom

  def initialize
    @kingdom_instances = {}
    KINGDOMS.each do |kingdom|
      kingdom_instance = Kingdom.new(
                                     kingdom[:name],
                                     kingdom[:ruler_name],
                                     kingdom[:emblem_name]
                                     )
      @kingdom_instances[kingdom[:name]] = kingdom_instance
    end
    @attacking_kingdom = @kingdom_instances["Space"]
    @universe_of_southeros = UniverseOfSoutheros.new(
                                                    kingdoms: @kingdom_instances,
                                                    ruling_kingdom: nil
                                                    )
    @question = Question.new(universe_of_southeros)
  end

  def question?(input)
    (input.length == 1)
  end

  def message?(input)
    (input.length == 2)
  end

  def process_question(comma_split_input)
    question.answer(comma_split_input.first.downcase)
  end

  def process_message(kingdom_name, message)
    kingdom = @kingdom_instances[kingdom_name]
    attacking_kingdom.send_message(kingdom, message)
    universe_of_southeros.update_ruling_kingdom
  end

  def delegate_processing(user_input)
    comma_split_input = user_input.split(', ')
    if question?(comma_split_input)
      process_question(comma_split_input)
    elsif message?(comma_split_input)
      process_message(comma_split_input[0], comma_split_input[1].downcase)
    end
  end

  def help
    puts '
      You can ask questions like -
        * Who is the ruler of Southeros?
        * Allies of Ruler? / Allies of King Shan?
      You can also send messages to kingdoms through King Shan like this -
        * Air, "Let’s swing the sword together"
        * Land, "Die or play the tame of thrones"
    '
  end

  def start_program
    puts 'Press `h` for help and `q` for quitting the application!'
    loop do
      user_input = gets.chomp
      case user_input
      when 'q'
        break
      when 'h'
        help
      else
        delegate_processing(user_input)
      end
    end
  end
end

cli = Cli.new
# cli.start_program

inputs = [
  'who is the ruler of southeros?',
  'allies of ruler?',
  'Air, "Let\'s swing the sword together"',
  'Land, "Die or play the tame of thrones"',
  'Ice, "Ahoy! Fight for me with men and money"',
  'Water, "Summer is coming"',
  'Fire, "Drag on Martin!"',
  'who is the ruler of southeros?',
  'allies of King Shan?',
  'allies of ruler?'
]

# inputs = [
#   'allies of king shan?'
# ]

inputs.each do |input|
  puts '-------------'
  puts input
  cli.delegate_processing(input)
end


