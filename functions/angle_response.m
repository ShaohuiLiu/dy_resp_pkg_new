%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamic Response Estimation 

% Frequency response estimation from ambient data

% Author: Shaohui Liu
% Contact: shaohui.liu@utexas.edu
% Date: Jun. 23th, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function ang_resp = angle_response(ang_data,n_gen,dt)

ang_resp = cell(n_gen,1);
n = size(ang_data,1);

% filter the ambient data using bandpass filter
for i = 1 : n_gen
    ang_data(:,i) = bandpass(ang_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
end

for i = 1 : n_gen
    resp = zeros(n,n_gen);
    for j = 1 : n_gen
        % cross-correlation
        temp = xcorr(ang_data(:,i),ang_data(:,j));
        temp = temp(n:end);
        % taking derivative
        len_crr = length(temp)-1;
        temp1 = zeros(len_crr,1);
        for k = 1 : len_crr
            temp1(k) = (temp(k+1) - temp(k)) ./ dt;
        end
        % normalization
        temp1 = temp1 ./ max(temp1);
        resp(2:end,j) = temp1;
        resp(1,j) = temp1(1);
    end
    ang_resp{i} = resp;
end


end