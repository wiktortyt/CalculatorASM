#include <iostream>

extern "C" int CalculateByVar(int n1, int n2, int op);
extern "C" int CalculateByString(const char* stringToCalculate);
extern "C" int CountPowerFactor(const char* s);

/*
	Using:
	write a number, then a space then operator (+,-,*), then space and then a number
*/

int main()
{
	char lineToCalculate[50];
	std::cin.get(lineToCalculate, 50);
	int b = CalculateByString(lineToCalculate);
	std::cout << b << std::endl;

}

