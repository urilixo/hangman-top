# when game is started, load dictionary and pick a random 5 to 12 characters long word.
# display correct letters and empty spaces ( _ ) in their correct position
# optional: display a stick figure or another way to display how many mistakes left
# guesses should be case insensitive
# allow player to save and quit on the start of each turn
# allow player to load a game at the start
require 'pry-byebug'
class Game
  attr_accessor :game_display, :player

  def initialize(dictionary = 'clean_dictionary.txt', lines_in_dictionary = 52_452)
    @mistakes = 0 #remove this later
    @secret_word = pick_random(dictionary, lines_in_dictionary).downcase.chomp!
    @game_display = Display.new(@secret_word)
    @player = Guesses.new
    game_loop
  end

  def game_loop
    until @finished == true
      guess = @player.player_guess
      array_of_indexes = @player.compare_guess(guess, @secret_word)
      

      @game_display.edit_display(guess, array_of_indexes)
      #
      @finished = true if @game_display.display.join == @secret_word
      save_game
    end
  end

  def save_game
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

class Display
  attr_accessor :display

  def initialize(secret)
    @display = display_word(secret)
  end

  def display_word(secret)
    display = []
    secret.length.times do
      display << ' _ '
    end
    print display.join('')
    puts
    display
  end

  def edit_display(character, array_of_indexes)
    array_of_indexes.each { |index| @display[index] = character }
    print "#{@display.join('')}   #{@guessed_chars}"
    @display
  end
end

class Guesses
  attr_accessor :guessed_chars

  def initialize
    @remaining_guesses = 12
    @guessed_chars = []
  end

  def player_guess
    guess = gets.chomp.downcase
    #return guess if save
    return invalid_guess unless ('a'..'z').include?(guess)

    guess
  end

  def compare_guess(guess, secret)
    puts guess
    array_of_indexes = []
    return already_guessed if @guessed_chars.include?(guess)

    @guessed_chars << guess
    secret.split('').each_with_index { |char, index| array_of_indexes << index if char == guess}
    #binding.pry
    return array_of_indexes unless array_of_indexes.empty?

    wrong_guess(secret)
  end

  def wrong_guess(secret)
    puts "Wrong guess, #{@remaining_guesses} left."
    @remaining_guesses -= 1
    return [] unless @remaining_guesses < 1

    puts "You've lost, the word was #{secret} \n"
    @finished = true
  end

  def already_guessed
    puts "You have already guessed this character \n"
    []
  end

  def invalid_guess
    puts 'Guesses must be a single character from A to Z'
    player_guess
  end
end

Game.new
