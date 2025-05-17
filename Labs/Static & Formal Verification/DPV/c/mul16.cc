#include "Hector.h"
#include "softfloat.h"

int float_rounding_mode = 0;

void hector_wrapper()
{

    uint8_t rounding_mode;
    uint8_t exceptions;
    
    uint16_t multiplier, multiplicand, product;
    float16_t f_multiplier, f_multiplicand, f_product;

    Hector::registerInput("multiplier", &multiplier, 8 * sizeof(multiplier));
    Hector::registerInput("multiplicand", &multiplicand, 8 * sizeof(multiplicand));
    Hector::registerInput("rounding_mode", &rounding_mode, 8 * sizeof(rounding_mode));
    
    Hector::registerOutput("product", &product, 8 * sizeof(product));
    Hector::registerOutput("exceptions", &exceptions, 8 * sizeof(exceptions));
    
    Hector::beginCapture();
    f_multiplier.v = multiplier;
    f_multiplicand.v = multiplicand;
    softfloat_roundingMode = rounding_mode;
    softfloat_exceptionFlags = 0;
    softfloat_detectTininess = softfloat_tininess_beforeRounding;
    
    f_product = f16_mul(f_multiplier, f_multiplicand);
    
    product = f_product.v;
    exceptions = softfloat_exceptionFlags & 0x1f;

    Hector::endCapture();
}
