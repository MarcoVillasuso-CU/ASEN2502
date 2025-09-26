%%ASEN 2502 Wind Tunnel Lab
% Author:
% Lab Description: Employ basic experimental wind tunnel testing procedures, 
% conduct flow measurements, and develop an awareness for sources of 
% error/error analysis as part of a team.  Validate the AES PILOT 
% Low-SpeedWind Tunnel through the evaluation of a Clark Y-14 airfoil 
% and comparingthe results to the published National Advisory Committee 
% for Aeronautics (NACA) results from 1938.
% 
% Inputs:
% - Raw Wind Tunnel CSV data files for tests
% - Airfoil Static Port Locations 
% - Comparison NACA Clark Y Data
% 
% Outputs:
% 
%

%% Intialize Workspace
clear; clc; close all; % Clear workspace, command window, and close all figures

addpath(genpath('15 mps Data Files')); %Adds 15 m/s test data files folder and subfolders
addpath(genpath('30 mps Data Files')); %Adds 30 m/s test data files folder and subfolders

%% Velocity Choice
Velocity_Choice = 15; %(15 or 30)

%% Import Airfoil Port Locations
Ports = readtable('Port_Locations.xlsx','Sheet','Port_Locations'); %Read in CSV file with port locations
Segments = readtable('Port_Locations.xlsx','Sheet','Segments'); %Read in segment information from CSV file

%% Search Data Folders, Pull File Names & Count Data Files
% Get filenames for test data files
fileLoc15 = '15 mps Data Files/';
list15 = dir([fileLoc15, '*AoA*']); % This lists all files in fileLoc with 'WTData' in the file name
numFiles = length(list15);

for i = 1:numFiles
    fileNames15{i} = [fileLoc15, list15(i).name]; % This makes a string of the complete file name with the path in front of it
    AoA15(i) = str2num(char(extractBetween(list15(i).name, 'AoA_', '.csv'))); % Finds the angle of attack value in the name and make it a usable number
end
fileNames15 = string(fileNames15); % Convert to char array from cell array
AoA_Count15 = length(AoA15); %Counts number of AoAs tested

%% Search Data Files 30
fileLoc30 = '30 mps Data Files/';
list30 = dir([fileLoc30, '*AoA*']); % This lists all files in fileLoc with 'WTData' in the file name
numFiles = length(list30);

for i = 1:numFiles
    fileNames30{i} = [fileLoc30, list30(i).name]; % This makes a string of the complete file name with the path in front of it
    AoA30(i) = str2double((extractBetween(list30(i).name, 'AoA_', '.csv'))); % Finds the angle of attack value in the name and make it a usable number
    
end
fileNames30 = string(fileNames30); % Convert to char array from cell array
AoA_Count30 = length(AoA30); %Counts number of AoAs tested


%% Ingest Data Files and Data Conditioning
% Averaging Raw Data Samples for each Velocity & AOA Tested
% Derived Values for each Velocity & AoA tested
    % Average Test Section Static Pressure (done by student code)
    % Average Airfoil Port Local Velocity (done by student code)
    % Average Airfoil Port Local Static Pressure (done by student code)

% Initialize Storage Arrays
Data15 = zeros(numFiles,25); %Conditioned wind tunnel data file 15 m/s
Data30 = zeros(numFiles,25); %Conditioned wind tunnel data file 30 m/s

%% Ingest and Condition Data 15
% Averaging Raw Data Samples for each Velocity & AOA Tested
% Derived Values for each Velocity & AoA tested
    % Average Test Section Static Pressure (done by student code)
    % Average Airfoil Port Local Velocity (done by student code)
    % Average Airfoil Port Local Static Pressure (done by student code)

for j = 1:numFiles
    RawData15 = readmatrix(fileNames15(j),'NumHeaderLines',1); % load the data
    %Condition data
    Data15(j,1) = AoA15(j); %Sets AoA (deg) as 1st column
    Data15(j,2) = mean(RawData15(:,4)); %Sets mean of velocity measurements as 2nd column
    Data15(j,3) = mean(RawData15(:,2)); %Sets mean of total pressure (atmosphere) as 3rd column
    Data15(j,4) = mean(RawData15(:,1)); %Sets mean of temperature (atmosphere) as 4th column
    Data15(j,5) = mean(RawData15(:,3)); %Sets mean of calculaed density (atmosphere) as 5th column
    Data15(j,6) = mean(RawData15(:,5)); %Sets mean of test section dynamic pressure as 6th column
    Data15(j,7) = Data15(j,3)-Data15(j,6); %Calculates test section static pressure by calculating Po - q
    %Calculate airfoil port static pressures from measured differential
    %pressues (P_port - P_static_test) & sets columns 8 - 24 as airfoil static port pressure values (calculated) 
    Data15(j,8) = mean(RawData15(:,15))+Data15(j,7); %Airfoil scanivalve port 1
    Data15(j,9) = mean(RawData15(:,16))+Data15(j,7); %Airfoil scanivalve port 2
    Data15(j,10) = mean(RawData15(:,17))+Data15(j,7); %Airfoil scanivalve port 3
    Data15(j,11) = mean(RawData15(:,18))+Data15(j,7); %Airfoil scanivalve port 4
    Data15(j,12) = mean(RawData15(:,19))+Data15(j,7); %Airfoil scanivalve port 5
    Data15(j,13) = mean(RawData15(:,20))+Data15(j,7); %Airfoil scanivalve port 6
    Data15(j,14) = mean(RawData15(:,21))+Data15(j,7); %Airfoil scanivalve port 7
    Data15(j,15) = mean(RawData15(:,22))+Data15(j,7); %Airfoil scanivalve port 8
    Data15(j,16) = mean(RawData15(:,23))+Data15(j,7); %Airfoil scanivalve port 9
    Data15(j,17) = Data15(j,7); %TE - Assume Airfoil trailing edge pressure = test section static pressure
    Data15(j,18) = mean(RawData15(:,24))+Data15(j,7); %Airfoil scanivalve port 10
    Data15(j,19) = mean(RawData15(:,25))+Data15(j,7); %Airfoil scanivalve port 11
    Data15(j,20) = mean(RawData15(:,26))+Data15(j,7); %Airfoil scanivalve port 12
    Data15(j,21) = mean(RawData15(:,27))+Data15(j,7); %Airfoil scanivalve port 13
    Data15(j,22) = mean(RawData15(:,28))+Data15(j,7); %Airfoil scanivalve port 14
    Data15(j,23) = mean(RawData15(:,29))+Data15(j,7); %Airfoil scanivalve port 15
    Data15(j,24) = mean(RawData15(:,30))+Data15(j,7); %Airfoil scanivalve port 16
    Data15(j,25) = Data15(j,8); %Repeats port 1 (leading edge)

end
Data15 = sortrows(Data15,1); %Sorts data by increasing AoA

%% Raw Data Collection(30) Implement Later

for j = 1:numFiles
    RawData30 = readmatrix(fileNames30(j),'NumHeaderLines',1); % load the data
    %Condition data
    Data30(j,1) = AoA30(j); %Sets AoA (deg) as 1st column
    Data30(j,2) = mean(RawData30(:,4)); %Sets mean of velocity measurements as 2nd column
    Data30(j,3) = mean(RawData30(:,2)); %Sets mean of total pressure (atmosphere) as 3rd column
    Data30(j,4) = mean(RawData30(:,1)); %Sets mean of temperature (atmosphere) as 4th column
    Data30(j,5) = mean(RawData30(:,3)); %Sets mean of calculaed density (atmosphere) as 5th column
    Data30(j,6) = mean(RawData30(:,5)); %Sets mean of test section dynamic pressure as 6th column
    Data30(j,7) = Data30(j,3)-Data30(j,6); %Calculates test section static pressure by calculating Po - q
    %Calculate airfoil port static pressures from measured differential
    %pressues (P_port - P_static_test) & sets columns 8 - 24 as airfoil static port pressure values calculated 
    Data30(j,8) = mean(RawData30(:,15))+Data30(j,7); %Airfoil scanivalve port 1
    Data30(j,9) = mean(RawData30(:,16))+Data30(j,7); %Airfoil scanivalve port 2
    Data30(j,10) = mean(RawData30(:,17))+Data30(j,7); %Airfoil scanivalve port 3
    Data30(j,11) = mean(RawData30(:,18))+Data30(j,7); %Airfoil scanivalve port 4
    Data30(j,12) = mean(RawData30(:,19))+Data30(j,7); %Airfoil scanivalve port 5
    Data30(j,13) = mean(RawData30(:,20))+Data30(j,7); %Airfoil scanivalve port 6
    Data30(j,14) = mean(RawData30(:,21))+Data30(j,7); %Airfoil scanivalve port 7
    Data30(j,15) = mean(RawData30(:,22))+Data30(j,7); %Airfoil scanivalve port 8
    Data30(j,16) = mean(RawData30(:,23))+Data30(j,7); %Airfoil scanivalve port 9
    Data30(j,17) = Data30(j,7); %TE  - Assume Airfoil trailing edge pressure = test section static pressure
    Data30(j,18) = mean(RawData30(:,24))+Data30(j,7); %Airfoil scanivalve port 10
    Data30(j,19) = mean(RawData30(:,25))+Data30(j,7); %Airfoil scanivalve port 11
    Data30(j,20) = mean(RawData30(:,26))+Data30(j,7); %Airfoil scanivalve port 12
    Data30(j,21) = mean(RawData30(:,27))+Data30(j,7); %Airfoil scanivalve port 13
    Data30(j,22) = mean(RawData30(:,28))+Data30(j,7); %Airfoil scanivalve port 14
    Data30(j,23) = mean(RawData30(:,29))+Data30(j,7); %Airfoil scanivalve port 15
    Data30(j,24) = mean(RawData30(:,30))+Data30(j,7); %Airfoil scanivalve port 16
    Data30(j,25) = Data30(j,8); %Repeats port 1 (leading edge)

end
Data30 = sortrows(Data30,1); %Sorts data by increasing AoA

%% DATA Selected
Speed_String = "";
if Velocity_Choice == 15 %Sets Index Values for Required AoA for 15 mps
    Data = Data15;
    FullStall_AoA = 25;
    MaxLift_AoA = 24;
    NLift_AoA = 12;
    Speed_String = "15 m/s";
else %Sets Index Values for Required AoA for 30 mps
    Data = Data30;
    FullStall_AoA = 29;
    MaxLift_AoA = 28;
    NLift_AoA = 11;
    Speed_String = "30 m/s";
end
%% Determine Forces & Analyze Results
% Pressure Distribution for each Velocity & AoA tested (done by student code)
PdisU = zeros(numFiles,9); %Creates Empty Array for Upper Pressure Distribution Values, Rows = AOA, Columns = Port Splits (N/m)
PdisL = zeros(numFiles,8); %Creates Empty Array for Lower Pressure Distribution Values, Rows = AOA, Columns = Port Splits (N/m)
for j = 1:numFiles %Iterates Through Each Angle of Attack
    for i = 1:17 %Iterates Through Each Port
        if i < 10 %Determines Upper or Lower
            PdisU(j,i) = (Data(j,i+7)+Data(j,i+8))/2 * Segments{i,2}; %Calculates Upper Pressure Distribution Per Port
        else
            PdisL(j,-i+18) = (Data(j,i+7)+Data(j,i+8))/2 * Segments{i,2}; %Calculates Lower Pressure Distribtuion Per Port
        end
    end
end
%Coefficient of Pressure
C_pressureU = zeros(numFiles,10); %Creates Empty Array for Coefficient of Upper Pressures
C_pressureL = zeros(numFiles,9); %Creates Empty Array for Coefficient of Lower Pressures
for j = 1:numFiles %Iterates Through AoAs
    for i = 1:18
        if i < 10
            C_pressureU(j,i) = (Data(j,i+7)-Data(j,7))/Data(j,6); %Calculates Upper CoP
        elseif i == 10
            C_pressureU(j,i) = (Data(j,i+7)-Data(j,7))/Data(j,6); %Calculates TE CoP
            C_pressureL(j,-i+19) = (Data(j,i+7)-Data(j,7))/Data(j,6); %Calculates TE CoP
        else
            C_pressureL(j,-i+19) = (Data(j,i+7)-Data(j,7))/Data(j,6); %Calculates Lower CoP
        end
    end
end

% Normal and Axial Force components for each Velocity & AoA tested (done by student code)
N_upper = zeros(numFiles,1); %Creates Empty Array for Upper Normal Force
N_lower = zeros(numFiles,1); %Creates Empty Array for Lower Normal Force
A_upper = zeros(numFiles,1); %Creates Empty Array for Upper Axial Force
A_lower = zeros(numFiles,1); %Creates Empty Array for Lower Axial Force
for j = 1:numFiles %Iterates Through Each Angle of Attack
    for i = 1:17 %Iterates Through Each Port Section
        if i<10 %Determines Upper or Lower
            N_upper(j) = N_upper(j) - PdisU(j,i); %Subtracts Segmented Normal Upper Force From Total
            A_upper(j) = A_upper(j) + (Data(j,i+7)+Data(j,i+8))/2 * Segments {i,3}; %Calculates and Adds Segmented Axial Upper Force to Total
        else
            N_lower(j) = N_lower(j) + PdisL(j,i-9); %Adds Segmented Normal Lower Force to Total
            A_lower(j) = A_lower(j) - (Data(j,i+7)+Data(j,i+8))/2 * Segments {i,3}; %Calculates and Subtractes Segmented Axial Lower Force From Total
        end
    end
end
N_total = N_upper + N_lower; %Calculates Total Normal Force
A_total = A_upper + A_lower; %Calculates Total Axial Force

% Lift & Coefficient of Lift for each Velocity & AoA tested (done by student code)
Chord_length = Ports{10,2}; %Sets Chord Length Equal to X Value of Trailing Edge Port
for j = 1:numFiles %Iterates Through Each AoA
    Lift = N_total * cosd(Data(j,1)) - A_total * sind(Data(j,2)); %Calculates Lift and Puts into new Array
    C_lift = Lift/(Data(j,6) * Chord_length); %Calculates Coeficient of Lift
end

%Normalized Chord
Chord_NormalU = zeros(1,9); %Creates Empty Array for Upper Normalized Chord Lengths (% of Chord)
Chord_NormalL = zeros(1,8); %Creates Empty Array for Lower Normalized Chord Lengths (% of Chord)
for i = 1:18 %Iterates Through Each Port
    if i < 10 %Determines Upper or Lower
        Chord_NormalU(i) = Ports{i,2}/Ports{10,2}; %Calculates Upper Normalized Chord Lengths
    elseif i == 10
        Chord_NormalU(i) = Ports{i,2}/Ports{10,2}; %Calculates TE Normalized Chord Lengths
        Chord_NormalL(i-9) = Ports{i,2}/Ports{10,2}; %Claculates TE Normalized Chord Lengths
    else
        Chord_NormalL(i-9) = Ports{i,2}/Ports{10,2}; %Claculates Lower Normalized Chord Lengths
    end
end

%Velocity Calculations
VelocityU = zeros(numFiles,9); %Creates Empty Array for Velocities of Upper Ports
VelocityL = zeros(numFiles,8); %Creates Empty Array for Velocities of Lower Ports
for j = 1:numFiles %Iterates Through AoAs
    for i = 1:18 %Iterates Through Ports
        if i < 10
            VelocityU(j,i) = sqrt(2*(Data(j,3)-Data(j,i+7))/Data(j,5)); %Calculates Upper Velocities
        elseif i == 10
            VelocityU(j,i) = sqrt(2*(Data(j,3)-Data(j,i+7))/Data(j,5)); %Calculates TE Velocity
            VelocityL(j,-i+19) = sqrt(2*(Data(j,3)-Data(j,i+7))/Data(j,5)); %Calculates TE Velocity
        else
            VelocityL(j,-i+19) = sqrt(2*(Data(j,3)-Data(j,i+7))/Data(j,5)); %Calculates Lower Velocites
        end
    end
end



%% Plots
% Velocity vs normalized chord (x/c)
figure1 = figure("Name","Velocity");
subplot(2,2,1) %First Velocity Plot for 0 Lift AoA
    VU = plot(Chord_NormalU(:),VelocityU(NLift_AoA,1:10));
    hold on;
    grid on;
    VL = plot(Chord_NormalL(:),VelocityL(NLift_AoA,1:9));
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Local Velocity (m/s)");
    title("0 Lift");
    legend([VU,VL], {"Upper Surface","Lower Surface"});

subplot(2,2,2) %Second Velocity Plot for 6 AoA
    VU = plot(Chord_NormalU(:),VelocityU(21,1:10));
    hold on;
    grid on;
    VL = plot(Chord_NormalL(:),VelocityL(21,1:9));
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Local Velocity (m/s)");
    title("AoA 6");

subplot(2,2,3) %Third Velocity Plot for Fully Stall AoA
    VU = plot(Chord_NormalU(:),VelocityU(FullStall_AoA,1:10));
    hold on;
    grid on;
    VL = plot(Chord_NormalL(:),VelocityL(FullStall_AoA,1:9));
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Local Velocity (m/s)");
    title("Fully Stall");

subplot(2,2,4) %Fourth Velocity Plot for Max Lift AoA
    VU = plot(Chord_NormalU(:),VelocityU(MaxLift_AoA,1:10));
    hold on;
    grid on;
    VL = plot(Chord_NormalL(:),VelocityL(MaxLift_AoA,1:9));
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Local Velocity (m/s)");
    title("Stall AoA");

sgtitle("Local Velocity of " + Speed_String + " Airfoil at Varying Angle of Attacks "); %Overall Velocity Subplot Title

% Coefficient of Pressure vs normalized chord (x/c)
figure2 = figure("Name","C Pressure");
subplot(2,2,1) %First Pressure Plot for 0 Lift AoA
    PU = plot(Chord_NormalU(:),C_pressureU(NLift_AoA,1:10),'-');
    hold on;
    grid on;
    PL = plot(Chord_NormalL(:),C_pressureL(NLift_AoA,1:9),'-');
    set(gca, 'YDir', 'reverse')
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Coefficient of Pressure");
    title("0 Lift");
    legend([PU,PL], {"Upper Surface","Lower Surface"});

subplot(2,2,2) %Second Pressure Plot for 6 AoA
    PU = plot(Chord_NormalU(:),C_pressureU(21,1:10),'-');
    hold on;
    grid on;
    PL = plot(Chord_NormalL(:),C_pressureL(21,1:9),'-');
    set(gca, 'YDir', 'reverse')
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Coefficient of Pressure");
    title("AoA 6");

subplot(2,2,3) %Third Pressure Plot for Fully Stall AoA
    PU = plot(Chord_NormalU(:),C_pressureU(FullStall_AoA,1:10),'-');
    hold on;
    grid on;
    PL = plot(Chord_NormalL(:),C_pressureL(FullStall_AoA,1:9),'-');
    set(gca, 'YDir', 'reverse')
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Coefficient of Pressure");
    title("Fully Stall");

subplot(2,2,4) %Fourth Pressure Plot for Max Lift AoA
    PU = plot(Chord_NormalU(:),C_pressureU(MaxLift_AoA,1:10),'-');
    hold on;
    grid on;
    PL = plot(Chord_NormalL(:),C_pressureL(MaxLift_AoA,1:9),'-');
    set(gca, 'YDir', 'reverse')
    hold off;
    xlabel("Normalized Chord Length");
    ylabel("Coefficient of Pressure");
    title("Stall AoA");

sgtitle("Local Coefficient of Pressure of " + Speed_String + " Airfoil at Varying Angle of Attacks"); %Overall Subplot Title

% Coefficient of Lift vs Angle of Attack
figure3 = figure("name","C Lift");
plot(Data(:,1),C_lift); %Plots CoL against AoA
    grid on;
    xlabel("Angle of Attack"); %Set Labels for Graph
    ylabel("Coefficient of Lift");
    title("Coefficient of Lift of " + Speed_String + " Airfoil Relative to Angle of Attack");








