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