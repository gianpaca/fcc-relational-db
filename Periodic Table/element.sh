#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
MAIN() {
	if [[ -z $1 ]] # if no parameters is passed, it should ask for one and finish running
	then
		echo "Please provide an element as an argument."
	else
		ELEMENTS_SELECT="SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE elements."
		CONDITION=""
    # check if the provided parameter is an atomic number, a symbol or a name and assign the correct condition
		if [[ $1 =~ ^[0-9]+$ ]] # if it's a number (it's an atomic number)
		then
			CONDITION="atomic_number = $1"
		elif [[ ${#1} -lt 3 ]] # if it's a symbol
		then
			CONDITION="symbol = '$1'"
		else # if it's a name
			CONDITION="name = '$1'"
		fi
		# execute the corrisponding query
		ELEMENTS_RESULT=$($PSQL "$ELEMENTS_SELECT$CONDITION;")
		# if it's empty return message stating it's not in the database
		if [[ -z $ELEMENTS_RESULT ]]
		then
			echo "I could not find that element in the database."
		else
			# if it's in the database, print the relevant information
			echo "$ELEMENTS_RESULT" | while IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE ATOMIC_MASS MELTING_POINT BOILING_POINT
				do
					echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
					break
				done
		fi
	fi
}

MAIN $1
