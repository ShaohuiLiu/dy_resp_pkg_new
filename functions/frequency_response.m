%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamic Response Estimation 

% Frequency response estimation from ambient data

% Author: Shaohui Liu
% Contact: shaohui.liu@utexas.edu
% Date: Jun. 23th, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function freq_resp = frequency_response(freq_data,n_gen,dt)

freq_resp = cell(n_gen,1);
n = size(freq_data,1);

% filter the ambient data using bandpass filter
for i = 1 : n_gen
    freq_data(:,i) = bandpass(freq_data(:,i),[0.001 200],round(1/dt)); % 100
end

for i = 1 : n_gen
    resp = zeros(n,n_gen);
    for j = 1 : n_gen
        % cross-correlation
        temp0 = xcorr(freq_data(:,i),freq_data(:,j));
%         figure
%         subplot(1,2,1)
%         plot(temp0(n:n+500))
%         hold on
        % normalization
        temp1 = temp0(n:end);
        temp = temp1 ./ max(abs(temp1));
%         subplot(1,2,2)
%         plot(temp(1:500))
        resp(:,j) = temp1;
    end
    freq_resp{i} = resp;
end


end


