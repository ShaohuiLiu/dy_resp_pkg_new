%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dynamic Response Estimation 

% This is the main file of the dynamic response estimation algorithm. The
% algorithm is aimed for inferring the impulse response of frequency, angle
% and line powerresponse of power grid from the ambient data. In this test
% file both ambient data and impulse response data were generated by PSAT.
% The impulse response data were generated by using a step function as an
% approximation of an impulse signal to the mechanical power of a certain
% generator. The ambient data were generated by the time domain simulation
% with noise injected at all generator mechanical power. The example used
% the 2nd order model with non-uniform damping condition. The 2nd order 
% uniform damping case and higher order model cases were also validated.

% Case model: IEEE 9-bus system, 3 generators, 3 loads, 9 lines.

% Author: Shaohui Liu
% Contact: shaohui.liu@utexas.edu
% Date: Jun. 23th, 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Initialize parameters and load data

% load ambient data file
addpath('functions');
% load data/psat_td_data_6th_nonunif_0731.mat % original
% load data/psat_td_data_6th_nonunif_load_0731.mat
% load data/psat_td_data_6th_nonunif_load.mat % original 3 load
% load ../test_cases_1115/td_6th_nonunif_load_on_gen_scaled1_1117.mat % 3 loads on gen, scaled by damping
load ../test_cases_1115/td_6th_nonunif_load_on_gen_damp_1117.mat % 3 loads on gen, scaled by damping coeff
% load data/TD_6th_nonunif_data_power_new.mat
t_ambient = Varout.t;
x_ambient = Varout.vars(:,[1,2,7,8,13,14]);
f_ambient = Varout.vars(:,84:92);

n_gen = 3; % number of generators
n_line = 9; % number of lines
dt = .01; % discrete time step for data
T = t_ambient; % 
T_start = 20; % we use the data start from 20s

[T1,freq_data,angle_data,flow_data] = data_process(x_ambient,f_ambient,T,T_start,dt);
n1 = length(T);
n0 = length(T1);


%% Recover the dynamic response from ambient data

% frequency
freq_data = freq_data - 1;
freq_resp = frequency_response6(freq_data,n_gen,dt);

% rotor angle
ang_resp = angle_response6(angle_data,n_gen,dt);

% line flow
input_loc = 2;
flow_resp = line_flow_response6(angle_data,flow_data,input_loc,n_gen,n_line,dt);

% inferred response of input at generator 1
freq_resp1 = freq_resp{input_loc};
ang_resp1 = ang_resp{input_loc};



%% Load impulse response data
% load data/impz_resp_6th_nonunif_power.mat % impulse response w/ input@1st generator
% load data/impz_resp_6th_nonunif_power_0730.mat % input location1
% load data/d_009_6th_order_nonunif_load_pert_file2.mat % input at gen2, mechanical power
load ../test_cases_1115/6th_nonunif_pert_file_input2.mat % input at gen2, mechanical power
% load data/d_009_6th_order_nonunif_load_pert_file3.mat % input at gen3, mechanical power
psat_temp = Varout;

% load data/d_009_6th_order_nonunif_load_pert_fault2.mat % input at gen2, load fault
% load ../test_cases_1115/6th_nonunif_fault_input2_p005.mat % input at gen2, load fault
% load ../test_cases_1115/6th_nonunif_fault_input2_p01.mat % input at gen2, load fault
load ../test_cases_1115/6th_nonunif_load_impulse_1117.mat % input at gen2, load impulse on gen
% load data/d_009_6th_order_nonunif_load_pert_fault3.mat % input at gen2, load fault
psat_temp_fault = Varout;

% Time span for prediction
t_range = 5.9;

[freq_impz,angle_impz,flow_impz,t_psat] = psat_data_process_6(psat_temp,t_range,dt);

[freq_impz_fault,angle_impz_fault,flow_impz_fault,t_psat_fault] = psat_data_process_6(psat_temp_fault,t_range,dt);

freq_impz_fault = -freq_impz_fault;
angle_impz_fault = -angle_impz_fault;
flow_impz_fault = -flow_impz_fault;

% normalization
for i = 1 : n_gen
    freq_impz(:,i) = freq_impz(:,i) ./ max(freq_impz(:,i));
    freq_impz_fault(:,i) = freq_impz_fault(:,i) ./ max(freq_impz_fault(:,i));
end




%% Plot the results

plot_switch = 1;
save_switch = 0;

T2 = 0 : dt : t_range;
plot_idx = 1 : length(T2);
if plot_switch == 1
    
% Frequency    
fig1 = figure('DefaultAxesFontSize',18);
freq_resp2 = freq_resp1;
for i = 1 : 3
%     if i ~= input_loc
%         freq_resp2(:,i) = freq_resp2(:,i) - freq_resp2(1,i);
%     end
    freq_resp2(:,i) = freq_resp2(:,i)./max(abs(freq_resp2(:,i)));
    subplot(1,3,i)
%     plot(t_psat,freq_impz(:,i),'-.',T2,freq_resp2(plot_idx,i),'-','LineWidth',2);
    plot(t_psat,freq_impz(:,i),'-.',t_psat(2:end),freq_impz_fault(2:end,i),':',T2,freq_resp2(plot_idx,i),'-','LineWidth',2);
    xlabel('Time [s]');
    ylabel('scale');
    xlim([0 t_range]);
    title(strcat('\omega ',num2str(i)));
    if i == 1
%         legend('model based','data driven','Location','best');
        legend('model based(mech.)','model based(fault)','data driven','Location','best');
    end
%     title('Input: \omega_1')
    grid on
end
sgt = sgtitle('Frequency response: 6th order, non-uniform damping, input3');
sgt.FontSize = 32;
set(fig1,'Position',[10 10 1500 400])

if save_switch == 1
    filename = '6th_nonunif_frequency';
    savefig(fig1,filename,'compact');
    saveas(fig1,filename,'epsc');
    saveas(fig1,filename,'png');
    movefile(strcat(filename,'.fig'),'plot')
    movefile(strcat(filename,'.eps'),'plot')
    movefile(strcat(filename,'.png'),'plot')
end

fig2 = figure('DefaultAxesFontSize',18);
for i = 1 : n_gen
    subplot(1,3,i)
    plot(t_psat,angle_impz(:,i)./max(abs(angle_impz(:,i))),'-.',...
         t_psat(2:end),angle_impz_fault(2:end,i)./max(abs(angle_impz_fault(2:end,i))),':',...
         T2,ang_resp1(plot_idx,i)./-max(abs(ang_resp1(plot_idx,i))),'-','LineWidth',2); %T1,freq_resp1(:,i),'-',
    xlabel('Time [s]');
    ylabel('scale');
    xlim([0 t_range]);
    title(strcat('\delta ',num2str(i)));
    if i == 1
        legend('model based(mech.)','model based(load)','data driven','Location','best');
    end
%     title('Input: \omega_1')
    grid on
end
sgt = sgtitle('Rotor angle response: 2nd order, uniform damping, input2 ');
sgt.FontSize = 32;
set(fig2,'Position',[10 200 1500 400])


if save_switch == 1
    filename = '6th_nonunif_angle';
    savefig(fig2,filename,'compact');
    saveas(fig2,filename,'epsc');
    saveas(fig2,filename,'png');
    movefile(strcat(filename,'.fig'),'plot')
    movefile(strcat(filename,'.eps'),'plot')
    movefile(strcat(filename,'.png'),'plot')
end


% line flow
fig3 = figure('DefaultAxesFontSize',18);
line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
flow_impz1 = flow_impz .* .1; % power rating
for i  = 1 : n_line
    subplot(3,3,i)
    flow_resp_temp = - (flow_resp(plot_idx,i)-flow_resp(plot_idx(1),i));
    flow_resp_temp = flow_resp_temp ./ 73;
    temp1 = (flow_impz1(:,i)-flow_impz1(1,i));
    temp2 = flow_impz_fault(3:end,i) - flow_impz_fault(3,i);
    plot(t_psat, temp1./max(abs(temp1)),'-.',...
         t_psat(3:end),temp2./max(abs(temp2)),':',...
         T2,flow_resp_temp./max(abs(flow_resp_temp)),'-','LineWidth',2);
    xlabel('Time [s]');
%     ylabel('Power dev. [MW]');
    xlim([0 t_range]);
    title(strcat('line ',line_idx(i)));
    if i == 1
%         legend('model based','data driven','Location','best');
        legend('model based(mech.)','model based(load)','data driven','Location','best');
    end
%     title('Input: \omega_2')
    grid on
end
sgt = sgtitle('Line response: 2nd order, non-uniform damping, input2');
sgt.FontSize = 32;
set(fig3,'Position',[10 100 1500 1200])


if save_switch == 1
    filename = '6th_nonunif_flow';
    savefig(fig3,filename,'compact');
    saveas(fig3,filename,'epsc');
    saveas(fig3,filename,'png');
    movefile(strcat(filename,'.fig'),'plot')
    movefile(strcat(filename,'.eps'),'plot')
    movefile(strcat(filename,'.png'),'plot')
end
    
end



