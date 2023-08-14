require 'pry'
class TicTacToe
    def initialize
        @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
        play
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    def play
        puts "Playing"
        display_board
        turn until over?
        winner
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]}"
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]}"
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]}"
    end

    def input_to_index(user_input)
        user_input.to_i - 1
    end

    def move(index, token="X")
        @board[index] = token
    end

    def position_taken?(index)
        @board[index] != " "
    end

    def valid_move?(index)
        index.between?(0,8) && !position_taken?(index)
    end

    def turn_count
        @board.select {|pos| pos != " "}.count
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        prompt
        while !valid_move?(@index)
            puts "Ooops"
            prompt
        end
        token = current_player
        move(@index, token)
        display_board
    end

    def prompt
        puts "Please pick a valid space between 1 and 9"
        @index = input_to_index(gets.strip)
    end

    def won?
        WIN_COMBINATIONS.detect {|combo| position_taken?(combo[0]) && @board[combo[0]] == @board[combo[1]] && @board[combo[1]] == @board[combo[2]]}
    end

    def full?
        !@board.detect {|pos| pos == " "}
    end

    def draw?
        full? && !won?
    end

    def over?
        draw? || won?
    end

    def winner
        combo = won?
        if combo
            puts "Congratulations #{@board[combo[0]]}"
        else
            puts "Cat's Game!"
        end
    end


end