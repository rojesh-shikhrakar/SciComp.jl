# Interpolation
Interpolation is the method of estimating value of a function based on range of discrete set of known values or data points. Hence, approximating the behavior of a true underlying function using function values at a limited number of points. The Interpolation function pass exactly through the limited number of points hence are different from regression which allows for error to find a line of "best fit". 

Interpolation serves three important distinct purposes
- Enable table looks ups i.e find value between different stored experimental values
- Facilitate developemnt and analysis of other numerical techniques such as integration
- Ability to represent geometry which allows engineers to work with physical items

There are many methods for interpolations depending on the accuracy, cost, number of data points required and smoothenes of the resulting interpolant functions:
- Piecewise interpolation: simplest method locates the nearest data value and assign the same value. This is extented to piecewise functions where the parameters of interpolating function are different in different part of the domain. 
- Linear Interpolation (lerp): quick and easy but imprecise method to estimate data point assuming a straight line relationship
- Polynomial Interpolation: generalisation of linear interpolation where the interpolant is polynomial of higher degree
- Spline Interpolation: uses low-degree polynomials in each intervals and chooses the polynomial pieces such that they fit smoothly together.
