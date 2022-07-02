# Tic Tac Toe in Ruby

Command line version of Tic Tac Toe written in Ruby.

## Classes

### `Player`

- Handles player instantiation
- Initialized with `name` and `marker`
- Getters/Setters: `attr_reader :name, :marker`
 
#### Public Methods 

n/a

#### Private Methods

n/a

### `Board`

- Handles the tic_tac_toe board
- Getters/Setters: `attr_reader :board`

#### Public Methods

- `show`: prints board
- `place_marker`: allows `marker` to be placed on a `position`
- `check_if_marker_won?`: checks if the specific marker won
- `filled?`: checks if board is filled

#### Private Methods

- `create_board`: creates a board with the structure
  ```rb
    [[0, 1, 2],
     [3, 4, 5],
     [6, 7, 8]]
  ```
- `where_marker_exists`: returns a boolean version of the board representing where the specific marker exists
- `covert_position_to_coordinate`: converts a `position` (0 to 8) to a row and column number
- `position_empty?`: returns whether a position is empty
- `valid_move`: checks whether a move is valid
- `prettify_(first/second/third)_row`: helpers to `show` method

### `Game`

- Handles the tic_tac_toe game loop

#### Public Methods

- `start`: starts and plays the game till the end

#### Private Methods

- `add_players`: help `start` to add `players` from cli
- `play`: loops and play rounds until a `break` conditions is satisfied
- `play_round`: plays a round - round is a player making their move and then checking if they won
- `player_move`: helper to get player input
- `player_won?`: check if player won
- `announce_winner?`: announces winner
- `announce_draw?`: announces draw
