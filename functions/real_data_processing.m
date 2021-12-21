
% pre-process the raw PMU data for dynamic response inference
%
% Input: Raw data, data type, sampling rate, reference bus index
% Algotrithm: Matlab built-in bandwidth filter
%   -- Frequency: filter out slow dynamics
%   -- Angle: Pick a reference angle/bus then detrend the relative angle
% Output: detrended ambient data
%
% Date: 11/12/2020
% Author: Shaohui Liu
% contact: shaohui.liu@utexas.edu

function  x_ambient = real_data_processing(X,d_type,s_rate,ref_bus)

if strcmp(d_type,'frequency') % d_type == 'frequency'
    x_ambient = frequency_processing(X,s_rate);
elseif strcmp(d_type,'angle') % d_type == 'angle'
    x_ambient = angle_processing(X,s_rate,ref_bus);
else
    disp('Unsupported data type:');
    disp(d_type);
    disp('Empty dataset returned instead.');
    x_ambient = [];
end


end



function x_ambient = frequency_processing(X,s_rate)

[n,T0] = size(X);
x_ambient = zeros(n,T0);

T = T0 / s_rate; 

for i = 1 : n
    % pass band [0.01 s_rate]
    x_ambient(i,:) = bandpass(X(i,:),[0.01 s_rate],s_rate);
end


disp('Frequency uccessful!')

end




function x_ambient = angle_processing(X,s_rate,ref_bus)

[n,T0] = size(X);
x_ambient = zeros(n,T0);

% T = T0 / s_rate; 

% calculate signal for slack bus
x0 = X(ref_bus,:);
x_ref = lowpass(x0,0.1,s_rate);

figure
plot(x_ref)
title('Reference angle signal')
hold off


for i = 1 : n
    % detrend the relative angle with pass band [0.01 s_rate]
    x_ambient(i,:) = bandpass(X(i,:) - x_ref,[0.01 s_rate],s_rate);
end

disp('Angle uccessful!')


end



% power to be added if necessary
function power_processing()


end