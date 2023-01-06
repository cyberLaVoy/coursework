#include <iostream>
#include <ctime>
#include <cstdlib>
#include <string>
#include "rps.h"

void initializeRandomNumbers( )
{
	int seed = std::time( 0 );
	std::srand( seed );
}
int getRandomPlayerChoice( )
{
	int random_choice = std::rand( );
	random_choice = random_choice % 3;
	random_choice = random_choice + 1;
	return random_choice;
}
int getUserPlayerChoice( std::istream& input_stream, std::ostream& output_stream )
{
	int player_choice;
	output_stream << "Object of choice (rock, paper, or scissors): ";
	std::string object_choice;
	input_stream >> object_choice;
	while (object_choice != "rock" && object_choice != "paper" && object_choice != "scissors") {
		output_stream  << "Invalid choice. Please choose again. \n";
		output_stream << "Object of choice: ";
		input_stream >> object_choice;
	}
	if (object_choice == "rock") {
		player_choice = 1;
	}
	if (object_choice == "paper") {
		player_choice = 2;
	}
	if (object_choice == "scissors") {
		player_choice = 3;
	}
	return player_choice;
}
int determineWinner( int user_choice, int random_choice )
{
	int result;
	if (user_choice == random_choice) {
		result = 13;
	}
	else if (user_choice == 1 && random_choice == 3) {
		result = 11;
	}
	else if (user_choice == 2 && random_choice == 1) {
		result = 11;
	}
	else if (user_choice == 3 && random_choice == 2) {
		result = 11;
	}
	else {
		result = 12;
	}
	return result;
}
void displayMatchResults( std::ostream& output_stream, int user_choice, int random_choice, int winner )
{
	std::string player_object;
	std::string computer_object;
	if (user_choice == 1) {
		player_object = "rock";
	}
	if (user_choice == 2) {
		player_object = "paper";
	}
	if (user_choice == 3) {
		player_object = "scissors";
	}
	if (random_choice == 1) {
		computer_object = "rock";
	}
	if (random_choice == 2) {
		computer_object = "paper";
	}
	if (random_choice == 3) {
		computer_object = "scissors";
	}
	output_stream << "Your choice: " << player_object << "\n";
	output_stream << "Computer's choice: " << computer_object << "\n";

	if (winner == 13) {
		output_stream << "Tie. \n";
	}
	else if (winner == 11) {
		output_stream << "You win. \n";
	}
	else {
		output_stream << "Computer wins. \n";
	}
}
void displayStatistics( std::ostream& output_stream, int number_user_wins, int number_user_losses, int number_user_ties )
{

	output_stream << "Total wins: " << number_user_wins << "\n";
	output_stream << "Losses: " << number_user_losses << "\n";
	output_stream << "Ties: " << number_user_ties << "\n";
}
bool askUserIfGameShouldContinue( std::istream& input_stream, std::ostream& output_stream )
{
	bool choice;
	std::string input_value;
	output_stream << "Continue?? ";
	input_stream >> input_value;
	if (input_value[0] == 'y' or input_value[0] == 'Y') {
		choice = true;	
	}
	else {
		choice = false;
	}
	return choice;
}

