#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon -t -c"
SELECT_SERVICE() {
  echo "What service are you interested in?"
  # get services from db
  LIST_OF_SERVICES=$($PSQL "SELECT service_id, name FROM services;")
  # print list of services
  echo "$LIST_OF_SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done
  # lastly, print also the Exit option
  echo -e "\n0) Exit"
  # read choice
  read SERVICE_ID_SELECTED
  
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
  
  if [[ $SERVICE_ID_SELECTED == 0 ]] # if 0, exit
  then
	EXIT
  elif [[ ! -z $SERVICE_NAME ]] # if the query found the service, schedule the appointment
  then
	echo -e "\nWhat's your phone number?"
	read CUSTOMER_PHONE
	# if phone isn't registered, there won't be any name associated with it
	CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")

	if [[ -z $CUSTOMER_NAME ]] # if there's no name, prompt for the name 
	then
	  # get new customer name
	  echo -e "\nWhat's your name?"
	  read CUSTOMER_NAME

	  # insert new customer
	  INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone)  VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
	fi
	
	# ask for the service time
	echo -e "\nAt what time would you like your appointment to be?"
	read SERVICE_TIME
	
	INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES((SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'), $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
	
	echo "I have put you down for a $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
	
	EXIT 
	
	# Alternatively, ask if there's interest in another service
	# echo "Anything we may help you with?"
	# SELECT_SERVICE 
	
  else # if not present, reprint list of services
	echo -e "\nPlease select a valid service number."
	SELECT_SERVICE 
  fi
}

EXIT() {
  echo -e "\nThank you for your patronage.\n"
}

SELECT_SERVICE
