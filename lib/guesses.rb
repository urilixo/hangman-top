class Guesses
  attr_accessor :guessed_chars
  attr_reader :remaining_guesses

  def initialize
    @remaining_guesses = 6
    @guessed_chars = []
  end

  def player_guess
    guess = gets.chomp.downcase
    # return guess if save
    return invalid_guess unless ('a'..'z').include?(guess)

    guess
  end

  def compare_guess(guess, secret)
    puts guess
    array_of_indexes = []
    return already_guessed if @guessed_chars.include?(guess)

    secret.split('').each_with_index { |char, index| array_of_indexes << index if char == guess}
    @guessed_chars << guess unless secret.include?(guess)
    return array_of_indexes unless array_of_indexes.empty?

    wrong_guess(secret)
  end

  def wrong_guess(secret)
    @remaining_guesses -= 1
    return [] unless @remaining_guesses.negative?

    puts "You've lost, the word was #{secret} \n"
    true
  end

  def already_guessed
    puts "You have already guessed this character \n"
    sleep 1
    []
  end

  def invalid_guess
    puts 'Guesses must be a single character from A to Z'
    sleep 1
    player_guess
  end
end