#ifndef _BLITZ_GNU_BZCONFIG_H
#define _BLITZ_GNU_BZCONFIG_H 1
 
/* blitz/gnu/bzconfig.h. Generated automatically at end of configure. */
/* blitz/config.h.  Generated from config.h.in by configure.  */
/* blitz/config.h.in.  Generated from configure.ac by autoheader.  */


/******************************************************************************
 * config.h           Compiler language support flags
 *
 * This file was generated automatically when running the configure script.
 * You should rerun configure each time you switch compilers, install new
 * standard libraries, or change compiler versions.
 *
 */



/* Macro for declaring aligned variables */
#ifndef BZ_ALIGN_VARIABLE 
#define BZ_ALIGN_VARIABLE(vartype,varname,alignment) vartype varname; 
#endif

/* Enable dimensions with > 2^31 elements (NOT IMPLEMENTED) */
/* #undef BZ_FULLY64BIT */

/* define if bool is a built-in type */
#ifndef BZ_HAVE_BOOL 
#define BZ_HAVE_BOOL /**/ 
#endif

/* define if the Boost library is available */
/* #undef BZ_HAVE_BOOST */

/* Define to 1 if you have the <boost/mpi.hpp> header file. */
/* #undef BZ_HAVE_BOOST_MPI_HPP */

/* define if the Boost::Serialization library is available */
/* #undef BZ_HAVE_BOOST_SERIALIZATION */

/* define if the compiler has <climits> header */
#ifndef BZ_HAVE_CLIMITS 
#define BZ_HAVE_CLIMITS /**/ 
#endif

/* define if the compiler has complex<T> */
#ifndef BZ_HAVE_COMPLEX 
#define BZ_HAVE_COMPLEX /**/ 
#endif

/* define if the compiler has standard complex<T> functions */
#ifndef BZ_HAVE_COMPLEX_FCNS 
#define BZ_HAVE_COMPLEX_FCNS /**/ 
#endif

/* define if the compiler has complex math functions */
#ifndef BZ_HAVE_COMPLEX_MATH1 
#define BZ_HAVE_COMPLEX_MATH1 /**/ 
#endif

/* define if the compiler has more complex math functions */
/* #undef BZ_HAVE_COMPLEX_MATH2 */

/* define if complex math functions are in namespace std */
#ifndef BZ_HAVE_COMPLEX_MATH_IN_NAMESPACE_STD 
#define BZ_HAVE_COMPLEX_MATH_IN_NAMESPACE_STD /**/ 
#endif

/* define if the compiler supports const_cast<> */
#ifndef BZ_HAVE_CONST_CAST 
#define BZ_HAVE_CONST_CAST /**/ 
#endif

/* Define to 1 if you have the <cstring> header file. */
#ifndef BZ_HAVE_CSTRING 
#define BZ_HAVE_CSTRING 1 
#endif

/* define if the compiler supports default template parameters */
#ifndef BZ_HAVE_DEFAULT_TEMPLATE_PARAMETERS 
#define BZ_HAVE_DEFAULT_TEMPLATE_PARAMETERS /**/ 
#endif

/* Define to 1 if you have the <dlfcn.h> header file. */
#ifndef BZ_HAVE_DLFCN_H 
#define BZ_HAVE_DLFCN_H 1 
#endif

/* define if the compiler supports dynamic_cast<> */
#ifndef BZ_HAVE_DYNAMIC_CAST 
#define BZ_HAVE_DYNAMIC_CAST /**/ 
#endif

/* define if the compiler handle computations inside an enum */
#ifndef BZ_HAVE_ENUM_COMPUTATIONS 
#define BZ_HAVE_ENUM_COMPUTATIONS /**/ 
#endif

/* define if the compiler handles (int) casts in enum computations */
#ifndef BZ_HAVE_ENUM_COMPUTATIONS_WITH_CAST 
#define BZ_HAVE_ENUM_COMPUTATIONS_WITH_CAST /**/ 
#endif

/* define if the compiler supports exceptions */
#ifndef BZ_HAVE_EXCEPTIONS 
#define BZ_HAVE_EXCEPTIONS /**/ 
#endif

/* define if the compiler supports the explicit keyword */
#ifndef BZ_HAVE_EXPLICIT 
#define BZ_HAVE_EXPLICIT /**/ 
#endif

/* define if the compiler supports explicit template function qualification */
#ifndef BZ_HAVE_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION 
#define BZ_HAVE_EXPLICIT_TEMPLATE_FUNCTION_QUALIFICATION /**/ 
#endif

/* define if the compiler recognizes the full specialization syntax */
#ifndef BZ_HAVE_FULL_SPECIALIZATION_SYNTAX 
#define BZ_HAVE_FULL_SPECIALIZATION_SYNTAX /**/ 
#endif

/* define if the compiler supports function templates with non-type parameters
   */
#ifndef BZ_HAVE_FUNCTION_NONTYPE_PARAMETERS 
#define BZ_HAVE_FUNCTION_NONTYPE_PARAMETERS /**/ 
#endif

/* define if the compiler supports IEEE math library */
#ifndef BZ_HAVE_IEEE_MATH 
#define BZ_HAVE_IEEE_MATH /**/ 
#endif

/* Define to 1 if you have the <inttypes.h> header file. */
#ifndef BZ_HAVE_INTTYPES_H 
#define BZ_HAVE_INTTYPES_H 1 
#endif

/* Define to 1 if you have the `m' library (-lm). */
/* #undef BZ_HAVE_LIBM */

/* Define to 1 if you have the `papi' library (-lpapi). */
/* #undef BZ_HAVE_LIBPAPI */

/* define if the compiler supports member constants */
#ifndef BZ_HAVE_MEMBER_CONSTANTS 
#define BZ_HAVE_MEMBER_CONSTANTS /**/ 
#endif

/* define if the compiler supports member templates */
#ifndef BZ_HAVE_MEMBER_TEMPLATES 
#define BZ_HAVE_MEMBER_TEMPLATES /**/ 
#endif

/* define if the compiler supports member templates outside the class
   declaration */
#ifndef BZ_HAVE_MEMBER_TEMPLATES_OUTSIDE_CLASS 
#define BZ_HAVE_MEMBER_TEMPLATES_OUTSIDE_CLASS /**/ 
#endif

/* Define to 1 if you have the <memory.h> header file. */
#ifndef BZ_HAVE_MEMORY_H 
#define BZ_HAVE_MEMORY_H 1 
#endif

/* define if the compiler supports the mutable keyword */
#ifndef BZ_HAVE_MUTABLE 
#define BZ_HAVE_MUTABLE /**/ 
#endif

/* define if the compiler implements namespaces */
#ifndef BZ_HAVE_NAMESPACES 
#define BZ_HAVE_NAMESPACES /**/ 
#endif

/* define if the compiler supports the Numerical C Extensions Group restrict
   keyword */
/* #undef BZ_HAVE_NCEG_RESTRICT */

/* define if the compiler supports the __restrict__ keyword */
#ifndef BZ_HAVE_NCEG_RESTRICT_EGCS 
#define BZ_HAVE_NCEG_RESTRICT_EGCS /**/ 
#endif

/* define if the compiler has numeric_limits<T> */
#ifndef BZ_HAVE_NUMERIC_LIMITS 
#define BZ_HAVE_NUMERIC_LIMITS /**/ 
#endif

/* define if the compiler accepts the old for scoping rules */
/* #undef BZ_HAVE_OLD_FOR_SCOPING */

/* define if the compiler supports partial ordering */
#ifndef BZ_HAVE_PARTIAL_ORDERING 
#define BZ_HAVE_PARTIAL_ORDERING /**/ 
#endif

/* define if the compiler supports partial specialization */
#ifndef BZ_HAVE_PARTIAL_SPECIALIZATION 
#define BZ_HAVE_PARTIAL_SPECIALIZATION /**/ 
#endif

/* define if the compiler supports reinterpret_cast<> */
#ifndef BZ_HAVE_REINTERPRET_CAST 
#define BZ_HAVE_REINTERPRET_CAST /**/ 
#endif

/* define if the compiler supports Run-Time Type Identification */
//#ifndef BZ_HAVE_RTTI 
//#define BZ_HAVE_RTTI /**/ 
//#endif
#undef BZ_HAVE_RTTI

/* define if the compiler has getrusage() function */
#ifndef BZ_HAVE_RUSAGE 
#define BZ_HAVE_RUSAGE /**/ 
#endif

/* define if the compiler supports static_cast<> */
#ifndef BZ_HAVE_STATIC_CAST 
#define BZ_HAVE_STATIC_CAST /**/ 
#endif

/* define if the compiler supports ISO C++ standard library */
#ifndef BZ_HAVE_STD 
#define BZ_HAVE_STD /**/ 
#endif

/* Define to 1 if you have the <stdint.h> header file. */
#ifndef BZ_HAVE_STDINT_H 
#define BZ_HAVE_STDINT_H 1 
#endif

/* Define to 1 if you have the <stdlib.h> header file. */
#ifndef BZ_HAVE_STDLIB_H 
#define BZ_HAVE_STDLIB_H 1 
#endif

/* define if the compiler supports Standard Template Library */
#ifndef BZ_HAVE_STL 
#define BZ_HAVE_STL /**/ 
#endif

/* Define to 1 if you have the <strings.h> header file. */
#ifndef BZ_HAVE_STRINGS_H 
#define BZ_HAVE_STRINGS_H 1 
#endif

/* Define to 1 if you have the <string.h> header file. */
#ifndef BZ_HAVE_STRING_H 
#define BZ_HAVE_STRING_H 1 
#endif

/* define if the compiler supports System V math library */
/* #undef BZ_HAVE_SYSTEM_V_MATH */

/* Define to 1 if you have the <sys/stat.h> header file. */
#ifndef BZ_HAVE_SYS_STAT_H 
#define BZ_HAVE_SYS_STAT_H 1 
#endif

/* Define to 1 if you have the <sys/types.h> header file. */
#ifndef BZ_HAVE_SYS_TYPES_H 
#define BZ_HAVE_SYS_TYPES_H 1 
#endif

/* Define to 1 if you have the <tbb/atomic.h> header file. */
/* #undef BZ_HAVE_TBB_ATOMIC_H */

/* define if the compiler supports basic templates */
#ifndef BZ_HAVE_TEMPLATES 
#define BZ_HAVE_TEMPLATES /**/ 
#endif

/* define if the compiler supports templates as template arguments */
#ifndef BZ_HAVE_TEMPLATES_AS_TEMPLATE_ARGUMENTS 
#define BZ_HAVE_TEMPLATES_AS_TEMPLATE_ARGUMENTS /**/ 
#endif

/* define if the compiler supports use of the template keyword as a qualifier
   */
#ifndef BZ_HAVE_TEMPLATE_KEYWORD_QUALIFIER 
#define BZ_HAVE_TEMPLATE_KEYWORD_QUALIFIER /**/ 
#endif

/* define if the compiler supports template-qualified base class specifiers */
#ifndef BZ_HAVE_TEMPLATE_QUALIFIED_BASE_CLASS 
#define BZ_HAVE_TEMPLATE_QUALIFIED_BASE_CLASS /**/ 
#endif

/* define if the compiler supports template-qualified return types */
#ifndef BZ_HAVE_TEMPLATE_QUALIFIED_RETURN_TYPE 
#define BZ_HAVE_TEMPLATE_QUALIFIED_RETURN_TYPE /**/ 
#endif

/* define if the compiler supports function matching with argument types which
   are template scope-qualified */
#ifndef BZ_HAVE_TEMPLATE_SCOPED_ARGUMENT_MATCHING 
#define BZ_HAVE_TEMPLATE_SCOPED_ARGUMENT_MATCHING /**/ 
#endif

/* define if the compiler recognizes typename */
#ifndef BZ_HAVE_TYPENAME 
#define BZ_HAVE_TYPENAME /**/ 
#endif

/* define if the compiler supports the vector type promotion mechanism */
#ifndef BZ_HAVE_TYPE_PROMOTION 
#define BZ_HAVE_TYPE_PROMOTION /**/ 
#endif

/* Define to 1 if you have the <unistd.h> header file. */
#ifndef BZ_HAVE_UNISTD_H 
#define BZ_HAVE_UNISTD_H 1 
#endif

/* define if the compiler supports numeric traits promotions */
#ifndef BZ_HAVE_USE_NUMTRAIT 
#define BZ_HAVE_USE_NUMTRAIT /**/ 
#endif

/* define if the compiler has valarray<T> */
#ifndef BZ_HAVE_VALARRAY 
#define BZ_HAVE_VALARRAY /**/ 
#endif

/* define if the compiler has isnan function in namespace std */
#ifndef BZ_ISNAN_IN_NAMESPACE_STD 
#define BZ_ISNAN_IN_NAMESPACE_STD /**/ 
#endif

/* Define to the sub-directory in which libtool stores uninstalled libraries.
   */
#ifndef BZ_LT_OBJDIR 
#define BZ_LT_OBJDIR ".libs/" 
#endif

/* define if the compiler has C math abs(integer types) in namespace std */
#ifndef BZ_MATH_ABSINT_IN_NAMESPACE_STD 
#define BZ_MATH_ABSINT_IN_NAMESPACE_STD /**/ 
#endif

/* define if the compiler has C math functions in namespace std */
#ifndef BZ_MATH_FN_IN_NAMESPACE_STD 
#define BZ_MATH_FN_IN_NAMESPACE_STD /**/ 
#endif

/* Name of package */
#ifndef BZ_PACKAGE 
#define BZ_PACKAGE "blitz" 
#endif

/* Define to the address where bug reports for this package should be sent. */
#ifndef BZ_PACKAGE_BUGREPORT 
#define BZ_PACKAGE_BUGREPORT "blitz-support@lists.sourceforge.net" 
#endif

/* Define to the full name of this package. */
#ifndef BZ_PACKAGE_NAME 
#define BZ_PACKAGE_NAME "blitz" 
#endif

/* Define to the full name and version of this package. */
#ifndef BZ_PACKAGE_STRING 
#define BZ_PACKAGE_STRING "blitz 0.10" 
#endif

/* Define to the one symbol short name of this package. */
#ifndef BZ_PACKAGE_TARNAME 
#define BZ_PACKAGE_TARNAME "blitz" 
#endif

/* Define to the home page for this package. */
#ifndef BZ_PACKAGE_URL 
#define BZ_PACKAGE_URL "" 
#endif

/* Define to the version of this package. */
#ifndef BZ_PACKAGE_VERSION 
#define BZ_PACKAGE_VERSION "0.10" 
#endif

/* Pad array lengths to SIMD width. */
/* #undef BZ_PAD_ARRAYS */

/* Set SIMD instruction width in bytes */
#ifndef BZ_SIMD_WIDTH 
#define BZ_SIMD_WIDTH 1 
#endif

/* Define to 1 if you have the ANSI C header files. */
#ifndef BZ_STDC_HEADERS 
#define BZ_STDC_HEADERS 1 
#endif

/* Enable Blitz thread-safety features */
/* #undef BZ_THREADSAFE */

/* Use TBB atomic types */
/* #undef BZ_THREADSAFE_USE_TBB */

/* Specifies whether compiler alignment pragmas should be used */
/* #undef BZ_USE_ALIGNMENT_PRAGMAS */

/* Version number of package */
#ifndef BZ_VERSION 
#define BZ_VERSION "0.10" 
#endif

/* CXX */
#ifndef BZ__compiler_name 
#define BZ__compiler_name "c++" 
#endif

/* CXXFLAGS */
#ifndef BZ__compiler_options 
#define BZ__compiler_options "" 
#endif

/* date */
#ifndef BZ__config_date 
#define BZ__config_date "Tue Jul  3 17:10:48 PDT 2012" 
#endif

/* uname -a */
#ifndef BZ__os_name 
#define BZ__os_name "Linux midgard.cacr 3.0.0-12-generic #20-Ubuntu SMP Fri Oct 7 14:56:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux" 
#endif

/* target */
#ifndef BZ__platform 
#define BZ__platform "x86_64-unknown-linux-gnu" 
#endif
 
/* once: _BLITZ_GNU_BZCONFIG_H */
#endif
