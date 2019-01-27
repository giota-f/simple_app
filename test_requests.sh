#!/bin/bash
printf "If run in clean DB\n"
#this should not be ok
printf "Expected:nok\n"
curl -H "Content-Type: application/json" -d '{"id":1, "first_name":"John", "last_name":"Collins", "email":"jcollins@testmail.com", "ip_address":"247.11.125.85"}' http://localhost:5000/saveUser 
printf "\n"
#this should not be ok
printf "Expected:nok\n"
curl -H "Content-Type: application/json" -d '{"id":2, "last_name":"Collins", "email":"jcollins@testmail.com", "ip_address":"247.11.125.85", "gender":"Male"}' http://localhost:5000/saveUser 
printf "\n"
#this should be ok
printf "Expected:ok\n"
curl -H "Content-Type: application/json" -d '{"id":2, "first_name":"John", "last_name":"Collins", "email":"jcollins@testmail.com", "ip_address":"247.11.125.85", "gender":"Male"}' http://localhost:5000/saveUser 
printf "\n"
#this should be ok
printf "Expected:ok\n"
curl -H "Content-Type: application/json" -d '{"id":3, "first_name":"John", "last_name":"Collins", "email":"jcollins@testmail.com", "ip_address":"247.11.125.85", "gender":"Male"}' http://localhost:5000/saveUser 
printf "\n"
#this should not be ok
printf "Expected:nok\n"
curl -H "Content-Type: application/json" -d '{"id":"1", "first_name":"John", "last_name":"Collins", "email":"jcollins@testmail.com", "ip_address":"247.11.125.85"}' http://localhost:5000/saveUser 
printf "\n"
#this should be ok
printf "Expected:ok\n"
curl -H "Content-Type: application/json" -d '{"id":1, "first_name":"Mark", "last_name":"Newton", "email":"mnewton@testmail.com", "ip_address":"247.11.125.85", "gender":"Male"}' http://localhost:5000/saveUser 
printf "\n"
#this should be ok
printf "Expected:ok\n"
curl -H "Content-Type: application/json" -d '{"id":4, "first_name":"Maria", "last_name":"Anderson", "email":"manderson@testmail.com", "ip_address":"247.11.125.86", "gender":"Female"}' http://localhost:5000/saveUser 
printf "\n"
#this should always return one email. Email is unique
printf "Expected:get one entry\n"
curl -X GET http://localhost:5000/getUser/email/jcollins@testmail.com
printf "\n"
#this should return 2 entries. Users can share the same ip_address
printf "Expected:get two entries\n"
curl -X GET http://localhost:5000/getUser/ip_address/247.11.125.85

