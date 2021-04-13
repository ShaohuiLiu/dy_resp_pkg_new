%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Line Flow Response Estimation 

% Line flow response estimation from ambient data

% Author: Shaohui Liu
% Contact: shaohui.liu@utexas.edu
% Date: Jun. 23th, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function flow_resp = line_flow_response(ang_data,flow_data,input_loc,n_gen,n_line,dt)

n = size(ang_data,1);

% filter the ambient data using bandpass filter
for i = 1 : n_gen
    ang_data(:,i) = bandpass(ang_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
end
for i = 1 : n_line
    flow_data(:,i) = bandpass(flow_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
end


flow_resp = zeros(n,n_line);
for i = 1 : n_line
    % cross-correlation
    temp = xcorr(flow_data(:,i),ang_data(:,input_loc));
    temp = temp(n:end);
    % taking derivative
    len_crr = length(temp)-1;
    temp1 = zeros(len_crr,1);
    for k = 1 : len_crr
        temp1(k) = (temp(k+1) - temp(k)) ./ dt;
    end
    % normalization
%     temp1 = temp1 ./ max(temp1);
    flow_resp(2:end,i) = temp1;
    flow_resp(1,i) = temp1(1);
end




end