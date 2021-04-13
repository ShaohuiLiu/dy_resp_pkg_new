%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data processing for ambient data: returns frequency, angle and line flow

% Author: Shaohui Liu
% Contact: shaohui.liu@utexas.edu
% Date: Jun. 23th, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [T1,frequency,angle,flow] = data_process(x_ambient,f_ambient,T,T_start,dt)
% delete the first few seconds for the stability issue, truncate the data
% from T_start

start_idx = T_start/dt + 1; 
T_len = T(end)-T_start;
end_idx = start_idx + T_len/dt;
% time span of the truncated data
T1 = T_start : dt : T_start + T_len; 
% n0 = length(T1);

XX = zeros(size(x_ambient));
% frequency
XX(:,1) = x_ambient(:,2);
XX(:,2) = x_ambient(:,4);
XX(:,3) = x_ambient(:,6);
% angle
XX(:,4) = x_ambient(:,1);
XX(:,5) = x_ambient(:,3);
XX(:,6) = x_ambient(:,5);

% frequency = zeros(n0,3);
% angle = zeros(n0,3);

frequency = XX(start_idx:end_idx,1:3);
angle = XX(start_idx:end_idx,4:6);

flow = f_ambient(start_idx:end_idx,:);





end