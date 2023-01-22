#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

DB_USERNAME=$($PSQL "SELECT username FROM users WHERE username = '$USERNAME'")

if [[ -z $DB_USERNAME ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  ADD_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")

else
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE username = '$USERNAME' ")
  BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM games WHERE username = '$USERNAME' ")
  echo "Welcome back, $DB_USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."

fi

SECRET_NUMBER=$((1 + $RANDOM % 1000))
echo "Guess the secret number between 1 and 1000:"
read NUMBER
COUNT=1

while [[ $NUMBER != $SECRET_NUMBER ]]
do
  if [[ ! $NUMBER =~ ^[1-9][0-9]{0,2}$ ]]
  then
    echo "That is not an integer, guess again:"
    read NUMBER

  elif [[ $NUMBER > $SECRET_NUMBER ]]
  then
    echo "It's lower than that, guess again:"
    read NUMBER
    ((COUNT++))

  elif [[ $NUMBER < $SECRET_NUMBER ]]
  then
    echo "It's higher than that, guess again:"
    read NUMBER
    ((COUNT++))  
  fi
done

ADD_GAME=$($PSQL "INSERT INTO games(username, number_of_guesses) VALUES('$USERNAME', $COUNT) ")
echo "You guessed it in $COUNT tries. The secret number was $SECRET_NUMBER. Nice job!"
exit

