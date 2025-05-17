#include "softfloat.h"
#include <stdio.h>

int float_rounding_mode = 0;

int main()
{
    uint8_t rounding_mode;
    
    uint32_t multiplier, multiplicand, product;
    float32_t f_multiplier, f_multiplicand, f_product;

    f_multiplier.v = 0x7e7fffff;
    f_multiplicand.v = 0x797fffff;
    softfloat_roundingMode = 1;
    
    f_product = f32_mul(f_multiplier, f_multiplicand);

    printf("Result=%x\n",f_product.v);
}
