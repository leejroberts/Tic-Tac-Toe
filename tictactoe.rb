
# method library
def welcome(str) # welcomes user
  puts "X O X O X O X O X O { #{str} } O X O X O X O X O X O X"
end

def prompt(str) # prompts user
  puts "==> #{str}"
end

def verify_name(name) # name check/return
  loop do
    name = gets.chomp.to_s
    if name.to_i == 0
      break
    else
      prompt('Please re-enter your name')
    end
  end
  return name.capitalize.to_s
end

def verify_x_o # verifies marker selection
  prompt('Please select your marker: X / O')
  marker = ''
  loop do
    marker = gets.chomp.upcase.byteslice(0).to_s
    if marker == 'X' || marker == 'O'
      break
    elsif marker == '0'
      marker = 'O'
      break
    else
      prompt('Please re-select your marker: X O')
    end
  end
  return marker
end

def comp_create(mrkr)
  if mrkr == 'O'
    comp_marker = 'X'
  else
    comp_marker = 'O'
  end
end

def intialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = ' ' }
  new_board
end

def display_board(brd)
  puts"     |     |"
  puts"  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts"     |     |"
  puts"-----+-----+-----"
  puts"     |     |"
  puts"  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts"     |     |"
  puts"-----+-----+-----"
  puts"     |     |"
  puts"  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts"     |     |"
end

def open_create(brd)
  brd.reject { |k, v| v == 'O' || v == 'X' }.keys
end
  

def player_marks_board(brd, arr, mrkr)
  prompt('Choose a square: 1-9')
  square = ''
  loop do
    square = gets.chomp.to_i
    if arr.include?(square)
      break
    else
      prompt('Please re-enter your square selection. 1-9')
    end
  end
  temp_board = { square => mrkr }
  brd.merge!(temp_board)
end

def comp_marks_board(brd, arr, cmp_mrkr)
  comp_select = arr.sample
  comp_board = {comp_select => cmp_mrkr}
  brd.merge!(comp_board)
end

def return_w_l_d(brd, arr, usr_mrkr, cmp_mrkr)
  if  (brd[1] == usr_mrkr && brd[2] == usr_mrkr && brd[3] == usr_mrkr) ||
    (brd[4] == usr_mrkr && brd[5] == usr_mrkr && brd[6] == usr_mrkr) ||
    (brd[7] == usr_mrkr && brd[8] == usr_mrkr && brd[9] == usr_mrkr) ||
    (brd[7] == usr_mrkr && brd[5] == usr_mrkr && brd[3] == usr_mrkr) ||
    (brd[1] == usr_mrkr && brd[5] == usr_mrkr && brd[9] == usr_mrkr) ||
    (brd[1] == usr_mrkr && brd[4] == usr_mrkr && brd[7] == usr_mrkr) ||
    (brd[2] == usr_mrkr && brd[5] == usr_mrkr && brd[8] == usr_mrkr) ||
    (brd[3] == usr_mrkr && brd[6] == usr_mrkr && brd[9] == usr_mrkr) 
    return 'wins'
  elsif (brd[1] == cmp_mrkr && brd[2] == cmp_mrkr && brd[3] == cmp_mrkr) ||
    (brd[4] == cmp_mrkr && brd[5] == cmp_mrkr && brd[6] == cmp_mrkr) ||
    (brd[7] == cmp_mrkr && brd[8] == cmp_mrkr && brd[9] == cmp_mrkr) ||
    (brd[1] == cmp_mrkr && brd[5] == cmp_mrkr && brd[9] == cmp_mrkr) ||
    (brd[7] == cmp_mrkr && brd[5] == cmp_mrkr && brd[3] == cmp_mrkr) ||
    (brd[1] == cmp_mrkr && brd[4] == cmp_mrkr && brd[7] == cmp_mrkr) ||
    (brd[2] == cmp_mrkr && brd[5] == cmp_mrkr && brd[8] == cmp_mrkr) ||
    (brd[3] == cmp_mrkr && brd[6] == cmp_mrkr && brd[9] == cmp_mrkr) 
    return 'lose'
  elsif arr.empty? == true
    return 'draw'
  else
    return 'continue'
  end
end

def play_return(ans)
  prompt('Would you like to play again?')
  loop do
    ans = gets.chomp.upcase.byteslice(0).to_s
    if ans == 'Y' || ans == 'N'
    break
    else
      prompt('Please enter: Y / N')
    end
  end
  return ans
end
# END OF METHOD LIBRARY

# BODY BEGIN
welcome('Welcome to TIC TAC TOE!')
prompt('Please enter you name.')
name = verify_name(name)
puts "Hello #{name}, Let's play TIC TAC TOE!"

loop do # MAIN LOOP
  user_marker = verify_x_o
  comp_marker = comp_create(user_marker)
  board = intialize_board
  display_board(board)

  loop do # ROUNDS LOOP
    open_board = open_create(board)
    board = player_marks_board(board, open_board, user_marker)
    open_board = open_create(board) # removes last selected KEY from open_board arr
    board = comp_marks_board(board, open_board, comp_marker)
    display_board(board)
    win_lose_draw = return_w_l_d(board, open_board, user_marker, comp_marker)

    wins_mess = "#{name} has won. Computer has been defeated!"
    lose_mess = "#{name} has lost. Computer is victorious!"
    draw_mess = "We have a draw. #{name} and Computer are equally matched!"

    case win_lose_draw
    when 'wins'
      puts wins_mess
      break
    when 'lose'
      puts lose_mess
      break
    when 'draw'
      puts draw_mess
      break
    end
  end

  play_again = play_return(play_again)
  if play_again == 'N'
    break
  end
  puts 'Okay lets play another round.'
end

welcome('Thank you for playing TIC TAC TOE')



