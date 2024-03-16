#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams;")
INSERT="INSERT INTO table(...) VALUES()()();"
TEAM_VALUES=""
GAME_VALUES=""
# Read files and values
while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # Filter out header
  if [[ $YEAR != "year" ]]
  then
    # Build team insert values string
    # First we check if the string is empty and we initialize it with the first opponent
    # Check if string is empty and add first value without a comma
    if [[ -z $TEAM_VALUES ]]
    then
      TEAM_VALUES="('$OPPONENT')"
    fi
    # Then, to guarantee we have all teams, we check both winner and opponent to see if they are already in our list
    # Check if opponent is on the list
    if [[ $TEAM_VALUES != *"'$OPPONENT'"* ]]
    then
      # If not, add it
      TEAM_VALUES="$TEAM_VALUES,('$OPPONENT')"
    fi
    # Check if winner is on the list
    if [[ $TEAM_VALUES != *"'$WINNER'"* ]]
    then
      # If not, add it
      TEAM_VALUES="$TEAM_VALUES,('$WINNER')"
    fi
    # Insert games
    if [[ -z $GAME_VALUES ]]
    then
      # If not, add it
      GAME_VALUES="($YEAR, '$ROUND', (SELECT team_id FROM teams WHERE name='$WINNER'), (SELECT team_id FROM teams WHERE name='$OPPONENT'), $WINNER_GOALS, $OPPONENT_GOALS)"
    else
      GAME_VALUES="$GAME_VALUES,($YEAR, '$ROUND', (SELECT team_id FROM teams WHERE name='$WINNER'), (SELECT team_id FROM teams WHERE name='$OPPONENT'), $WINNER_GOALS, $OPPONENT_GOALS)"
    fi
  fi
done < <(cat games.csv)
# Insert unique team values into teams table
echo $($PSQL "INSERT INTO teams(name) VALUES$TEAM_VALUES;")
# Insert game data into games table
echo $($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES$GAME_VALUES;")