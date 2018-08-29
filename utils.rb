# Responsibility - Utility methods needed for processing
class Utils
  def self.word1_letters_in_word2?(word1, word2)
    letters_in_word1 = word1.split('')
    letters_in_word2 = word2.split('')
    (letters_in_word1 - letters_in_word2) == []
  end
end
