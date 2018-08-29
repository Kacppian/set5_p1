# Responsibility - Answering questions
class Question
  attr_accessor :universe

  def initialize(universe)
    @universe = universe
  end

  def get_ruling_kingdom_attribute(attribute)
    if !universe.ruling_kingdom.nil?
      return universe.ruling_kingdom.instance_variable_get(attribute)
    end
    'None'
  end

  def get_kingdom(ruler_name)
    universe.kingdoms.select do |kingdom_name, instance|
      instance.ruler_name.downcase == ruler_name
    end.first
  end

  def build_allies_list(ruler_name, ruling_kingdom: false)
    allies_list = if !ruling_kingdom
      get_kingdom(ruler_name.downcase)[1].allies_list
    else
      get_ruling_kingdom_attribute('@allies_list')
    end

    if allies_list == 'None'
      return allies_list
    end
    allies_list.join(', ')
  end

  def answer(question)
    question_index = QUESTIONS.index(question)
    case question_index
    when 0
      puts get_ruling_kingdom_attribute('@ruler_name')
    when 1
      puts build_allies_list(nil, ruling_kingdom: true)
    when 2
      puts build_allies_list('King Shan')
    end
  end
end
