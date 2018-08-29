require './utils'
# Responsibility - Maintaining the state of a kingdom
class Kingdom
  attr_accessor :name, :ruler_name, :emblem_name, :allies_list

  def initialize(name, ruler_name, emblem_name)
    @name = name
    @ruler_name = ruler_name
    @emblem_name = emblem_name.downcase
    @allies_list = ['None']
  end

  def add_an_ally(kingdom)
    if allies_list != ['None']
      allies_list.push(kingdom.name)
      return allies_list
    end
    allies_list.pop
    allies_list.push(kingdom.name)
    allies_list
  end

  def send_message(kingdom, message)
    if Utils.word1_letters_in_word2?(kingdom.emblem_name, message)
      add_an_ally(kingdom)
    end
  end
end
