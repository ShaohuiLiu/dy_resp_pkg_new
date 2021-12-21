
fig3 = figure('DefaultAxesFontSize',18);
% frequency
for i = 1 : 3
    if i ~= 1
        freq_resp2(:,i) = freq_resp2(:,i) - freq_resp2(1,i);
    end
    freq_resp2(:,i) = freq_resp2(:,i)./max(abs(freq_resp2(:,i)));
    subplot(3,3,i)
    plot(t_psat,freq_impz(:,i),'-.',T2,freq_resp2(plot_idx,i),'-','LineWidth',2);
%     xlabel('Time [s]');
    ylabel('scale');
    xlim([0 t_range]);
    title(strcat('\omega ',num2str(i)));
    if i == 1
        legend('model based','data driven','Location','best');
    end
%     title('Input: \omega_1')
    grid on
end
% angle
for i = 1 : n_gen
    subplot(3,3,i+3)
    plot(t_psat,angle_impz(:,i),'-.',T2,ang_resp1(plot_idx,i) ./ (-40),'-','LineWidth',2); %T1,freq_resp1(:,i),'-',
%     xlabel('Time [s]');
    ylabel('scale');
    xlim([0 t_range]);
    title(strcat('\delta ',num2str(i)));
    grid on
end
% line flow
line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
flow_impz1 = flow_impz .* 100; % power rating
p_idx = [1 2 7];
for j  = 1 : 3
    subplot(3,3,j+6)
    i = p_idx(j);
    flow_resp_temp = - (flow_resp(plot_idx,i)-flow_resp(plot_idx(1),i));
    flow_resp_temp = flow_resp_temp ./ 15;
    plot(t_psat,flow_impz1(:,i)-flow_impz1(1,i),'-.',T2,flow_resp_temp,'-','LineWidth',2);
    xlabel('Time [s]');
    ylabel('Power dev. [MW]');
    xlim([0 t_range]);
    title(strcat('line ',line_idx(i)));
%     if i == 1
%         legend('model based','data driven','Location','best');
%     end
%     title('Input: \omega_2')
    grid on
end
% sgt = sgtitle('Line response: 2nd order, non-uniform damping, input1');
% sgt.FontSize = 32;
set(fig3,'Position',[10 10 1500 1000])


% n_gen = 3;
% ang_resp = cell(n_gen,1);
% n = size(angle_data,1);
% 
% % filter the ambient data using bandpass filter
% for i = 1 : n_gen
%     ang_data(:,i) = bandpass(angle_data(:,i),[0.001 200],round(1/dt)); % round(1/dt)
% end
% 
% for i = 1 : n_gen
%     resp = zeros(n,n_gen);
%     for j = 1 : n_gen
%         % cross-correlation
%         temp = xcorr(ang_data(:,i),ang_data(:,j));
%         temp = temp(n:end);
%         % taking derivative
%         len_crr = length(temp)-1;
%         temp1 = zeros(len_crr,1);
%         for k = 1 : len_crr
%             temp1(k) = (temp(k+1) - temp(k)) ./ dt;
%         end
%         % normalization
%         temp1 = temp1 ./ max(temp1);
%         resp(2:end,j) = temp1;
%         resp(1,j) = temp1(1);
%     end
%     ang_resp{i} = resp;
% end

% %% Frequency-Angle Correlation
% freq_ang_xcorr = zeros(n,3);
% freq_ang_xcorr_diff = zeros(n,3);
% 
% 
% for i = 1 : 3
%     % cross-correlation
%     temp = xcorr(ang_data_fil(:,i),freq_data_fil(:,input_loc));
%     temp = temp(n:end);
%     % taking derivative
%     len_crr = length(temp)-1;
%     temp1 = zeros(len_crr,1);
%     for k = 1 : len_crr
%         temp1(k) = (temp(k+1) - temp(k)) ./ dt;
%     end
%     freq_ang_xcorr(:,i) = temp;
%     freq_ang_xcorr_diff(2:end,i) = temp1;
%     freq_ang_xcorr_diff(1,i) = temp1(1);
% end
% 
% fig3 = figure('DefaultAxesFontSize',18);
% 
% for i = 1 : 3
%     subplot(2,3,i)
%     plot(T2,freq_ang_xcorr(plot_idx,i),'LineWidth',2);
%     title(strcat('\delta ',i));
%     grid on;
%     subplot(2,3,i+3)
%     plot(T2,freq_ang_xcorr_diff(plot_idx,i),'LineWidth',2);
%     title(strcat('\omega ',i));
%     grid on;
% end
% sgt = sgtitle('Freq-Ang Xcorr');
% sgt.FontSize = 32;
% set(fig3,'Position',[10 500 1500 800])


% fig3 = figure('DefaultAxesFontSize',18);
% line_idx = ["9-8", "7-8", "9-6", "7-5", "5-4", "6-4", "2-7", "3-9", "1-4"];
% flow_impz1 = flow_impz .* 100; % power rating
% for i  = 1 : n_line
%     subplot(3,3,i)
%     flow_resp_temp = (flow_resp(plot_idx,i)-flow_resp(plot_idx(1),i));
%     flow_resp_temp = flow_resp_temp ./ .2;
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
