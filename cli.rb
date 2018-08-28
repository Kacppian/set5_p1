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
                                                    ruling_kingdom: @attacking_kingdom
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
  end

  def delegate_processing(user_input)
    comma_split_input = user_input.split(', ')
    if question?(comma_split_input)
      process_question(comma_split_input)
    elsif message?(comma_split_input)
      process_message(comma_split_input[0], comma_split_input[1].downcase)
    end
  end

  def start_program
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
cli.start_program
