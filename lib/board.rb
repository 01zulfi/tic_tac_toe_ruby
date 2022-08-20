# frozen_string_literal: true

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

    if position_empty?(position)
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
      row.none? { |element| element.instance_of?(Integer) }
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

  def position_empty?(position)
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
