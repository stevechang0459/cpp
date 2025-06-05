#include "Rational.h"

void rational_test()
{
    Rational r1(3, 4);                                      // 3/4
    Rational r2(2, 5);                                      // 2/5
    Rational result = r1 * r2;                              // 3/4 * 2/5 = 6/20
    std::cout << "r1 = " << r1 << std::endl;                // Should print 3/4
    std::cout << "r2 = " << r2 << std::endl;                // Should print 2/5
    std::cout << "r1 * r2 = " << result << std::endl;       // Should print 6/20
    std::cout << std::endl;

    Rational r3(3, 8);                                      // 3/8
    result = r3 * 2;                                        // 3/8 * 2 = 6/8
    std::cout << "r3 = " << r3 << std::endl;                // Should print 3/8
    std::cout << "r3 * 2 = " << result << std::endl;        // Should print 6/8
    result = 2 * r3;
    std::cout << "2 * r3 = " << result << std::endl;        // Should also print 6/8
    std::cout << std::endl;

    Rational r4(1, 11);                                     // 1/11
    Rational r5(1, 2);                                      // 1/2
    Rational r6(1, 3);                                      // 1/3
    result = r4 * r5 * r6;                                  // 1/11 * 1/2 * 1/3 = 1/66
    std::cout << "r4 = " << r4 << std::endl;                // Should print 1/11
    std::cout << "r5 = " << r5 << std::endl;                // Should print 1/2
    std::cout << "r6 = " << r6 << std::endl;                // Should print 1/3
    std::cout << "r4 * r5 * r6 = " << result << std::endl;  // Should print 1/66
}
