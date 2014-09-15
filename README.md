Airports
========

Ruby program to control the flow of planes at airports. Planes can either be flying or grounded at siports. A plane can land at an airport provided there is space at the airport. The weather at the airport is randomly generated as stormy or not. If it is stormy at an airport, planes cannot take-off or land.  

This was a solo challenge for week three of Makers Academy (intoduction to OOP)

CRCs
--------

###Plane

| Responsibility        | Collaborator |
| --------------------- | ------------ |
| Knows whether it is flying |              |
| Takes off 			|  			   |
| Lands				    |  			   |

###Airport

| Responsibility | Collaborator |
|----------------|--------------|
| Knows what | Planes it has|
| Has a capacity |  |
| Knows when it is full | |
| Can dock | a Plane  |
| Can release | a Plane   |
| Checks whether  | a Plane can land  |
| Checks whether | a Plane can take off  |
| Randomly generates storms | |
| Knows whether it is stormy | |

How to run tests
----------
Tested using [rspec](https://github.com/rspec/rspec)

```shell
git clone https://github.com/cmew3/Airports.git
cd Airports
rspec
```

