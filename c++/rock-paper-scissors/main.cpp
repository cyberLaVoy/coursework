#include <iostream>
#include "rps.h"

int main() 
{
	bool continue_game = true;
	int number_user_wins = 0;
	int number_user_losses = 0;
	int number_user_ties = 0;

	while (continue_game) {
		initializeRandomNumbers( );
		int random_choice = getRandomPlayerChoice( );
		int user_choice = getUserPlayerChoice( std::cin, std::cout );
		int result = determineWinner( user_choice, random_choice );
		if (result == 11) {
			number_user_wins++;
		}
		if (result == 12) {
			number_user_losses++;
		}
		if (result == 13) {
			number_user_ties++;
		}
		std::cout << "*****Match Results***** \n";
		displayMatchResults( std::cout, user_choice, random_choice, result );
		std::cout << "*****Current Stats***** \n";
		displayStatistics( std::cout, number_user_wins, number_user_losses, number_user_ties );
		continue_game = askUserIfGameShouldContinue( std::cin, std::cout);
	}
	return 0;
}
