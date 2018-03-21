#! /bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function test_return_ok()
{
	if [ $? == 0 ];then
		printf " $GREEN""OK""$NC"
	else
		printf " $RED""NOK""$NC"
	fi
	printf "\n"
	return
}

function test_return_nok()
{
	if [ $? == 0 ];then
		printf " $RED""NOK""$NC"
	else
		printf " $GREEN""OK""$NC"
	fi
	printf "\n"
	return
}


make
printf "TEST WITH A FILE DOES NOT EXIST\n"
printf "Test grep error message."
./rt "BONJOUR" 2>&1 | grep -q "BONJOUR file does not exist"
test_return_ok

printf "Test Check return."
./rt "BONJOUR" 2> /dev/null
test_return_nok

printf "Test missing light data."
./rt scenes/scene_missing_light_data.json > /dev/null
test_return_ok

printf "Test missing camera data."
./rt scenes/scene_missing_camera_data.json > /dev/null
test_return_ok

printf "Test missing object data."
./rt scenes/scene_missing_object_data.json > /dev/null
test_return_ok

printf "Test invalid type."
./rt scenes/scene_invalid_type.json > /dev/null
test_return_ok
