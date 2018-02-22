% Quasi-Static Crush Testing Data Analysiser and Plotter


% Import and sort experimental data

% Load raw data from csv file
load A1data.csv
load A2data.csv
load B1data.csv
load C1data.csv
load C2data.csv
load D1data.csv
load D2data.csv
load DD1data.csv
load DD2data.csv

% Save each dataset to a matrix
A1 = A1data;
A2 = A2data;
B1 = B1data;
C1 = C1data;
C2 = C2data;
D1 = D1data;
D2 = D2data;
DD1 = DD1data;
DD2 = DD2data;

% Sample code to determine number of rows and columns
[row_A1, col_A1] = size(A1);
[row_A2, col_A2] = size(A2);
[row_B1, col_B1] = size(B1);
[row_C1, col_C1] = size(C1);
[row_C2, col_C2] = size(C2);
[row_D1, col_D1] = size(D1);
[row_D2, col_D2] = size(D2);
[row_DD1, col_DD1] = size(DD1);
[row_DD2, col_DD2] = size(DD2);

% Group data sets by specimen
A = {A1, A2};
B = {B1};
C = {C1, C2};
D = {D1, D2};
DD = {DD1, DD2};
All_data = {A, B, C, D, DD};


% Create cell arrays for each data type

% Raw data rows (sample number, displacement(mm), load(kN))

% Sample number is not  desired, create time data cell array from sample
% number data
% Convert sample number to time (sample number * sampling frequency)
freq = 10; %sampling frequency = 10Hz
Time_data = {{[] []} [] {[] []} {[] []} {[] []}};
for ii=1:5
    if ii == 2
        Time_data{ii} = All_data{ii}{1}(1:size(B1,1));
        Time_data{ii} = Time_data{ii} ./ 10;
    else
        for jj=1:2
            Time_data{ii}{jj} = All_data{ii}{jj}(1:size(All_data{ii}{jj},1));
            Time_data{ii}{jj} = Time_data{ii}{jj} ./ 10;
        end
    end
end

% Create displacement data cell array
Disp_data = {{[] []} [] {[] []} {[] []} {[] []}};
for ii=1:5
    if ii == 2
        Disp_data{ii} = All_data{ii}{1}(1:size(B1,1),2);
    else
        for jj=1:2
            Disp_data{ii}{jj} = All_data{ii}{jj}(1:size(All_data{ii}{jj},1),2);
        end
    end
end

% Create load data cell array
Load_data = {{[] []} [] {[] []} {[] []} {[] []}};
for ii=1:5
    if ii == 2
        Load_data{ii} = All_data{ii}{1}(1:size(B1,1),3);
    else
        for jj=1:2
            Load_data{ii}{jj} = All_data{ii}{jj}(1:size(All_data{ii}{jj},1),3);
        end
    end
end



% Data Plotting

% Plot loading history

% Separate plots for each specimen type
for ii=1:5
    if ii == 2
        figure(ii)
        clf
        plot(Time_data{ii}, Load_data{ii}, 'b');
        grid on
        xlabel('Time (s)');
        ylabel('Load (kN)');
        title('Quasi-Static Crush Testing - Loading history - Specimen B')
        legend('Experiment 1', 'Location', 'SouthEast')
        hgexport(gcf, ['loadinghistory' num2str(ii) '.jpg'], hgexport('factorystyle'), 'Format', 'jpeg');
    else
        figure(ii)
        clf
        plot(Time_data{ii}{1}, Load_data{ii}{1}, 'b', Time_data{ii}{2}, Load_data{ii}{2}, 'g');
        grid on
        xlabel('Time (s)');
        ylabel('Load(kN)');
        if ii == 1
            title('Quasi-Static Crush Testing - Loading history - Specimen A')
        elseif ii == 3
            title('Quasi-Static Crush Testing - Loading history - Specimen C')
        elseif ii == 4
            title('Quasi-Static Crush Testing - Loading history - Specimen D')
        elseif ii == 5
            title('Quasi-Static Crush Testing - Loading history - 2 * Specimen D Stacked')
        end
        legend('Experiment 1' , 'Experiment 2', 'Location', 'SouthEast')
        hgexport(gcf, ['loadinghistory' num2str(ii) '.jpg'], hgexport('factorystyle'), 'Format', 'jpeg');
        
    end
end

% Combined plot
figure(6)
clf
hold on
grid on
xlabel('Time (s)');
ylabel('Load (kN)');
title('Quasi-Static Crush Testing - Loading history - All experiments')
plot(Time_data{1}{1}, Load_data{1}{1}, 'b', Time_data{1}{2}, Load_data{1}{2}, 'g');
plot(Time_data{2}, Load_data{2}, 'r');
plot(Time_data{3}{1}, Load_data{3}{1}, 'c--', Time_data{3}{2}, Load_data{3}{2}, 'm--');
plot(Time_data{4}{1}, Load_data{4}{1}, 'b:', Time_data{4}{2}, Load_data{4}{2}, 'g:');
plot(Time_data{5}{1}, Load_data{5}{1}, 'c-.', Time_data{5}{2}, Load_data{5}{2}, 'm-.');
legend('Specimen A - Experiment 1' , 'Specimen A - Experiment 2', 'Specimen B - Experiment 1', 'Specimen C - Experiment 1' , 'Specimen C - Experiment 2','Specimen D - Experiment 1' , 'Specimen D - Experiment 2','Specimen 2*D - Experiment 1' , 'Specimen 2*D - Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'loadinghistoryplotalldata.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot load vs displacement

% Separate plots for each specimen type
for ii=1:5
    if ii == 2
        figure(6+ii)
        clf
        plot(Disp_data{ii}, Load_data{ii}, 'b');
        grid on
        xlabel('Displacement (mm)');
        ylabel('Load (kN)');
        title('Quasi-Static Crush Testing - Load vs Displacement - Specimen B')
        legend('Experiment 1', 'Location', 'SouthEast')
        hgexport(gcf, ['loaddispplot' num2str(ii) '.jpg'], hgexport('factorystyle'), 'Format', 'jpeg');
    else
        figure(6+ii)
        clf
        plot(Disp_data{ii}{1}, Load_data{ii}{1}, 'b', Disp_data{ii}{2}, Load_data{ii}{2}, 'g');
        grid on
        xlabel('Displacement (mm)');
        ylabel('Load(kN)');
        if ii == 1
            title('Quasi-Static Crush Testing - Load vs Displacement - Specimen A')
        elseif ii == 3
            title('Quasi-Static Crush Testing - Load vs Displacement - Specimen C')
        elseif ii == 4
            title('Quasi-Static Crush Testing - Load vs Displacement - Specimen D')
        elseif ii == 5
            title('Quasi-Static Crush Testing - Load vs Displacement - 2 * Specimen D Stacked')
        end
        legend('Experiment 1' , 'Experiment 2', 'Location', 'SouthEast')
        hgexport(gcf, ['loaddispplot' num2str(ii) '.jpg'], hgexport('factorystyle'), 'Format', 'jpeg');
        
    end
end

% Combined plot
figure(12)
clf
hold on
grid on
xlabel('Displacement (mm)');
ylabel('Load (kN)');
title('Quasi-Static Crush Testing - Load vs Displacement - All experiments')
plot(Disp_data{1}{1}, Load_data{1}{1}, 'b', Disp_data{1}{2}, Load_data{1}{2}, 'g');
plot(Disp_data{2}, Load_data{2}, 'r');
plot(Disp_data{3}{1}, Load_data{3}{1}, 'c--', Disp_data{3}{2}, Load_data{3}{2}, 'm--');
plot(Disp_data{4}{1}, Load_data{4}{1}, 'b:', Disp_data{4}{2}, Load_data{4}{2}, 'g:');
plot(Disp_data{5}{1}, Load_data{5}{1}, 'c-.', Disp_data{5}{2}, Load_data{5}{2}, 'm-.');
legend('Specimen A - Experiment 1' , 'Specimen A - Experiment 2', 'Specimen B - Experiment 1', 'Specimen C - Experiment 1' , 'Specimen C - Experiment 2','Specimen D - Experiment 1' , 'Specimen D - Experiment 2','Specimen 2*D - Experiment 1' , 'Specimen 2*D - Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'loaddispplotalldata.jpg', hgexport('factorystyle'), 'Format', 'jpeg');



% Data Analysis


% Calculate Total Energy Absorbed for each experiment
% Use trapezoid rule to find the area under the load vs displacement curve
% as curve is plotted from discrete data. Trapezoid rule rather than 
% Simpson's rule because displacement values are not evenly distributed.
% Define Total Energy Absorbed cell array
Total_energy_absorbed = {{[] []} [] {[] []} {[] []} {[] []}};
% Calculate for each specimen type
for ii=1:5
    if ii == 2
        % Specimen B only has data from one experiment 
        x = Disp_data{ii};
        y = Load_data{ii};
        Total_energy_absorbed{ii} = trapz(x,y);
    else
        % Calculate for each experiment of a specimen type
        for jj=1:2
            x = Disp_data{ii}{jj};
            y = Load_data{ii}{jj};
            Total_energy_absorbed{ii}{jj} = trapz(x,y);
        end
    end
end


% Average Energy Absorption of Each Specimen
Average_energy_absorbed = {[] [] [] [] []};
for ii=1:5
    if ii==2
        Average_energy_absorbed{ii} = Total_energy_absorbed{ii};
    else
        Average_energy_absorbed{ii} = (Total_energy_absorbed{ii}{1} + Total_energy_absorbed{ii}{2})/2;
    end
end


% Maximum and mean load per experiment (excluding loading once specimen has been
% fully crushed)
Max_load = {{[] []} [] {[] []} {[] []} {[] []}};
Mean_load = {{[] []} [] {[] []} {[] []} {[] []}};
% Experiment 1 - Max load in first 40s
Max_load{1}{1} = max(Load_data{1}{1}(1:400));
% Experiment 2 - Max load in first 40s
Max_load{1}{2} = max(Load_data{1}{2}(1:400));
% Experiment 3 - Max load in first 40s
Max_load{2} = max(Load_data{2}(1:400));
% Experiment 4 - Max load in first 44s
Max_load{3}{1} = max(Load_data{3}{1}(1:440));
% Experiment 5 - Max load in first 44s
Max_load{3}{2} = max(Load_data{3}{2}(1:440));
% Experiment 6 - Max load in first 17s
Max_load{4}{1} = max(Load_data{4}{1}(1:170));
% Experiment 7 - Max load in first 17s
Max_load{4}{2} = max(Load_data{4}{2}(1:170));
% Experiment 8 - Max load in first 25s
Max_load{5}{1} = max(Load_data{5}{1}(1:250));
% Experiment 9 - Max load in first 18s
Max_load{5}{2} = max(Load_data{5}{2}(1:180));
% Experiment 1 - Mean load in first 40s
Mean_load{1}{1} = mean(Load_data{1}{1}(1:400));
% Experiment 2 - Mean load in first 40s
Mean_load{1}{2} = mean(Load_data{1}{2}(1:400));
% Experiment 3 - Mean load in first 40s
Mean_load{2} = mean(Load_data{2}(1:400));
% Experiment 4 - Mean load in first 44s
Mean_load{3}{1} = mean(Load_data{3}{1}(1:440));
% Experiment 5 - Mean load in first 44s
Mean_load{3}{2} = mean(Load_data{3}{2}(1:440));
% Experiment 6 - Mean load in first 17s
Mean_load{4}{1} = mean(Load_data{4}{1}(1:170));
% Experiment 7 - Mean load in first 17s
Mean_load{4}{2} = mean(Load_data{4}{2}(1:170));
% Experiment 8 - Mean load in first 25s
Mean_load{5}{1} = mean(Load_data{5}{1}(1:250));
% Experiment 9 - Mean load in first 18s
Mean_load{5}{2} = mean(Load_data{5}{2}(1:180));


% Calculate Energy Efficiency
% Energy efficiency is ratio of energy absorbed to theoretical max energy
% absorption, i.e. max force (kN) * specimen stroke (mm) = energy(J)
Energy_efficiency = {{[] []} [] {[] []} {[] []} {[] []}};
% Calculate for each specimen type
for ii=1:3
    % All tube specimens have same length (100mm)
    if ii == 2
        % Specimen B only has data from one experiment 
        Energy_efficiency{ii} = Total_energy_absorbed{ii} / (Max_load{ii} * 100);
    else
        % Calculate for each experiment of a tube specimen type
        for jj=1:2
            Energy_efficiency{ii}{jj} = Total_energy_absorbed{ii}{jj} / (Max_load{ii}{jj} * 100);
        end
    end
end
% Single honeycomb specimens have a thickness of 0.020m
for jj=1:2
	Energy_efficiency{4}{jj} = Total_energy_absorbed{4}{jj} / (Max_load{4}{jj} * 20);
end
% Double honeycomb specimens have a thickness of 0.040m
for jj=1:2
	Energy_efficiency{5}{jj} = Total_energy_absorbed{5}{jj} / (Max_load{5}{jj} * 20);
end


% Calculate stroke efficiency for each experiment
% Stroke efficiency is ratio of crushed length to original length
Stroke_efficiency = {{[] []} [] {[] []} {[] []} {[] []}};
for ii=1:3
    % All tube specimens have same length (100mm), disp_data in mm
    if ii == 2
        % Specimen B only has data from one experiment 
        Stroke_efficiency{ii} = max(Disp_data{ii}) / 100;
    else
        % Calculate for each experiment of a tube specimen type
        for jj=1:2
            Stroke_efficiency{ii}{jj} = max(Disp_data{ii}{jj}) / 100;
        end
    end
end
% Single honeycomb specimens have thickness of 20 mm
for jj=1:2
    Stroke_efficiency{4}{jj} = max(Disp_data{4}{jj}) / 20;
end
% Double honeycomb specimens have thickness of 40 mm
for jj=1:2
    Stroke_efficiency{5}{jj} = max(Disp_data{5}{jj}) / 40;
end


% Calculate crush force efficiency for each experiment
% Crush force efficiency is ratio of mean force to max force
Crush_force_efficiency = {{[] []} [] {[] []} {[] []} {[] []}};
for ii=1:5
   if ii == 2
       Crush_force_efficiency{ii} = Mean_load{ii}/Max_load{ii};
   else
       for jj=1:2
           Crush_force_efficiency{ii}{jj} = Mean_load{ii}{jj}/Max_load{ii}{jj};
       end
   end
end


% Define relative dimensions for tube specimens

% Length/diameter
Ld = {[1.312] [1.992] [2.865]};
figure(13)
clf
hold on
grid on
xlabel('Length/Diameter');
ylabel('Energy Absorbed (J)');
title('Comparing ratio of Length to Diameter with Energy Absorbed')
for ii=1:3
    if ii==2
        plot(Ld{ii}, Total_energy_absorbed{ii}, 'o');
    else
        for jj=1:2
            plot(Ld{ii}, Total_energy_absorbed{ii}{jj}, 'o');
        end
    end
end
hgexport(gcf, 'l-d-energy.jpg', hgexport('factorystyle'), 'Format', 'jpeg');
figure(14)
clf
hold on
grid on
xlabel('Length/Diameter');
ylabel('Load (kN)');
title('Comparing ratio of Length to Diameter with Max and Mean Loads')
for ii=1:3
    if ii==2
        plot(Ld{ii}, Max_load{ii}, 'o');
        plot(Ld{ii}, Mean_load{ii}, '*');
    else
        for jj=1:2
            plot(Ld{ii}, Max_load{ii}{jj}, 'o');
            plot(Ld{ii}, Mean_load{ii}{jj}, '*');
        end
    end
end
hgexport(gcf, 'l-d-loads.jpg', hgexport('factorystyle'), 'Format', 'jpeg');
figure(15)
clf
hold on
grid on
xlabel('Length/Diameter');
ylabel('Efficiency (%)');
title('Comparing ratio of Length to Diameter with Efficiency Metrics')
for ii=1:3
    if ii==2
        plot(Ld{ii}, Energy_efficiency{ii}, 'o');
        plot(Ld{ii}, Stroke_efficiency{ii}, '*');
        plot(Ld{ii}, Crush_force_efficiency{ii}, '+');
    else
        for jj=1:2
            plot(Ld{ii}, Energy_efficiency{ii}{jj}, 'o');
            plot(Ld{ii}, Stroke_efficiency{ii}{jj}, '*');
            plot(Ld{ii}, Crush_force_efficiency{ii}{jj}, '+');
        end
    end
end
hgexport(gcf, 'l-d-efficiencies.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Diameter/Wall Thickness
dt = {[21.996] [31.99] [47.98]};
figure(16)
clf
hold on
grid on
xlabel('Diameter/Wall Thickness');
ylabel('Energy Absorbed (J)');
title('Comparing ratio of Diameter to Wall Thickness with Energy Absorbed')
for ii=1:3
    if ii==2
        plot(dt{ii}, Total_energy_absorbed{ii}, 'o');
    else
        for jj=1:2
            plot(dt{ii}, Total_energy_absorbed{ii}{jj}, 'o');
        end
    end
end
hgexport(gcf, 'd-t-energy.jpg', hgexport('factorystyle'), 'Format', 'jpeg');
figure(17)
clf
hold on
grid on
xlabel('Length/Diameter');
ylabel('Load (kN)');
title('Comparing ratio of Diameter to Wall Thickness with Max and Mean Loads')
for ii=1:3
    if ii==2
        plot(Ld{ii}, Max_load{ii}, 'o');
        plot(Ld{ii}, Mean_load{ii}, '*');
    else
        for jj=1:2
            plot(Ld{ii}, Max_load{ii}{jj}, 'o');
            plot(Ld{ii}, Mean_load{ii}{jj}, '*');
        end
    end
end
hgexport(gcf, 'd-t-loads.jpg', hgexport('factorystyle'), 'Format', 'jpeg');
figure(18)
clf
hold on
grid on
xlabel('Length/Diameter');
ylabel('Efficiency (%)');
title('Comparing ratio of Diameter to Wall Thickness with Efficiency Metrics')
for ii=1:3
    if ii==2
        plot(Ld{ii}, Energy_efficiency{ii}, 'o');
        plot(Ld{ii}, Stroke_efficiency{ii}, '*');
        plot(Ld{ii}, Crush_force_efficiency{ii}, '+');
    else
        for jj=1:2
            plot(Ld{ii}, Energy_efficiency{ii}{jj}, 'o');
            plot(Ld{ii}, Stroke_efficiency{ii}{jj}, '*');
            plot(Ld{ii}, Crush_force_efficiency{ii}{jj}, '+');
        end
    end
end
hgexport(gcf, 'd-t-efficiencies.jpg', hgexport('factorystyle'), 'Format', 'jpeg');



