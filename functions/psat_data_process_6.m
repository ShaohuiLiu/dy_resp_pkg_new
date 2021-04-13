%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pre-process the PSAT data

% Case: 2nd order model

% Author: Shaohui Liu
% Contact: shaohui.liu@utexas.edu
% Date: Jun. 23th, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [freq_impz,angle_impz,flow_impz,t_psat] = psat_data_process_6(Varout,T,dt)

tp_s = 102;
tp_e = tp_s + T/dt;

t_psat = Varout.t(tp_s:tp_e)-1;
y_psat = zeros(length(t_psat),6);
delta0 = zeros(3,1);
for i = 1 : 3
    % frequency
    y_psat(:,i) = Varout.vars(tp_s:tp_e,6*(i-1)+2)-1;
    % rotor angle
    delta0(i) = Varout.vars(2,2*(i-1)+1);
    y_psat(:,i+3) = Varout.vars(tp_s:tp_e,6*(i-1)+1)-Varout.vars(2,6*(i-1)+1);
end
% frequency
freq_impz = y_psat(:,1:3);
% rotor angle
angle_impz = y_psat(:,4:6);
% line power
% flow_impz = Varout.vars(tp_s:tp_e,46:63); % 2nd
flow_impz = Varout.vars(tp_s:tp_e,84:92); % 6th






end