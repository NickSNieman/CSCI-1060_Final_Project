# CSCI-1060_Final_Project
Made by Nick Nieman and Slater Evert

We coded a model of a Delta 737-800 airplane seating chart in MATLAB. The goal of this is to give people 
an example of how to select seating on an airplane.

Generation of Model: It first generates a seating chart by randomly selecting seats and
blocking them off as already purchased. This limits the number of seats available for
selection; this is to be realistic, as unavailable seats would be what would be encountered during
seat selection for a real flight. Then it displays a visual model of the airplane seating chart to
make it easier to see the seats. This model is labeled with * or x for unoccupied or occupied
seats; rows are labeled with numbers, and columns are labeled with letters.

Seating Selection Program: Using this generated model, the program will allow you to select
multiple seats and give you pricing. You can select seats by inputting row numbers
and letters for each seat. Pricing is shown per seat before confirmation, and a total is calculated
after each seat is confirmed. Once you confirm a seat, you are given the options to choose
another seat or finish the selection of seat(s). Once you finish the selection of the seat(s), you are
then asked to purchase the seats. Once you buy those seats, it will log those seats as taken in the
seating chart. It will also give you a randomly generated and not already taken reservation
number.

Ending of Program: After buying seats, you can buy more seats, cancel a reservation,
or end the program and reset the seating chart.


V2 is unfinished (no complete menu function or pricing), but it allows for the selection of multiple
seats regardless of section. This means that you do not have to select the section first; you only have to select the row and column.
