#include <iostream>

extern "C" int CalculateByVar(int n1, int n2, int op);
extern "C" int CalculateByString(const char* stringToCalculate, double* resultDiv);
extern "C" int CountPowerFactor(const char* s);

/*
	Using:
	write a number, then a space then operator (+,-,*,/), then space and then a number
	example: 123 * 2
*/

int main()
{
	char lineToCalculate[50];
	std::cin.get(lineToCalculate, 50);
	double resultDiv=0.0;
	int b = CalculateByString(lineToCalculate,&resultDiv);
	if(resultDiv==0.0)
		std::cout << b << std::endl;
	else
	std::cout << "division: " << resultDiv << std::endl;
}

