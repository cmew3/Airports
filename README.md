Airports
========

Ruby program to control the flow of planes at airports. Planes can either be flying or grounded at siports. A plane can land at an airport provided there is space at the airport. The weather at the airport is randomly generated as stormy or not. If it is stormy at an airport, planes cannot take-off or land.  

CRCs
____

Plane
| Responsibility | Collaborator |
|----------------|--------------|
| is flying/not flying |  |
| takes off |  |
| lands |   |

Airport
| Responsibility | Collaborator |
|----------------|--------------|
| knows what | Planes it has|
| has a capacity |  |
| can dock a  | Plane  |
| can release a | Plane   |
| checks whether  | a Plane can land  |
| checks whether | a Plane can take off  |
| knows what the weather is | |
| knows when it is full | |

