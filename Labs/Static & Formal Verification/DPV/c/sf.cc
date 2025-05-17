extern "C" {
#include "softfloat.h"
}
#include <stdio.h>

int float_rounding_mode = 0;

char SNAN[] = "S";
char QNAN[] = "Q";
char INF[] = "I";
char ZERO[] = "Z";
char DN[] = "D";
char REG[] = "R";

unsigned int plus = 0x00000000;
unsigned int minus = 0x80000000;

unsigned int values[] = {0x7fa05500, 0x7fe0aa00, 0x7f800000, 0x00000000, 0x3fc00000};
char *names[] = {SNAN, QNAN, INF, ZERO, REG};

int main()
{
    unsigned int count = 0;
    unsigned int mpier, mpcand;
    
    unsigned int rtype;
    
    uint8_t rounding_mode;
    uint8_t exceptions;

    uint32_t multiplier, multiplicand, addend, result;
    float32_t f_multiplier, f_multiplicand, f_addend, f_result;

    mpier = mpcand = 4;
    
    softfloat_roundingMode = 3;
    softfloat_detectTininess = softfloat_tininess_beforeRounding;

    for(softfloat_roundingMode = 0; softfloat_roundingMode < 4; softfloat_roundingMode++){

    printf("**** ROUNDING MODE = %d\n\n", softfloat_roundingMode);
//     for(int mpier = 3; mpier < 4; mpier++){
//         for(int mpcand = 4; mpcand < 5; mpcand++){
//             for(int addend = 3; addend < 4; addend++){
                for(int i = 0; i < 1; i++){
                    count++;
                    f_multiplier.v = 0x43ffffff;
                    f_multiplicand.v = 0x40ffffff;
                    f_addend.v = 0xc5800000;
                
//                     f_multiplier.v |= (i&4)<<29;
//                     f_multiplicand.v |= (i&2)<<30;
//                     f_addend.v |= (i&1)<<31;
                
                    softfloat_exceptionFlags = 0;
                    f_result = f32_mulAdd(f_multiplier, f_multiplicand, f_addend);
                    exceptions = softfloat_exceptionFlags & 0x1f;
                    
                    if(((f_result.v >> 21) & 0x3ff) == 0x3fd)
                        rtype = 0;
                    else if(((f_result.v >> 22) & 0x1ff) == 0x1ff)
                        rtype = 1;
                    else if(((f_result.v >> 23) & 0xff) == 0xff)
                        rtype = 2;
                    else if(((f_result.v & 0x7fffffff) == 0))
                        rtype = 3;
                    else if(((f_result.v & 0x7f800000) == 0) && ((f_result.v & 0x007fffff) != 0))
                        rtype = 4;
                    else
                        rtype = 5;
                    rtype = 4;
                    printf("%s, %8.8x, %s, %8.8x,  %s, %8.8x,  %s, %8.8x, %2.2x\n",
                           names[mpier], f_multiplier.v, names[mpcand], f_multiplicand.v, names[mpcand], f_addend.v,
                           names[rtype], f_result.v, softfloat_exceptionFlags);
//                 }
//             }
//         }
    }
    }
    printf("Total cases: %d\n", count);
    return 0;
}
