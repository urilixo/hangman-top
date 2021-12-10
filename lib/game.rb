# when game is started, load dictionary and pick a random 5 to 12 characters long word.
# display correct letters and empty spaces ( _ ) in their correct position
# optional: display a stick figure or another way to display how many mistakes left
# guesses should be case insensitive
# allow player to save and quit on the start of each turn
# allow player to load a game at the start
require 'pry-byebug'
class Game
  require_relative 'guesses'
  attr_accessor :game_display, :player

  def initialize(dictionary = 'clean_dictionary.txt', lines_in_dictionary = 52_452)
    @secret_word = pick_random(dictionary, lines_in_dictionary).downcase.chomp!
    @game_display = Display.new(@secret_word)
    @player = Guesses.new
    game_loop
  end

  def game_loop
    loop do
      guess = @player.player_guess
      array_of_indexes = @player.compare_guess(guess, @secret_word)

      break if array_of_indexes == true

      @game_display.edit_display(guess, array_of_indexes)
      break if @game_display.display.join == @secret_word

      @game_display.refresh_display(@player.remaining_guesses, @player.guessed_chars)
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
    #binding.pry
    array_of_indexes.each { |index| @display[index] = character }
    print "#{@display.join('')}   #{@guessed_chars}"
    @display
  end

  def refresh_display(remaining_guesses, guessed_chars)
    puts `clear`
    puts draw_stick_figure(remaining_guesses)
    print "#{@display.join('')} \n\n Previous guesses: #{guessed_chars.join('')}\n\n"
  end
  
  def draw_stick_figure(remaining_guesses)
    case remaining_guesses
    when 6
      "________\n|/     |\n|       \n|\n|\n|"
    when 5
      "________\n|/     |\n|      O  \n|\n|\n|"
    when 4
      "________\n|/     |\n|      O  \n|      |\n|\n|"
    when 3
      "________\n|/     |\n|      O  \n|     /|\n|\n|"
    when 2
      "________\n|/     |\n|      O  \n|     /|\\ \n|\n|"
    when 1
      "________\n|/     |\n|      O  \n|     /|\\ \n|     / \n|"
    when 0
      "________\n|/     |\n|      O  \n|     /|\\ \n|     / \\ \n|"
    end
  end
end



Game.new
