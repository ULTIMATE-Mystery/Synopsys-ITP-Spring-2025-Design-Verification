extern "C" {
#include "softfloat.h"
}
#include <stdio.h>
using namespace std;

int float_rounding_mode = 0;

int main()
{
//     char *modes[][] = 
//         {
//             "ROUND_NEAREST_EVEN",
//             "ROUND_TO_ZERO",
//             "ROUND_MINUS_INF",
//             "ROUND_PLUS_INF"
//         }
//     ;
            
    unsigned int count = 0;
    uint64_t a, b, c, r;
    
    uint8_t rounding_mode;
    uint8_t exceptions;

    uint64_t multiplier, multiplicand, addend, result;
    float64_t f_multiplier, f_multiplicand, f_addend, f_result;
    
    softfloat_detectTininess = softfloat_tininess_beforeRounding;

    printf("\n  Multiplier: ");
    scanf("%llx",&a);
    printf("Multiplicand: ");
    scanf("%llx",&b);
    printf("      Addend: ");
    scanf("%llx",&c);
    printf("  Round Mode: ");
    scanf("%d",&r);

    f_multiplier.v = a;
    f_multiplicand.v = b;
    f_addend.v = c;
    softfloat_roundingMode = r;
    softfloat_exceptionFlags = 0;

    f_result = f64_mulAdd(f_multiplier, f_multiplicand, f_addend);
    exceptions = softfloat_exceptionFlags & 0x1f;

    printf("\nWith RM: %d, %16.16llX * %16.16llX + %16.16llX = %16.16llX, EX=%2.2X\n", r, a, b, c, f_result.v, softfloat_exceptionFlags);
    return 0;
}
