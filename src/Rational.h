#ifndef RAITIONAL_H
#define RAITIONAL_H

#include <iostream>

class Rational
{
public:
    Rational(int numerator = 0, int denominator = 1)
        : num(numerator), den(denominator)
    {
        if (den == 0)
        {
            throw std::invalid_argument("Denominator cannot be zero.");
        }
    }

    int numerator() const
    {
        return num;
    }
    int denominator() const
    {
        return den;
    }

private:
    int num;
    int den;
};

Rational operator*(const Rational &lhs, const Rational &rhs)
{
    return Rational(lhs.numerator() * rhs.numerator(),
                    lhs.denominator() * rhs.denominator());
}

std::ostream &operator<<(std::ostream &os, const Rational &r)
{
    return os << r.numerator() << "/" << r.denominator();
}

#endif // RAITIONAL_H
