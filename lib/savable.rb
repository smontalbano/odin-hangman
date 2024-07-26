# frozen_string_literal: true

require 'yaml'

module Savable
  @@save_file_dir = 'save_games'
  def save_game(guess, word, incorrect, alpha, man)
    puts 'Name your save file'
    save_name = gets.chomp
    Dir.mkdir(@@save_file_dir) unless Dir.exist?(@@save_file_dir)
    data = {
      guess: guess,
      secret_word: word,
      incorrect_guess: incorrect,
      alpha: alpha,
      hangman: man
    }
    path = File.join(@@save_file_dir, save_name)
    File.open(path, 'w') do |i|
      i.write(YAML.dump(data))
    end
    puts "Game saved to #{path}"
  end

  def load_game(file)
    path = File.join(@@save_file_dir, file)
    YAML.load_file(path)
  end
end
