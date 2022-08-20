# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_init) { described_class.new }

    it 'has 3x3 board' do
      board = board_init.board
      expect(board).to match_array([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    end
  end

  describe '#place_marker' do
    subject(:board_place_marker) { described_class.new }

    before do
      allow(board_place_marker).to receive(:valid_move)
      allow(board_place_marker).to receive(:position_empty?)
    end

    context 'when given position is a number not between 0 and 8' do
      it 'returns false' do
        position = 19
        marker = 'X'
        expect(board_place_marker).to receive(:valid_move).with(position).and_return(false)

        flag = board_place_marker.place_marker(marker, position)
        expect(flag).to be false
      end
    end

    context 'when given position is not an integer' do
      it 'returns false' do
        position = '19'
        marker = 'X'
        expect(board_place_marker).to receive(:valid_move).with(position).and_return(false)

        flag = board_place_marker.place_marker(marker, position)
        expect(flag).to be false
      end
    end

    context 'when given position is not empty' do
      it 'returns false' do
        position = 8
        marker = 'X'
        expect(board_place_marker).to receive(:valid_move).with(position).and_return(true)
        expect(board_place_marker).to receive(:position_empty?).with(position).and_return(false)

        flag = board_place_marker.place_marker(marker, position)
        expect(flag).to be false
      end
    end

    context 'when position is empty' do
      it 'returns true' do
        position = 8
        marker = 'X'
        expect(board_place_marker).to receive(:valid_move).with(position).and_return(true)
        expect(board_place_marker).to receive(:position_empty?).with(position).and_return(true)

        flag = board_place_marker.place_marker(marker, position)
        expect(flag).to be true
      end

      it 'marks board at expected position' do
        position = 7
        marker = 'X'
        expect(board_place_marker).to receive(:valid_move).with(position).and_return(true)
        expect(board_place_marker).to receive(:position_empty?).with(position).and_return(true)

        board_place_marker.place_marker(marker, position)
        board = board_place_marker.board
        marker_on_board = board[2][1]

        expect(marker_on_board).to eq(marker)
      end

      it 'marks board at expected position x2' do
        position = 2
        marker = '0'
        expect(board_place_marker).to receive(:valid_move).with(position).and_return(true)
        expect(board_place_marker).to receive(:position_empty?).with(position).and_return(true)

        board_place_marker.place_marker(marker, position)
        board = board_place_marker.board
        marker_on_board = board[0][2]

        expect(marker_on_board).to eq(marker)
      end
    end
  end

  describe '#check_if_marker_won?' do
    subject(:board_won) { described_class.new }

    context 'when X markers placed in full row' do
      it 'returns true for marker X' do
        marker = 'X'
        board_won.place_marker(marker, 0)
        board_won.place_marker(marker, 1)
        board_won.place_marker(marker, 2)

        won = board_won.check_if_marker_won?(marker)
        expect(won).to be true
      end

      it 'returns false for marker O' do
        marker = 'X'
        board_won.place_marker(marker, 0)
        board_won.place_marker(marker, 1)
        board_won.place_marker(marker, 2)

        won = board_won.check_if_marker_won?('O')
        expect(won).to be false
      end
    end

    context 'when X markers placed in full column' do
      it 'returns true for marker X' do
        marker = 'X'
        board_won.place_marker(marker, 0)
        board_won.place_marker(marker, 3)
        board_won.place_marker(marker, 6)

        won = board_won.check_if_marker_won?(marker)
        expect(won).to be true
      end

      it 'returns false for marker O' do
        marker = 'X'
        board_won.place_marker(marker, 0)
        board_won.place_marker(marker, 3)
        board_won.place_marker(marker, 6)

        won = board_won.check_if_marker_won?('O')
        expect(won).to be false
      end
    end

    context 'when X markers placed in full diagnol' do
      it 'returns true for marker X' do
        marker = 'X'
        board_won.place_marker(marker, 0)
        board_won.place_marker(marker, 4)
        board_won.place_marker(marker, 8)

        won = board_won.check_if_marker_won?(marker)
        expect(won).to be true
      end

      it 'returns false for marker O' do
        marker = 'X'
        board_won.place_marker(marker, 0)
        board_won.place_marker(marker, 4)
        board_won.place_marker(marker, 8)

        won = board_won.check_if_marker_won?('O')
        expect(won).to be false
      end
    end
  end

  describe '#filled' do
    subject(:board_filled) { described_class.new }

    context 'when board is filled' do
      it 'returns true' do 
        marker = 'X'
        0..9.times do |position|
          board_filled.place_marker(marker, position)
        end
        
        filled = board_filled.filled?
        expect(filled).to be true
      end
    end

    context 'when board is partially filled' do
      it 'returns false' do 
        marker = 'X'
        2..7.times do |position|
          board_filled.place_marker(marker, position)
        end
        
        filled = board_filled.filled?
        expect(filled).to be false
      end
    end

    context 'when board is empty' do
      it 'returns false' do
        filled = board_filled.filled?
        expect(filled).to be false
      end
    end
  end
end
