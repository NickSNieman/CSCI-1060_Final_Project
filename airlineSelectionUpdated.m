%% ======== Initializes Seat Chart ========
% Based on a Delta 737-800 seating chart

%% --- 1st Class ---
rows1st = [1 3 5 7];
columns1st = [1.8 3.3 6.1 7.6]; % A,B,C,D
color1st = [0.82 0.09 0.12];

numRows1st = length(rows1st);
numColumns1st = length(columns1st);

for i=1:numRows1st
    for j=1:numColumns1st
         seats1stClass(i,j)='*';
     end
 end

%% --- Comfort+ --
rowsComfort = [9 11 13 15 17 19];
columnsComfort = [1 2.2 3.4 6 7.2 8.4]; % A,B,C,D,E,F
colorComfort = [0.05 0.15 0.32];

numRowsComfort = length(rowsComfort);
numColumnsComfort = length(columnsComfort);

for i=1:numRowsComfort
    for j=1:numColumnsComfort
        seatsComfort(i,j)='*';
    end
end


%% --- Main Cabin ---
rowsMain = [21 23 25 27 29 31 33 35 37 39 41 43 45 47 49 51 53 55];
columnsMain = [1 2.2 3.4 6 7.2 8.4]; % A,B,C,D,E,F
colorMain = [0.00 0.56 0.86];

numRowsMain = length(rowsMain);
numColumnsMain = length(columnsMain);

for i=1:numRowsMain
        for j=1:numColumnsMain
            seatsMain(i,j)='*';
        end
end

%% Randomized Unavailable Seats
% Makes ~1/2 of seats in each section unavaiable
for k = 1:8
    seats1stClass(randi(numRows1st), randi(numColumns1st)) = 'x';
end
for k=1:18
    seatsComfort(randi(numRowsComfort), randi(numColumnsComfort)) = 'x';
end
for k = 1:54
    seatsMain(randi(numRowsMain), randi(numColumnsMain)) = 'x';
end


%% Display in Command Window Function

function showChart(name, numRows, numColumns, seatMatrix, letters, aisle,offset)
    fprintf("%s Seating\n", name)
    fprintf("%s\n",letters)

    for i=1:numRows
        fprintf("%d ", i+offset)
        if i+offset<10
            fprintf("   ")
        end
        for j=1:numColumns
            fprintf("%c ", seatMatrix(i,j))
            if j==aisle
                fprintf(" ")
            elseif j==numColumns
                fprintf("\n")
            end
        end
    end    
end

showChart(" 1st Class",numRows1st,numColumns1st,seats1stClass,"     A B  C D",2,0);

showChart(" Comfort+",numRowsComfort,numColumnsComfort,seatsComfort,"   A B C  D E F",3,9)

showChart("   Main",numRowsMain,numColumnsMain,seatsMain,"   A B C  D E F",3,15)


%% ======== Menu ========
choice = 0;

while choice ~= 3

    fprintf("\n--- MENU ---\n");
    fprintf("1. View Seating Chart\n");
    fprintf("2. Select Seats\n");
    fprintf("3. Exit\n");

    choice = input("Enter choice: ");

    if choice == 1
        showChart(" 1st Class",numRows1st,numColumns1st,seats1stClass,"     A B  C D",2,0);
        showChart(" Comfort+",numRowsComfort,numColumnsComfort,seatsComfort,"   A B C  D E F",3,9);
        showChart("   Main",numRowsMain,numColumnsMain,seatsMain,"   A B C  D E F",3,15);

    elseif choice == 2

        fprintf("\nSelect Section:\n");
        fprintf("1. First Class ($500)\n");
        fprintf("2. Comfort+ ($300)\n");
        fprintf("3. Main Cabin ($150)\n");

        section = input("Enter choice: ");

        if section == 1
            [seats1stClass, total] = seatSelection(seats1stClass, 500, 0);

        elseif section == 2
            [seatsComfort, total] = seatSelection(seatsComfort, 300, 9);

        elseif section == 3
            [seatsMain, total] = seatSelection(seatsMain, 150, 15);

        else
            fprintf("Invalid section\n");
            continue;
        end

        fprintf("Total cost: $%d\n", total);

        buy = input("Purchase seats? (1=yes, 0=no): ");

        if buy == 1
            reservation = randi([10000 99999]);
            fprintf("Purchase successful\n");
            fprintf("Reservation number: %d\n", reservation);
        else
            fprintf("Purchase canceled\n");
        end

    elseif choice == 3
        fprintf("Exiting program\n");
        
    else
        fprintf("Invalid option\n");
    end

end


%% Selection Function
function [seatMatrix, totalCost] = seatSelection(seatMatrix, price, offset)

    totalCost = 0;
    selecting = 1;

    while selecting == 1

        i = input("Select a row #: ");

        if i-offset < 1 || i-offset > size(seatMatrix,1)
            fprintf("Invalid row\n");
            continue;
        end

        jcase = input("Select a letter (A-D for First Class, A-F for rest of cabin): ", "s");

        switch upper(jcase)
            case 'A'
                j = 1;
            case 'B'
                j = 2;
            case 'C'
                j = 3;
            case 'D'
                j = 4;
            case 'E'
                if price==500
                    fprintf("Invalid letter\n");
                    continue
                else
                    j = 5;
                end
            case 'F'
                if price==500
                    fprintf("Invalid letter\n");
                    continue
                else
                    j = 6;
                end
            otherwise
                fprintf("Invalid letter\n");
                continue;
        end

        
        if seatMatrix(i-offset,j) == 'x' || seatMatrix(i-offset,j) == 'o'
            fprintf("Seat unavailable\n");
        else
            fprintf("Seat available! Price: $%d\n", price);

            confirm = input("Confirm seat? (1=yes, 0=no): ");

            if confirm == 1
                seatMatrix(i-offset,j) = 'o';
                totalCost = totalCost + price;
                fprintf("Seat added!\n");
            end
        end

        selecting = input("Select another seat? (1=yes, 0=no): ");
    end
end

%% Additional Functions


%% Optional, NEEDS WORK: Display in Plot
% ADD IN AFTER: "Display in Command Window"
%Needs some features added still such as: an unavailable indicator (like an x)
%{

hold on
for i = rows1st
    for j = columns1st
        plot(j, i, 'ws', MarkerFaceColor=color1st, MarkerSize=12, LineWidth=1);
    end
end

% Display in Plot
for i = rowsComfort
    for j = columnsComfort
        plot(j, i, 'ws', MarkerFaceColor=colorComfort, MarkerSize=10, LineWidth=1);
    end
end

% Display in Plot
for i = rowsMain
    for j = columnsMain
        plot(j, i, 'ws', MarkerFaceColor=colorMain, MarkerSize=10, LineWidth=1);
    end
end

set(gca, 'YDir', 'reverse')
axis equal
axis off
xlim([0 9])
ylim([0 55])

%}