# frozen_string_literal: true

require 'colorize'
require_relative 'savable'

module Display
  include Savable

  @@hangman = ['', '', '', '', '', '']
  @@body_parts = ['o', '|', '/', '\\', '/', '\\']
  @@alpha = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
  def title
    puts '
  o         o
 <|>       <|>
 < >       < >
  |         |      o__ __o/  \o__ __o     o__ __o/  \o__ __o__ __o      o__ __o/  \o__ __o
  o__/_ _\__o     /v     |    |     |>   /v     |    |     |     |>    /v     |    |     |>
  |         |    />     / \  / \   / \  />     / \  / \   / \   / \   />     / \  / \   / \
 <o>       <o>   \      \o/  \o/   \o/  \      \o/  \o/   \o/   \o/   \      \o/  \o/   \o/
  |         |     o      |    |     |    o      |    |     |     |     o      |    |     |
 / \       / \    <\__  / \  / \   / \   <\__  < >  / \   / \   / \    <\__  / \  / \   / \
                                                |
                                        o__     o
                                        <\__ __/>
'
  end

  def instructions
    puts 'How to play:'
    puts '1. The computer will generate a random word for the player to guess'
    puts '2. Each turn the player will guess a letter. If the letter appears in the secret word then the computer will
show you where it appears in that word. If the letter does not appear in the secret word then the computer will add
a point to your incorrect guesses total.'
    puts '3. The game ends when you reveal the entire secret word or you make six incorrect guesses.'
    puts 'Good luck!'
  end

  def start_load
    puts '1 - Start New Game | 2 - Load Saved Game'
  end

  def create_board(guess)
    display_gallows
    puts guess.join(' ')
  end

  def display_board(guess)
    display_alpha
    display_gallows
    puts guess.join(' ')
    puts ''
  end

  def display_gallows
    puts '    _____'
    puts '   |     |'
    puts "   |     #{@@hangman[0]}"
    puts "   |    #{@@hangman[2]}#{@@hangman[1]}#{@@hangman[3]}"
    puts "   |    #{@@hangman[4]} #{@@hangman[5]}"
    puts '-------'
    puts ''
  end

  def display_alpha
    puts '-----------------'
    puts "| #{@@alpha[0..6].join(' ')} |"
    puts "| #{@@alpha[7..13].join(' ')} |"
    puts "| #{@@alpha[14..20].join(' ')} |"
    puts "| #{@@alpha[21..].join(' ')}     |"
    puts '-----------------'
    puts ''
  end

  def incorrect_guess(count, guess)
    @@hangman[count - 1] = @@body_parts[count - 1]
    @@alpha.map! { |v| v == guess ? v.colorize(:red) : v }
  end

  def correct_guess(guess)
    @@alpha.map! { |v| v == guess ? v.colorize(:green) : v }
  end

  def display_save(guess, word, incorrect)
    save_game(guess, word, incorrect, @@alpha, @@hangman)
  end

  def display_load(data)
    @@alpha = data[:alpha]
    @@hangman = data[:hangman]
  end
end
