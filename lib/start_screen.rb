require_relative 'game'

def load_game
  Game.new(load: true)
  start
end

def new_game
  Game.new
  start
end

def start
  puts `clear`
  puts 'Press 1 to start a new game.'
  puts 'Press 2 to load a saved game.' if File.exist?('save_data.txt')
  input = gets.chomp!
  return new_game if input == '1'
  return load_game if input == '2' && File.exist?('save_data.txt')
end

start
