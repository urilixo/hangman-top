class Game
  require_relative 'guesses'
  require_relative 'display'
  attr_accessor :game_display, :player

  def initialize(dictionary = 'clean_dictionary.txt', lines_in_dictionary = 52_452, load: false)
    if load == true
      load_game
    else
      @secret_word = pick_random(dictionary, lines_in_dictionary).downcase.chomp!
      @game_display = Display.new(@secret_word)
      @player = Guesses.new
      game_loop
    end
  end

  private

  def game_loop
    loop do
      guess = @player.player_guess
      array_of_indexes = @player.compare_guess(guess, @secret_word)

      break if array_of_indexes == true

      @game_display.edit_display(guess, array_of_indexes)
      victory and break if @game_display.display.join.gsub(' ', '') == @secret_word

      @game_display.refresh_display(@player.remaining_guesses, @player.guessed_chars)
      save_game
    end
    File.delete('save_data.txt') if File.exist?('save_data.txt')
  end

  def victory
    puts "\n You won!!! The word was #{@secret_word.split(' ').join}!"
    sleep 2
  end

  def save_game
    File.open('save_data.txt', 'w') do |f|
      f.puts(@secret_word)
      f.puts(@player.remaining_guesses)
      f.puts(@player.guessed_chars.join)
      f.puts(@game_display.display.join)
    end
  end

  def load_game
    File.open('save_data.txt', 'r') do |f|
      @secret_word = f.readline.chomp!
      remaining_guesses = f.readline.chomp!.to_i
      guessed_chars = f.readline.chomp!.split('')
      guess_status = f.readline.chomp!
      @game_display = Display.new(guess_status, true)
      @player = Guesses.new(remaining_guesses, guessed_chars)
      @game_display.refresh_display(@player.remaining_guesses, @player.guessed_chars)
      game_loop
    end
  end

  def pick_random(dictionary, lines_in_dictionary)
    random_word = rand(lines_in_dictionary)
    File.open(dictionary, 'r') do |file|
      file.each_line.with_index do |line, line_index|
        random_word = line if line_index == random_word
      end
    end
    random_word
  end
end
