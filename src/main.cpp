#include <iostream>	// cout
#include <fstream>	// ofstream
#include <cmath>	// sin

#define TWOPI (6.28318530718)

int main(int argc, char const *argv[])
{
	unsigned bufferSize = 1024;
	float *sig = new float[bufferSize];
	

	// Phase increment for each sample
	double phaseInc = TWOPI / bufferSize;

	// Fill the array with a single sinewave cycle
	for (unsigned i=0; i<bufferSize; i++)
	{
		sig[i] = sin(i * phaseInc);
	}


	// Write the float array in binary
	std::ofstream file("outfile", std::ios::binary);
	file.write((char*) sig, sizeof(float) * bufferSize);
	file.close();


	// Print statistics and exit
	std::cout << "Floats: " << bufferSize << "\tBytes: " << sizeof(float) * bufferSize << std::endl;
	return 0;
}