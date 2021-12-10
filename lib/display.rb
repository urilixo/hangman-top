class Display
  attr_accessor :display

  def initialize(secret, loading = false)
    @display = display_word(secret) unless loading
    @display = secret.chars.each_slice(3).map(&:join) if loading
  end

  def edit_display(character, array_of_indexes)
    array_of_indexes.each { |index| @display[index] = " #{character} "}
    print "#{@display.join('')}   #{@guessed_chars}"
    @display
  end

  def refresh_display(remaining_guesses, guessed_chars)
    puts `clear`
    puts draw_stick_figure(remaining_guesses)
    print "#{@display.join('')} \n\n Previous guesses: #{guessed_chars.join('')}\n\n"
  end

  private

  def display_word(secret)
    display = []
    secret.length.times do
      display << ' _ '
    end
    print display.join('')
    puts
    display
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