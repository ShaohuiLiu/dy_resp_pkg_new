
% Pre-process the raw PMU data for dynamic response inference


%% A synthetic data case

% system size
n_bus = 3;

% assume the sampling rate is 15hz
sampling_rate = 15; 
dt = 1 / sampling_rate;

T = 1800; % 1800s
N = ceil(T/dt); % # of data pts

data_type1 = 'frequency';
data_type2 = 'angle';

% generate synthetic data
x_freq = rand(n_bus,N);
x_ang = rand(n_bus,N);

for i = 1 : N
    x_freq(:,i) = x_freq(:,i) + round(i/100);
    x_ang(:,i) = x_ang(:,i) + round(i/100);
end

% set the reference bus
ref_bus = 1;



%% Calculate the detrended data

% frequency
freq_ambient = real_data_processing(x_freq,data_type1,sampling_rate,ref_bus);

% angle
ang_ambient = real_data_processing(x_ang,data_type2,sampling_rate,ref_bus);



%% Visualization

T1 = 1 : dt : T;
index = 1 : length(T1);

fig1 = figure();
for i = 1 : n_bus
    subplot(n_bus,2,2*(i-1)+1)
    plot(T1,x_freq(i,index))
%     legend('raw freq','detrended freq')
    title(strcat('Frequency raw',num2str(i)))
    grid on
    subplot(n_bus,2,2*(i-1)+2)
    plot(T1,freq_ambient(i,index))
%     legend('raw freq','detrended freq')
    title(strcat('Frequency detrended',num2str(i)))
    grid on
end
hold off

fig2 = figure();
for i = 1 : n_bus
    subplot(n_bus,2,2*(i-1)+1)
    plot(T1,x_ang(i,index))
%     legend('raw freq','detrended freq')
    title(strcat('Angle raw',num2str(i)))
    grid on
    subplot(n_bus,2,2*(i-1)+2)
    plot(T1,ang_ambient(i,index))
%     legend('raw freq','detrended freq')
    title(strcat('Angle detrended',num2str(i)))
    grid on
end
hold off


