# when game is started, load dictionary and pick a random 5 to 12 characters long word.
# display correct letters and empty spaces ( _ ) in their correct position
# optional: display a stick figure or another way to display how many mistakes left
# guesses should be case insensitive
# allow player to save and quit on the start of each turn
# allow player to load a game at the start
require 'pry-byebug'
class Game
  def initialize(dictionary = 'clean_dictionary.txt', lines_in_dictionary = 52_452)
    random_word = pick_random(dictionary, lines_in_dictionary)
    puts random_word
  end

  def pick_random(dictionary, lines_in_dictionary)
    random_word = rand(lines_in_dictionary)
    puts random_word
    File.open(dictionary, 'r') do |file|
      file.each_line.with_index do |line, line_index|
        random_word = line if line_index == random_word
      end
    end
    random_word
  end
end

Game.new
