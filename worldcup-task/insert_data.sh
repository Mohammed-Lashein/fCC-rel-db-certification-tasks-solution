#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# teams insertion

# read each line in the games.csv file
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  #if we are not in the first_line
  if [[ $YEAR != 'year' ]]
  then 
      # check if the winner team name already exists teams tbl
      WINNER_TEAM_ID=$($PSQL "select team_id from teams where name='$WINNER'")
      if [[ -z $WINNER_TEAM_ID ]]
      then
          INSERT_WINNER_TEAM_RESULT=$($PSQL "insert into teams(name) values('$WINNER')")
          if [[ $INSERT_WINNER_TEAM_RESULT == "INSERT 0 1" ]]
          then 
          # echo "inserted winner into teams: $WINNER"
          #placing nothing in the then block would cause an err
          # so the solution is to use : which means do nothing but
          # satisfies bash syntacic requirements
          :
          fi
      fi
      
      # check if the opponent team name already exists in teams tbl
      OPPONENT_TEAM_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")
      if [[ -z $OPPONENT_TEAM_ID ]]
      then
          INSERT_OPPONENT_TEAM_RESULT=$($PSQL "insert into teams(name) values('$OPPONENT')")
          if [[ $INSERT_OPPONENT_TEAM_RESULT == "INSERT 0 1" ]]
          then
            # echo "inserted opponent into teams: $OPPONENT"
            :
          fi
      fi
  fi
done

echo "### below is game insertions ###"

#games insertion
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != 'year' ]]
then
# if does not exist, insert it 
WINNER_ID=$($PSQL "select team_id from teams where name='$WINNER'")
OPPONENT_ID=$($PSQL "select team_id from teams where name='$OPPONENT'")

INSERT_GAME_RESULT=$($PSQL "insert into games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) \
values($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")

if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
then
:
fi
fi
done
