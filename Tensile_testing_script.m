% Tensile Testing Data Analysiser and Plotter

% Load raw data from csv file
load tens1dat.csv
load tens2dat.csv
load tens3dat.csv
load tens4dat.csv

% Save data to a matrix
a = tens1dat;
b = tens2dat;
c = tens3dat;
d = tens4dat;

% Determine number of rows and columns
[row_a, col_a] = size(a);
[row_b, col_b] = size(b);
[row_c, col_c] = size(c);
[row_d, col_d] = size(d);

% Raw data of tens1dat and tens2dat is extension (mm) and load (kN)
extension_a = a(1:row_a, 1);
load_a = a(1:row_a, 2);
extension_b = b(1:row_b, 1);
load_b = b(1:row_b, 2);

% Raw data of tens3dat and tens4dat is load (kN), microstrain_y and 
% microstrain_x where y is aligned to the axis of elongation
load_c = c(1:row_c, 1);
microstrain_y_c = c(1:row_c, 2);
microstrain_x_c = c(1:row_c, 3);
load_d = d(1:row_d, 1);
microstrain_y_d = d(1:row_d, 2);
microstrain_x_d = d(1:row_d, 3);



% Calculate engineering stress (MPa) and strain

% Set original cross-sectional area and length
A_original = 0.012*0.00159; % 
l_original = 25; % mm Extensometer original length

% Calculate eng stress & strain for extensometer data
% Stress (MPa) = Load (kN) / Area
% Strain = Extension / Length
stress_a = load_a / (A_original * 1000);
strain_a = extension_a / l_original;
stress_b = load_b / (A_original * 1000);
strain_b = extension_b / l_original;

% Calculate eng stress & strain for strain gauge data
% Stress = Load / Area
% Strain * 10^6 = Microstrain
stress_c = load_c / (A_original * 1000);
strain_c = microstrain_y_c / 10^6;
stress_d = load_d / (A_original * 1000);
strain_d = microstrain_y_d / 10^6;



% Calculate true stress (MPa) and strain

% Calculate true stress & strain for all data
% True Stress (MPa) = Eng Stress (MPa) (1 + Eng Strain)
% True Strain = ln(1 + Eng Strain)
true_stress_a = stress_a .* (1 + strain_a);
true_strain_a = log(1 + strain_a );
true_stress_b = stress_b .* (1 + strain_b);
true_strain_b = log(1 + strain_b );
true_stress_c = stress_c .* (1 + strain_c);
true_strain_c = log(1 + strain_c );
true_stress_d = stress_d .* (1 + strain_d);
true_strain_d = log(1 + strain_d );



% Calculate Poisson's ratio from strain gauge data

% Calculate transverse strain for strain guage data
strain_x_c = microstrain_x_c / 10^6;
strain_x_d = microstrain_x_d / 10^6;

% Calculate Poisson's ratio from strain guage data
poisson_c_matrix = - strain_x_c ./ strain_c;
poisson_ave_c = mean(poisson_c_matrix)
poisson_d_matrix = - strain_x_d ./ strain_d;
poisson_ave_d = mean(poisson_d_matrix)
poisson = (poisson_ave_c + poisson_ave_d)/2



% Calculate Young's modulus

% Take a sample of each data set inside the elastic region
elastic_stress_a = 10^6 * stress_a(100:700);
elastic_strain_a = strain_a(100:700);
elastic_stress_b = 10^6 * stress_b(200:900);
elastic_strain_b = strain_b(200:900);
elastic_stress_c = 10^6 * stress_c(50:120);
elastic_strain_c = strain_c(50:120);
elastic_stress_d = 10^6 * stress_d(40:110);
elastic_strain_d = strain_d(40:110);

% Calculate E for each stress-strain data pair in defined elastic region
E_data_a = elastic_stress_a ./ elastic_strain_a;
E_data_b = elastic_stress_b ./ elastic_strain_b;
E_data_c = elastic_stress_c ./ elastic_strain_c;
E_data_d = elastic_stress_d ./ elastic_strain_d;


% Calculate average E for each dataset
E_a = mean(E_data_a)
E_b = mean(E_data_b)
E_c = mean(E_data_c)
E_d = mean(E_data_d)

% Calculate average E for extensometer & strain guage experiments
E_ave_extensometer = (E_a + E_b) / 2
E_ave_strain_gauge = (E_c + E_d) / 2

% Calculate average E of all data sets
E_ave = (E_a + E_b + E_c + E_d) / 4

% Define markers on tensile plots for calculation of Young's Modulus
E_m_a = [stress_a(100) stress_a(700); strain_a(100) strain_a(700)];
E_m_b = [stress_b(200) stress_b(900); strain_b(200) strain_b(900)];
E_m_c = [stress_c(50) stress_c(120); strain_c(50) strain_c(120)];
E_m_d = [stress_d(40) stress_d(110); strain_d(40) strain_d(110)];



% Calculate yeild strength
% Using 0.2% strain offset and find point of intersection

% Create 0.2% offset for each data set
% A data set
yield_offset_strain = linspace(0.002, 0.007);
yield_offset_stress_a = E_a / 10^6 .* (yield_offset_strain - 0.002);
yield_offset_stress_b = E_b / 10^6 .* (yield_offset_strain - 0.002);
yield_offset_stress_c = E_c / 10^6 .* (yield_offset_strain - 0.002);
yield_offset_stress_d = E_d / 10^6 .* (yield_offset_strain - 0.002);


% Find Ultimate Tensile Strength
% Only extensometer readings cover entire testing range so UTS's of strain
% gauge experiments may not be in strain gauge stress data
UTS_a = max(stress_a)
UTS_b = max(stress_b)
UTS_ext_ave = (UTS_a + UTS_b)/2


% Find Fracture Strain
% Only extensometer readings cover entire testing range so fracture strain
% was not measured in strain gauge experiments
fracture_strain_a = max(strain_a)
fracture_strain_b = max(strain_b)
fracture_strain_ext_ave = (fracture_strain_a + fracture_strain_b)/2






% Plot data

% Plot eng stress strain all data
figure(1)
clf
plot(strain_a, stress_a, 'b', strain_b, stress_b, 'g', strain_c, stress_c, 'k.-', strain_d, stress_d, 'c.-');
grid on
xlabel('Engineering Strain');
ylabel('Engineering Stress (MPa)');
title('6082-T6 Aluminium Tensile Testing Engineering Stress-Strain Results')
legend('Extensometer Experiment 1' , 'Extensometer Experiment 2', 'Strain Gauge Experiment 1', 'Strain Gauge Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'engstressstrainalldata.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot eng stress strain extensometer data
figure(2)
clf
plot(strain_a, stress_a, 'b', strain_b, stress_b, 'g');
grid on
xlabel('Engineering Strain');
ylabel('Engineering Stress (MPa)');
title('6082-T6 Aluminium Tensile Testing Engineering Stress-Strain Results Using Extensometer')
legend('Experiment 1' , 'Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'engstressstrainexten.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot eng stress strain strain gauge data
figure(3)
clf
plot(strain_c, stress_c, 'b', strain_d, stress_d, 'g');
grid on
xlabel('Engineering Strain');
ylabel('Engineering Stress (MPa)');
title('6082-T6 Aluminium Tensile Testing Engineering Stress-Strain Results Using Strain Guages')
legend('Experiment 1' , 'Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'engstressstraingauge.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot axial and transverse strain during tensile testing
figure(4)
clf
plot(strain_x_c, strain_c, 'b', strain_x_d, strain_d, 'g');
grid on
xlabel('Transverse Engineering Strain');
ylabel('Axial Engineering Strain');
title('6082-T6 Aluminium Tensile Testing Axial and Transverse Strain Results')
legend('Strain Guage Experiment 1' , 'Strain Guage Experiment 2')
hgexport(gcf, 'axtransstraingauge.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot true stress strain all data
figure(5)
clf
plot(true_strain_a, true_stress_a, 'b', true_strain_b, true_stress_b, 'g', true_strain_c, true_stress_c, 'k.-', true_strain_d, true_stress_d, 'c.-');
grid on
xlabel('True Strain');
ylabel('True Stress (MPa)');
title('6082-T6 Aluminium Tensile Testing True Stress-Strain Results')
legend('Extensometer Experiment 1' , 'Extensometer Experiment 2', 'Strain Gauge Experiment 1', 'Strain Gauge Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'truestressstrainalldata.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot eng stress strain extensometer data
figure(6)
clf
plot(true_strain_a, true_stress_a, 'b', true_strain_b, true_stress_b, 'g');
grid on
xlabel('True Strain');
ylabel('True Stress (MPa)');
title('6082-T6 Aluminium Tensile Testing True Stress-Strain Results Using Extensometer')
legend('Experiment 1' , 'Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'truestressstrainexten.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

% Plot true stress strain strain gauge data
figure(7)
clf
plot(true_strain_c, true_stress_c, 'b', true_strain_d, true_stress_d, 'g');
grid on
xlabel('True Strain');
ylabel('True Stress (MPa)');
title('6082-T6 Aluminium Tensile Testing True Stress-Strain Results Using Strain Guages')
legend('Experiment 1' , 'Experiment 2', 'Location', 'SouthEast')
hgexport(gcf, 'truestressstraingauge.jpg', hgexport('factorystyle'), 'Format', 'jpeg');




% DEBUG



figure(8)
clf
plot(strain_a, stress_a, yield_offset_strain, yield_offset_stress_a);
grid on
title('Experiment 1 Yield Strength')
hgexport(gcf, 'yieldstength1.jpg', hgexport('factorystyle'), 'Format', 'jpeg');


figure(9)
clf
plot(strain_b, stress_b, yield_offset_strain, yield_offset_stress_b);
grid on
title('Experiment 2 Yield Strength')
hgexport(gcf, 'yieldstength2.jpg', hgexport('factorystyle'), 'Format', 'jpeg');


figure(10)
clf
plot(strain_c, stress_c, yield_offset_strain, yield_offset_stress_c);
grid on
title('Experiment 3 Yield Strength')
hgexport(gcf, 'yieldstength3.jpg', hgexport('factorystyle'), 'Format', 'jpeg');


figure(11)
clf
plot(strain_d, stress_d, yield_offset_strain, yield_offset_stress_d);
grid on
title('Experiment 4 Yield Strength')
hgexport(gcf, 'yieldstength4.jpg', hgexport('factorystyle'), 'Format', 'jpeg');

