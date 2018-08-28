# Takes care of answering questions
# Can be extended later for processing questions in some way
class Question
  attr_accessor :universe

  def initialize(universe)
    @universe = universe
  end

  def get_ruling_kingdom_attribute(attribute)
    if !universe.ruling_kingdom.nil?
      universe.ruling_kingdom.instance_variable_get(attribute)
    end
    'None'
  end

  def build_allies_list
    allies_list = get_ruling_kingdom_attribute(:@allies_list)
    if allies_list != 'None'
      allies_list.join(', ')
    end
    allies_list
  end

  def answer(question)
    question_index = QUESTIONS.index(question)
    case question_index
    when 0
      puts get_ruling_kingdom_attribute(:@ruler_name)
    when 1
      puts build_allies_list
    end
  end
end
