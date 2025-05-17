#include "Hector.h"
#include "softfloat.h"

int float_rounding_mode = 0;

void hector_wrapper()
{
    uint8_t rounding_mode;
    uint8_t exceptions;
    
    uint32_t multiplier, multiplicand, addend, result;
    float32_t f_multiplier, f_multiplicand, f_addend, f_result;

    Hector::registerInput("multiplier", &multiplier, 8 * sizeof(multiplier));
    Hector::registerInput("multiplicand", &multiplicand, 8 * sizeof(multiplicand));
    Hector::registerInput("addend", &addend, 8 * sizeof(addend));
    Hector::registerInput("rounding_mode", &rounding_mode, 8 * sizeof(rounding_mode));
    
    Hector::registerOutput("result", &result, 8 * sizeof(result));
    Hector::registerOutput("exceptions", &exceptions, 8 * sizeof(exceptions));
    
    Hector::beginCapture();
    f_multiplier.v = multiplier;
    f_multiplicand.v = multiplicand;
    f_addend.v = addend;

    softfloat_roundingMode = rounding_mode;
    softfloat_exceptionFlags = 0;
    softfloat_detectTininess = softfloat_tininess_beforeRounding;
    
    f_result = f32_mulAdd(f_multiplier, f_multiplicand, f_addend);

    result = f_result.v;    
    exceptions = softfloat_exceptionFlags & 0x1f;
    
    Hector::endCapture();
}
