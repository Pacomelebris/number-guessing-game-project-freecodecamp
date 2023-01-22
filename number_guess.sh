#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

function main {
  #get the username 
  echo "Enter your username:"
  read INPUT_USERNAME

  #get all existing usernames 
  USERNAMES=$($PSQL "SELECT username FROM users")
  NB_USERS=$($PSQL "SELECT COUNT(*) FROM users")

  #check if the user exist already or not
  #initialize the count of users
  COUNT=0
  COUNT_USERNAME=$($PSQL "SELECT COUNT(*) FROM users")
  echo "nb_users: $COUNT_USERNAME"
  
  echo "$USERNAMES" | while read EXISTING_USERNAME
  do 
    
    #count the number of users checked
    ((COUNT++))
    echo "count: $COUNT"

    if [[ $INPUT_USERNAME == $EXISTING_USERNAME ]]
    then
      #existing user
      #get user data
      USER_GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$INPUT_USERNAME'")
      USER_BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$INPUT_USERNAME'") 
      #message welcome again
      echo "Welcome back, $EXISTING_USERNAME! You have played $USER_GAMES_PLAYED games, and your best game took $USER_BEST_GAME guesses."
      break

    elif [[ $COUNT -eq $COUNT_USERNAME ]]
      then
      #new user
      #message welcome
      echo "Welcome, $INPUT_USERNAME! It looks like this is your first time here."
      ADD_USER_TO_USERS=$($PSQL "INSERT INTO users(username) VALUES('$INPUT_USERNAME')")
      break

    fi
    
  done
  game $INPUT_USERNAME
}



function game {

  #get the username of the pplayer from the main function
  INPUT_USERNAME=$1
  
  #create a secret random number 
  SECRET_NUMBER=$((1 + $RANDOM % 1000))
  echo "$SECRET_NUMBER"

  #get the user number guess
  unset USER_NUMBER
  echo "Guess the secret number between 1 and 1000:"
  read USER_NUMBER 

  #if not an int between 1 and 1000
  while [[ ! $USER_NUMBER =~ ^[1-9][0-9]{0,2}$ ]]
  do
    echo "That is not an integer, guess again:"
    read USER_NUMBER
  done

  #while the secret number is not found
  #initialize the count of guesses
  NUMBER_OF_GUESSES=1
  while [[ $USER_NUMBER != $SECRET_NUMBER ]];
  do

    #if the input is higher
    if [[ $USER_NUMBER > $SECRET_NUMBER ]];
    then
      echo "It's lower than that, guess again:"
      read USER_NUMBER
      
      #if not an int between 1 and 1000
      while [[ ! $USER_NUMBER =~ ^[1-9][0-9]{0,2}$ ]]
      do
        echo "That is not an integer, guess again:"
        read USER_NUMBER
      done

    
    #if the input is lower
    elif [[ $USER_NUMBER < $SECRET_NUMBER ]];
    then
      echo "It's higher than that, guess again:"
      read USER_NUMBER
      
      #if not an int between 1 and 1000
      while [[ ! $USER_NUMBER =~ ^[1-9][0-9]{0,2}$ ]]
      do
        echo "That is not an integer, guess again:"
        read USER_NUMBER
      done

    fi

    #count the number of guesses
    ((NUMBER_OF_GUESSES++))
  done

  #add the game data to the table games
  ADD_GAME=$($PSQL "INSERT INTO games(username, number_of_guesses, secret_number) VALUES ('$INPUT_USERNAME', '$NUMBER_OF_GUESSES', $SECRET_NUMBER)")

  #get data of the game from games table
  GAME_NUMBER_OF_GUESSES=$($PSQL "SELECT number_of_guesses FROM games WHERE game_id = (SELECT MAX(game_id) FROM games)")
  GAME_SECRET_NUMBER=$($PSQL "SELECT secret_number FROM games WHERE game_id = (SELECT MAX(game_id) FROM games)")

  #print the recap of the game
  echo -e "\nYou guessed it in $GAME_NUMBER_OF_GUESSES tries. The secret number was $GAME_SECRET_NUMBER. Nice job!"

  #get users data
  TOTAL_GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE username = '$INPUT_USERNAME'")
  BEST_GAME_PLAYED=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE username = '$INPUT_USERNAME'")

  #update data of users table
  UPDATE_TOTAL_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played = $TOTAL_GAMES_PLAYED, best_game = $BEST_GAME_PLAYED WHERE username = '$INPUT_USERNAME'")
}


main 
