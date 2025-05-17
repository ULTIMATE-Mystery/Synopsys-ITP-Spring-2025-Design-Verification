#include "Hector.h"

#include <blitz/array.h>
using namespace blitz;


int main()
{
    int C00;
    int A[2][2];

    Hector::registerInput("A", A);
    Hector::registerOutput("C00", C00);
    Hector::beginCapture();

    Array<int, 2> B(2, 2);
    for (int i = 0; i < 2; i++)
    {
        for (int j = 0; j < 2; j++)
        {
            B(i, j) = A[i][j];
        }
    }

    Array<int, 2> X(2, 2);
    X = B;
    C00 = sum(X);

    Hector::endCapture();
}
