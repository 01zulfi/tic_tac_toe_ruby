# frozen_string_literal: true

require_relative './board'
require_relative './player'

# Game loop
class Game
  def initialize
    @board = Board.new
    @winner = nil
  end

  def start
    add_players
    play
    @winner ? announce_winner : announce_draw
  end

  private

  def add_players
    puts 'Enter Player One Name:'
    player_one_name = gets.chomp
    puts 'Enter Player Two Name:'
    player_two_name = gets.chomp

    @player_one = Player.new(player_one_name, 'X')
    @player_two = Player.new(player_two_name, 'O')

    puts 'Players intialized:'
    puts "#{@player_one.name}: #{@player_one.marker}"
    puts "#{@player_two.name}: #{@player_two.marker}"
    system('clear')
  end

  def play
    until @winner
      @board.show

      puts "#{@player_one.name}, make your move!"
      play_round(@player_one)

      break if @winner
      break if @board.filled?

      @board.show

      puts "#{@player_two.name}, make your move!"
      play_round(@player_two)
    end
  end

  def play_round(player)
    player_move(player)
    @winner = player_won?(player) ? player : nil
    system('clear')
  end

  def player_move(player)
    loop do
      move = gets.chomp
      if %w[0 1 2 3 4 5 6 7 8].none?(move)
        puts 'Invalid Move, try again'
        next
      end

      is_success = @board.place_marker(player.marker, move.to_i)

      puts 'Invalid Move.try again' unless is_success
      break if is_success
    end
  end

  def player_won?(player)
    @board.check_if_marker_won?(player.marker)
  end

  def announce_winner
    puts "#{@winner.name} (#{@winner.marker}) Won!!!"
  end

  def announce_draw
    puts 'Game has drawn.'
  end
end
