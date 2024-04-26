#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
TOTAL_GUESSES=0
# make a random number
SECRET_NUMBER=$((1 + RANDOM % 1000))
# Note that only won games are considered in this implementation

CHECK_GUESS() {
	read GUESS
	# check if the input is an integer
	if [[ ! $GUESS =~ ^[0-9]+$ ]] # if it's not, prompt the user for an actual integer
	then
		echo "That is not an integer, guess again:"
		CHECK_GUESS
	# if it is, check whether it is lower or higher than the secret number
	elif [[ $SECRET_NUMBER -lt $GUESS ]] # if it's lower, state so
	then 
    TOTAL_GUESSES=$(($TOTAL_GUESSES + 1))
		echo "It's lower than that, guess again:"
		CHECK_GUESS
	elif [[ $SECRET_NUMBER -gt $GUESS ]] # if it's higher, state so
	then
    TOTAL_GUESSES=$(($TOTAL_GUESSES + 1))
		echo "It's higher than that, guess again:"
		CHECK_GUESS
	else # If the input it's not within the previous condition, it must mean it is the correct number
    TOTAL_GUESSES=$(($TOTAL_GUESSES + 1))
    return
	fi
}

# prompt the user
echo Enter your username:
read USERNAME
# check if the user exists
USER_RESULT=$($PSQL "SELECT games_played, num_of_guesses FROM users INNER JOIN games USING (user_id) WHERE users.username = '$USERNAME' ORDER BY num_of_guesses ASC LIMIT 1;")
if [[ -z $USER_RESULT ]] # if no user is found, I welcome the new user
then
  echo Welcome, $USERNAME! It looks like this is your first time here.
else # if the user is found, the number of games played and the number of guesses of the best game is shown
  echo "$USER_RESULT" | while IFS="|" read GAMES_PLAYED NUM_OF_GUESSES
    do
      echo Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $NUM_OF_GUESSES guesses.
      break
    done
fi
# if the user was previously not found, I insert it first
if [[ -z $USER_RESULT ]]
then
  INSERT_USERS=$($PSQL "INSERT INTO users (username) VALUES ('$USERNAME');")
else # else, I increment the amount of games played
  UPDATE_USERS=$($PSQL "UPDATE users SET games_played = games_played+1 WHERE username = '$USERNAME';")
fi
# games will be inserted with a num_of_guesses null which will be considered as not won 
INSERT_GAMES=$($PSQL "INSERT INTO games (user_id) VALUES ((SELECT user_id FROM users WHERE username = '$USERNAME'));")
# prompt the user to guess
echo "Guess the secret number between 1 and 1000:"
CHECK_GUESS
UPDATE_GAMES=$($PSQL "UPDATE games SET num_of_guesses = $TOTAL_GUESSES WHERE game_id = (SELECT MAX(game_id) FROM games);")
# finally I tell the user of his/her victory
echo "You guessed it in $TOTAL_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!" 