# frozen_string_literal: true

# Player class
class Player
  attr_reader :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

# Board class to instantiate a tic_tac_toe board
class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def show
    puts prettify_first_row
    puts prettify_second_row
    puts prettify_third_row
  end

  def place_marker(marker, position)
    return false unless valid_move(position)

    if position_empy?(position)
      row, column = convert_position_to_coordinate(position)
      board[row][column] = marker
      true
    else
      false
    end
  end

  def check_if_marker_won?(marker)
    win_combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    is_marker_here = where_marker_exists(marker)
    win_combinations.any? do |combination|
      combination.all? do |index|
        row, column = convert_position_to_coordinate(index)
        is_marker_here[row][column]
      end
    end
  end

  def filled?
    board.all? do |row|
      row.none? { |element| element.instance_of?(Integer)}
    end
  end

  private

  def create_board
    [[0, 1, 2],
     [3, 4, 5],
     [6, 7, 8]]
  end

  def where_marker_exists(marker)
    board.map do |row|
      row.map do |element|
        marker == element
      end
    end
  end

  def convert_position_to_coordinate(position)
    [position / 3, position % 3]
  end

  def position_empy?(position)
    row, column = convert_position_to_coordinate(position)
    board[row][column] == position
  end

  def valid_move(position)
    return false unless position.instance_of?(Integer)

    position.between?(0, 8)
  end

  def prettify_first_row
    "#{board[0][0]} | #{board[0][1]} | #{board[0][2]}"
  end

  def prettify_second_row
    "#{board[1][0]} | #{board[1][1]} | #{board[1][2]}"
  end

  def prettify_third_row
    "#{board[2][0]} | #{board[2][1]} | #{board[2][2]}"
  end
end

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

tic_tac_toe = Game.new
tic_tac_toe.start
