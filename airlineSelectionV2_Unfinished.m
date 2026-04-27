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

function showChart(name,numRows,numColumns,seatMatrix,letters,aisle,offset)
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
function Menu()

end

[seats1stClass,seatsComfort,seatsMain]= seatSelection(seats1stClass,seatsComfort,seatsMain);

showChart(" 1st Class",numRows1st,numColumns1st,seats1stClass,"     A B  C D",2,0);

showChart(" Comfort+",numRowsComfort,numColumnsComfort,seatsComfort,"   A B C  D E F",3,9)

showChart("   Main",numRowsMain,numColumnsMain,seatsMain,"   A B C  D E F",3,15)


%% Selection Function
function [seats1stClass,seatsComfort,seatsMain] = seatSelection(seats1stClass,seatsComfort,seatsMain)
    while true
        while true
            in = input("Select a row #: ","s");
            i = str2double(in);
    
            if ~isnan(i) && isreal(i) && i==floor(i)
                break
            else
                fprintf("Invalid seat, please select a valid seat\n")
            end
        end
    
        if i>=1 && i<=4
            seatMatrix = seats1stClass;
        elseif i>=10 && i<=15
            seatMatrix = seatsComfort;
        elseif i>=16 && i<=33
            seatMatrix = seatsMain;
        else
            fprintf("Invalid seat, please select a valid seat\n")
            continue
        end
   
        jcase = input("Select a letter (A-D for First Class, A-F for rest of cabin): ", "s");


        switch jcase
            case 'A'
                j = 1;
            case 'B'
                j = 2;
            case 'C'
                j = 3;
            case 'D'
                j = 4;
            case 'E'
                if i>=10
                    j = 5;
                else
                    fprintf("Invalid seat, please select a valid seat\n")
                    seatSelection(seats1stClass,seatsComfort,seatsMain)
                end
            case 'F'
                if i>=10
                    j = 6;
                else
                    fprintf("Invalid seat, please select a valid seat\n")
                    seatSelection(seats1stClass,seatsComfort,seatsMain)
                end
            otherwise
                fprintf("Invalid seat, please select a valid seat\n")
                seatSelection(seats1stClass,seatsComfort,seatsMain)
        end
    
        if seatMatrix(i,j)=='x' || seatMatrix(i,j)=='o'
            fprintf("Seat unavailable, please select a different seat\n")
            continue

        end

        if seatMatrix(i,j)=='*'
            fprintf("Seat selected successfully!\n");  % DOESNT UPDATE
            if i>=1 && i<=4
                seats1stClass(i,j)='o';
            elseif i>=10 && i<=15
                seatsComfort(i,j)='o';
            elseif i>=16 && i<=33
                seatsMain(i,j)='o';
            end
        end
        break
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