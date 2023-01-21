#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

function main {
  #get the username 
  echo "Enter your username:"
  read USERNAME

  #get all existing usernames 
  USERNAMES=$($PSQL "SELECT username FROM users")
  NB_USERS=$($PSQL "SELECT COUNT(*) FROM users")

  COUNT=0
  COUNT_USERNAME=$($PSQL "SELECT COUNT(*) FROM users")
  
  echo "$USERNAMES" | while read EXISTING_USERNAME
  do 
    #count the number of users checked
    ((COUNT++))
    if [[ $USERNAME == $EXISTING_USERNAME ]]
    then
      #existing user
      #get user data
      USER_GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username = '$USERNAME'")
      USER_BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username = '$USERNAME'") 
      #message welcome again
      echo "Welcome back, $USERNAME! You have played $USER_GAMES_PLAYED games, and your best game took $USER_BEST_GAME guesses."
      game
      
    
    elif [[ $COUNT -eq $COUNT_USERNAME ]]
      then
      #new user
      #message welcome
      echo "Welcome, $USERNAME! It looks like this is your first time here."
      ADD_USER_TO_USERS=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
      #game

    fi
  done 
}



function game {

  #create a secret random number 
  SECRET_NUMBER=$((1 + $RANDOM % 1000))

  #get the user number guess
  echo "Guess the secret number between 1 and 1000:"
  
  unset USER_NUMBER
  read USER_NUMBER 

  while [[ ! $USER_NUMBER =~ ^[1-9][0-9]{0,2}$ ]]
  do
    echo "That is not an integer, guess again:"
    read USER_NUMBER
  done

  NUMBER_OF_GUESSES=1

  while [ $USER_NUMBER -ne $SECRET_NUMBER ];
  do
    if [ $USER_NUMBER -gt $SECRET_NUMBER ];
    then
      echo "It's lower than that, guess again:"
      read USER_NUMBER

    
    elif [ $USER_NUMBER -lt $SECRET_NUMBER ];
    then
      echo "It's higher than that, guess again:"
      read USER_NUMBER

    fi
    ((NUMBER_OF_GUESSES++))
  done

  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
  ADD_GAME=$($PSQL "INSERT INTO games(username, number_of_guesses) VALUES ('$USERNAME', '$NUMBER_OF_GUESSES')")
 
}


main 
