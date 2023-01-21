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
      echo "Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses."
      
    
    else
      #new user
      #message welcome
      echo "Welcome, $USERNAME! It looks like this is your first time here."
      ADD_USER_TO_USERS=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    fi
  done 
}

main 
