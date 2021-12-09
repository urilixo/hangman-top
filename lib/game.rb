# when game is started, load dictionary and pick a random 5 to 12 characters long word.
# display correct letters and empty spaces ( _ ) in their correct position
# optional: display a stick figure or another way to display how many mistakes left
# guesses should be case insensitive
# allow player to save and quit on the start of each turn
# allow player to load a game at the start
require 'pry-byebug'
class Game
  def initialize(dictionary = 'clean_dictionary.txt', lines_in_dictionary = 52_452)
    @mistakes = 0
    @secret_word = pick_random
    @display = display_word(secret_word)
    @finished = false
    until finished?
      guess = Guess.new
      @mistakes += 1 if compare_guess(guess, @secret_word) == nil
      finished = true if @display.join == @secret_word
    end
    random_word = pick_random(dictionary, lines_in_dictionary)
    puts random_word
  end

  def already_guessed
    'You have already guessed this character'
  end

  def compare_guess(guess, secret)
    return already_guessed if @display.include?(guess)

    array_of_indexes = []
    secret.split('').each_with_index { |char, index| array_of_indexes << index if char == guess}
    return nil if array_of_indexes.empty?

    edit_display(guess, array_of_indexes)
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

  def display_word(secret)
    display = []
    secret.length.times do
      display << ' _ '
    end
  end

  def edit_display(character, array_of_indexes)
    array_of_indexes.each { |index| @display[index] = character }
  end

  def game_over
    puts 'You lost'
  end
end

class Guess
  def initialize
    @guess = player_guess
  end

  def player_guess
    guess = gets.chomp.downcase
    return invalid_guess unless ('a'..'z').include?(guess)

    guess
  end

  def invalid_guess
    puts 'Guesses must be a single character from A to Z'
    player_guess
  end
end

Game.new
