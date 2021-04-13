%% plot for paper
% fig0 = figure('DefaultAxesFontSize',24);
% subplot(1,3,1)
% % plot(T,x_ambient(:,1),'k','LineWidth',1);
% plot(T,x_ambient(:,2),'k','LineWidth',1);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('\omega_l','Location','northwest');
% % title('Frequency outputs of ambient inputs(\omega)-psat')
% set(gca,'xticklabel',[],'yticklabel',[])
% grid on
% subplot(1,3,2)
% % plot(T,x_ambient(:,3),'k','LineWidth',1);
% plot(T,x_ambient(:,1),'k','LineWidth',1);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('\delta_k','Location','northwest');
% % title('Angle outputs of ambient inputs(\theta)-psat')
% set(gca,'xticklabel',[],'yticklabel',[])
% grid on
% subplot(1,3,3)
% % plot(T,x_ambient(:,3),'k','LineWidth',1);
% plot(T,Varout.vars(:,85),'k','LineWidth',1);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('p_{ij}','Location','northwest');
% % title('Angle outputs of ambient inputs(\theta)-psat')
% set(gca,'xticklabel',[],'yticklabel',[])
% grid on
% % % subplot(2,2,3)
% % % plot(T_lin,XX_lin(:,1),T_lin,XX_lin(:,2),T_lin,XX_lin(:,3),'LineWidth',2);
% % % xlabel('Time [s]');
% % % ylabel('scale');
% % % legend('\omega_1','\omega_2','\omega_3','Location','best');
% % % title('Frequency outputs of ambient inputs(\omega)')
% % % grid on
% % % subplot(2,2,4)
% % % plot(T_lin,XX_lin(:,4),T_lin,XX_lin(:,5),T_lin,XX_lin(:,6),'LineWidth',2);
% % % xlabel('Time [s]');
% % % ylabel('scale');
% % % legend('\delta_1','\delta_2','\delta_3','Location','best');
% % % title('Angle outputs of ambient inputs(\theta)')
% % % grid on
% % % set(gca,'FontSize',20)
% set(fig0,'Position',[10 10 1500 200])
% 
% % fig1 = figure('DefaultAxesFontSize',18);
% % plot(wc21(1:2000),'k','LineWidth',1);
% % set(gca,'xticklabel',[],'yticklabel',[])
% % grid on
% % set(fig1,'Position',[10 10 750 200])



% 
fig5 = figure('DefaultAxesFontSize',18);
freq_resp2 = freq_resp1;
for i = 1 : 3
    if i ~= 1
        freq_resp2(:,i) = freq_resp2(:,i) - freq_resp2(1,i);
    end
    freq_resp2(:,i) = freq_resp2(:,i)./max(abs(freq_resp2(:,i)));
    subplot(3,3,i)
    plot(t_psat,freq_impz(:,i),'-.',T2,freq_resp2(plot_idx,i),'-','LineWidth',2);
%     xlabel('Time [s]');
    ylabel(strcat('\omega ',num2str(i)));
    xlim([0 t_range]);
%     title(strcat('\omega ',num2str(i)));
    if i == 1
        legend('model based','data driven','Location','best');
    end
%     title('Input: \omega_1')
    grid on
end

% Rotor angle
for i = 1 : n_gen
    subplot(3,3,i+3)
    plot(t_psat,angle_impz(:,i) ./ max(abs(angle_impz(:,i))),'-.',T2,(ang_resp1(plot_idx,i) ./ (-11)) ./ max(abs(ang_resp1(plot_idx,i) ./ (-11))),'-','LineWidth',2); %T1,freq_resp1(:,i),'-',
%     xlabel('Time [s]');
    ylabel(strcat('\delta ',num2str(i)));
    xlim([0 t_range]);
%     title(strcat('\delta ',num2str(i)));
    if i == 1
%         legend('model based','data driven','Location','best');
    end
%     title('Input: \omega_1')
    grid on
end


% Line flow
line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
flow_impz1 = flow_impz .* 100; % power rating
ppindex = [2,3,5];
for i  = 1 : 3
%     subplot(3,3,i)
    flow_resp_temp = - (flow_resp(plot_idx,ppindex(i))-flow_resp(plot_idx(1),ppindex(i)));
    flow_resp_temp = flow_resp_temp ./ 40;
    subplot(3,3,i+6)
    a = flow_impz1(:,ppindex(i))-flow_impz1(1,ppindex(i));
    plot(t_psat,a ./ max(abs(a)), ...
        '-.',T2,flow_resp_temp ./ max(abs(flow_resp_temp)),'-','LineWidth',2);
    xlabel('Time [s]');
    ylabel(strcat('line ',line_idx(ppindex(i))));
    xlim([0 t_range]);
%     title(strcat('line ',line_idx(ppindex(i))));
    if i == 1
%         legend('model based','data driven','Location','best');
    end
%     title('Input: \omega_2')
    grid on
end
% sgt = sgtitle('Line response: 2nd order, uniform damping, input1');
% sgt.FontSize = 32;
set(fig5,'Position',[10 50 1600 800])
% 
% filename = '2nd_unif_dyn_rsp';
% savefig(fig5,filename,'compact');
% saveas(fig5,filename,'epsc');
% saveas(fig5,filename,'png');
% movefile(strcat(filename,'.fig'),'plots')
% movefile(strcat(filename,'.eps'),'plots')
% movefile(strcat(filename,'.png'),'plots')


%% plot for PESGM2020





% fig3 = figure('DefaultAxesFontSize',24);
% line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
% flow_impz1 = flow_impz .* 100; % power rating
% index = [1,3,4,6,7,9];
% for i  = 1 : 6
%     subplot(2,3,i)
%     flow_resp_temp = - (flow_resp(plot_idx,index(i))-flow_resp(plot_idx(1),index(i)));
%     flow_resp_temp = flow_resp_temp ./ 40;
%     plot(t_psat,flow_impz1(:,index(i))-flow_impz1(1,index(i)),'-',T2,flow_resp_temp,'-.','LineWidth',2);
%     xlabel('Time [s]');
%     ylabel('Power dev. [MW]');
%     xlim([0 t_range]);
%     title(strcat('line ',line_idx(index(i))));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
% %     title('Input: \omega_2')
%     grid on
% end
% % sgt = sgtitle('Line response: 2nd order, non-uniform damping, input1');
% % sgt.FontSize = 32;
% set(fig3,'Position',[10 500 1500 500])

% % angle
% fig2 = figure('DefaultAxesFontSize',24);
% subplot(3,3,1)
% % plot(t0,y(:,4,2)./(max(abs(y(:,4,2)))),'-',T2,-(tc21(plot_idx)-tc21(plot_idx(1)))./(max(abs(tc21(plot_idx)-tc21(plot_idx(1))))),'-',T2,-tc_lin21(plot_idx)./(max(abs(tc_lin21(plot_idx)))),'-','LineWidth',2);
% plot(t0,y(:,4,2)./(max(abs(y(:,4,2)))),'-',T2,-(tc21(plot_idx))./(max(abs(tc21(plot_idx)))),'-.','LineWidth',2);
% % xlabel('Time [s]');
% ylabel('\delta_1');
% xlim([0 5]);
% legend('Model-based','Data driven','Location','best');
% title('Input: u_2')
% grid on
% subplot(3,3,4)
% plot(t0,y(:,5,2)./(max(abs(y(:,5,2)))),'-',T2,-(tc22(plot_idx))./(max(abs(tc22(plot_idx)))),'-.','LineWidth',2);
% % xlabel('Time [s]');
% ylabel('\delta_2');
% xlim([0 5]);
% % legend('model based(psat)','linear model(ang.)','estimated time domain','Location','best');
% % title('\delta_2')
% grid on
% subplot(3,3,7)
% plot(t0,y(:,6,2)./(max(abs(y(:,6,2)))),'-',T2,-(tc23(plot_idx))./(max(abs(tc23(plot_idx)))),'-.','LineWidth',2);
% xlabel('Time [s]');
% ylabel('\delta_3');
% xlim([0 5]);
% % legend('model based(psat)','linear model(ang.)','estimated time domain','Location','best');
% % title('\delta_3')
% grid on
% 
% subplot(3,3,2)
% plot(t0,y(:,4,1)./(max(abs(y(:,4,1)))),'-',T2,-(tc11(plot_idx))./(max(abs(tc11(plot_idx)))),'-.','LineWidth',2);
% xlim([0 5]);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('linear model(ang.)','estimated time domain','Location','best');
% title('Input: u_1')
% grid on
% subplot(3,3,5)
% plot(t0,y(:,5,1)./(max(abs(y(:,5,1)))),'-',T2,-(tc21(plot_idx))./(max(abs((tc21(plot_idx))))),'-.','LineWidth',2);
% xlim([0 5]);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('linear model(ang.)','estimated time domain','Location','best');
% title('\delta_2')
% grid on
% subplot(3,3,8)
% plot(t0,y(:,6,1)./(max(abs(y(:,6,1)))),'-',T2,-(tc13(plot_idx))./(max(abs(tc13(plot_idx)))),'-.','LineWidth',2);
% xlim([0 5]);
% xlabel('Time [s]');
% % ylabel('scale');
% % legend('linear model(ang.)','estimated time domain','Location','best');
% title('\delta_3')
% grid on
% 
% subplot(3,3,3)
% plot(t0,y(:,4,3)./(max(abs(y(:,4,3)))),'-',T2,-(tc13(plot_idx))./(max(abs((tc13(plot_idx))))),'-.','LineWidth',2);
% xlim([0 5]);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('linear model(ang.)','estimated time domain','Location','best');
% title('Input: u_3')
% grid on
% subplot(3,3,6)
% plot(t0,y(:,5,3)./(max(abs(y(:,5,3)))),'-',T2,-(tc23(plot_idx))./(max(abs((tc23(plot_idx))))),'-.','LineWidth',2);
% xlim([0 5]);
% % xlabel('Time [s]');
% % ylabel('scale');
% % legend('linear model(ang.)','estimated time domain','Location','best');
% title('\delta_2')
% grid on
% subplot(3,3,9)
% plot(t0,y(:,6,3)./(max(abs(y(:,6,3)))),'-',T2,-(tc33(plot_idx))./(max(abs(tc33(plot_idx)))),'-.','LineWidth',2);
% xlim([0 5]);
% xlabel('Time [s]');
% % ylabel('scale');
% % legend('linear model(ang.)','estimated time domain','Location','best');
% % title('\_3')
% grid on
% % sgtitle('Input: \omega_3')
% set(fig2,'Position',[10 10 1500 600])




% %% filter and freq-flow correlation
% load data/psat_td_data_2nd_nonunif.mat
% t_ambient = Varout.t;
% x_ambient = Varout.vars(:,1:6);
% f_ambient = Varout.vars(:,46:54);
% 
% n_gen = 3; % number of generators
% n_line = 9; % number of lines
% dt = .01; % discrete time step for data
% T = t_ambient; % 
% T_start = 20; % we use the data start from 20s
% 
% [T1,freq_data,angle_data,flow_data] = data_process(x_ambient,f_ambient,T,T_start,dt);
% n1 = length(T);
% n0 = length(T1);
% % frequency
% freq_data_fil = zeros(size(freq_data));
% for i = 1 : n_gen
%     freq_data_fil(:,i) = bandpass(freq_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
% end
% % angle
% ang_data_fil = zeros(size(angle_data));
% for i = 1 : n_gen
%     ang_data_fil(:,i) = bandpass(angle_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
% end
% % flow
% flow_data_fil = zeros(size(flow_data));
% for i = 1 : n_line
%     flow_data_fil(:,i) = bandpass(flow_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
% end
% 
% % try to infer line flow from frequency
% flow_resp = zeros(size(flow_data_fil));
% flow_resp_diff = zeros(size(flow_data_fil));
% n = size(flow_data_fil,1);
% input_loc = 1;
% for i = 1 : n_line
%     % cross-correlation
%     temp = xcorr(flow_data_fil(:,i),freq_data_fil(:,input_loc));
%     temp = temp(n:end);
%     % taking derivative
%     len_crr = length(temp)-1;
%     temp1 = zeros(len_crr,1);
%     for k = 1 : len_crr
%         temp1(k) = (temp(k+1) - temp(k)) ./ dt;
%     end
%     % normalization
% %     temp1 = temp1 ./ max(temp1);
%     flow_resp(:,i) = temp;
%     flow_resp_diff(2:end,i) = temp1;
%     flow_resp_diff(1,i) = temp1(1);
% end
% 
% % Load impulse response data
% load data/impz_resp_2nd_nonunif_power.mat % impulse response w/ input@1st generator
% psat_temp = Varout;
% % Time span for prediction
% t_range = 5;
% T2 = 0 : dt : t_range;
% plot_idx = 1 : length(T2);
% 
% [freq_impz,angle_impz,flow_impz,t_psat] = psat_data_process(psat_temp,t_range,dt);
% 
% % plot
% 
% fig3 = figure('DefaultAxesFontSize',18);
% line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
% flow_impz1 = flow_impz .* 100; % power rating
% for i  = 1 : n_line
%     subplot(3,3,i)
%     flow_resp_temp = (flow_resp(plot_idx,i)-flow_resp(plot_idx(1),i));
%     flow_resp_temp = flow_resp_temp ./ .1;
%     plot(t_psat,flow_impz1(:,i)-flow_impz1(1,i),'-.',T2,flow_resp_temp,'-','LineWidth',2);
%     xlabel('Time [s]');
%     ylabel('Power dev. [MW]');
%     xlim([0 t_range]);
%     title(strcat('line ',line_idx(i)));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
% %     title('Input: \omega_2')
%     grid on
% end
% sgt = sgtitle('Line response from freq - w/out diff');
% sgt.FontSize = 32;
% set(fig3,'Position',[10 500 1500 1200])
% 
% fig4 = figure('DefaultAxesFontSize',18);
% line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
% flow_impz1 = flow_impz .* 100; % power rating
% for i  = 1 : n_line
%     subplot(3,3,i)
%     flow_resp_diff_temp = (flow_resp_diff(plot_idx,i)-flow_resp_diff(plot_idx(1),i));
%     flow_resp_diff_temp = flow_resp_diff_temp ./ .1;
%     plot(t_psat,flow_impz1(:,i)-flow_impz1(1,i),'-.',T2,flow_resp_diff_temp,'-','LineWidth',2);
%     xlabel('Time [s]');
%     ylabel('Power dev. [MW]');
%     xlim([0 t_range]);
%     title(strcat('line ',line_idx(i)));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
% %     title('Input: \omega_2')
%     grid on
% end
% sgt = sgtitle('Line response from freq - diff');
% sgt.FontSize = 32;
% set(fig4,'Position',[10 500 1500 1200])




% fig0 = figure('DefaultAxesFontSize',18);
% for i = 1 : 3
%     subplot(1,3,i)
%     plot(T1,freq_data(:,i)-freq_data(1,i),'-',T1,freq_data_fil(:,i),'-','LineWidth',2);
%     legend('original frequency data','filtered frequency data','Location','best');
%     title(strcat('\omega ',num2str(i)));
%     grid on
% end
% sgt = sgtitle('Filter: 2nd order, non-uniform damping, input1(initial removed)');
% sgt.FontSize = 32;
% set(fig0,'Position',[10 10 1500 400])
% 
% fig1 = figure('DefaultAxesFontSize',18);
% for i = 1 : 3
%     subplot(1,3,i)
%     plot(T1,angle_data(:,i),'-',T1,ang_data_fil(:,i),'-','LineWidth',2);
%     legend('original angle data','filtered angle data','Location','best');
%     title(strcat('\delta ',num2str(i)));
%     grid on
% end
% sgt = sgtitle('Filter: 2nd order, non-uniform damping, input1');
% sgt.FontSize = 32;
% set(fig1,'Position',[10 10 1500 400])
% 
% fig2 = figure('DefaultAxesFontSize',18);
% line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
% for i = 1 : 9
%     subplot(3,3,i)
%     plot(T1,flow_data(:,i)-flow_data(1,i),'-',T1,flow_data_fil(:,i),'-','LineWidth',2);
% %     legend('original angle data','filtered angle data','Location','best');
%     title(strcat('line ',line_idx(i)));
%     if i == 1
%         legend('original flow data','filtered flow data','Location','best');
%     end
%     grid on
% end
% sgt = sgtitle('Filter: 2nd order, non-uniform damping, input1 (initial removed)');
% sgt.FontSize = 32;
% set(fig2,'Position',[10 10 1500 1200])




%% plot

% fig1 = figure('DefaultAxesFontSize',18);
% freq_resp2 = freq_resp1;
% for i = 1 : 3
%     if i ~= 1
% %         freq_resp2(:,i) = freq_resp2(:,i) - freq_resp2(1,i);
%     end
%     freq_resp2(:,i) = freq_resp2(:,i)./max(abs(freq_resp2(:,i)));
%     subplot(1,3,i)
%     plot(t_psat,freq_impz(:,i),'-.',T2,freq_resp2(plot_idx,i),'-','LineWidth',2);
%     xlabel('Time [s]');
%     ylabel('scale');
%     xlim([0 t_range]);
%     title(strcat('\omega ',num2str(i)));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
% %     title('Input: \omega_1')
%     grid on
% end
% sgt = sgtitle('Frequency response: 2nd order, non-uniform damping, input1');
% sgt.FontSize = 32;
% set(fig1,'Position',[10 10 1500 400])
% 
% % Rotor angle
% fig2 = figure('DefaultAxesFontSize',18);
% for i = 1 : n_gen
%     subplot(1,3,i)
%     plot(t_psat,angle_impz(:,i),'-.',T2,ang_resp1(plot_idx,i) ./ (-40),'-','LineWidth',2); %T1,freq_resp1(:,i),'-',
%     xlabel('Time [s]');
%     ylabel('scale');
%     xlim([0 t_range]);
%     title(strcat('\delta ',num2str(i)));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
% %     title('Input: \omega_1')
%     grid on
% end
% sgt = sgtitle('Rotor angle response: 2nd order, non-uniform damping, input1 ');
% sgt.FontSize = 32;
% set(fig2,'Position',[10 200 1500 400])
% 
% % Line flow
% fig3 = figure('DefaultAxesFontSize',18);
% line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
% flow_impz1 = flow_impz .* 100; % power rating
% for i  = 1 : n_line
%     subplot(3,3,i)
%     flow_resp_temp = - (flow_resp(plot_idx,i)-flow_resp(plot_idx(1),i));
%     flow_resp_temp = flow_resp_temp ./ .05;
%     plot(t_psat,flow_impz1(:,i)-flow_impz1(1,i),'-.',T2,flow_resp_temp,'-','LineWidth',2);
%     xlabel('Time [s]');
%     ylabel('Power dev. [MW]');
%     xlim([0 t_range]);
%     title(strcat('line ',line_idx(i)));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
% %     title('Input: \omega_2')
%     grid on
% end
% sgt = sgtitle('Line response: 2nd order, non-uniform damping, input1');
% sgt.FontSize = 32;
% set(fig3,'Position',[10 500 1500 1200])