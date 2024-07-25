# frozen_string_literal: true

require_relative 'display'

class Hangman
  include Display

  def initialize
    @guess = []
    @secret_word = ''
    @incorrect_guess_count = 0
    title
    instructions
    start_load
    game_setup
  end

  def generate_random_word
    words = File.readlines('dictionary.txt').map(&:chomp)
    words.select { |word| word.length.between?(5, 12) }.sample
  end

  def game_setup
    input = gets.chomp.to_i
    if input == 1
      game_init
    elsif input == 2
      load_game
    else
      puts "I'm sorry, I didn't get that. Please try again."
      start_load
      game_setup
    end
  end

  def game_init
    @secret_word = generate_random_word
    # puts @secret_word
    parse_secret_word
    create_board(@guess)
    game_play
  end

  def game_play
    until game_over?
      puts '1 - Make a guess | 2 - Save Game'
      input = gets.chomp.to_i
      if input == 1
        new_guess = guess.to_s
        parse_guess(new_guess)
      elsif input == 2
        save
      else
        puts "I'm sorry, I didn't get that. Please try again."
        next
      end
    end
    puts @secret_word
  end

  def parse_guess(guess)
    if @secret_word.include?(guess)
      correct_guess = @secret_word.split('').each_index.select { |i| @secret_word.split('')[i] == guess }
      correct_guess.each { |val| @guess[val] = guess }
      correct_guess(guess)
    else
      @incorrect_guess_count += 1
      incorrect_guess(@incorrect_guess_count, guess)
    end
    display_board(@guess)
  end

  def guess
    puts 'Guess a letter'
    letter = gets.chomp.downcase
    return letter if letter =~ /[a-z]/

    puts "I'm sorry. I didn't get that. Please try again."
    guess
  end

  def parse_secret_word
    i = 0
    while i < @secret_word.size
      @guess[i] = '_'
      i += 1
    end
  end

  def game_over?
    @incorrect_guess_count == 6 || @guess.join == @secret_word
  end

  def load_game
    puts 'Load'
  end
end

Hangman.new
