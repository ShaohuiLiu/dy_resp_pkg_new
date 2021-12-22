function pert_impulse(t)

global  Syn  Syn1 %DAE (global variable, required by PSAT)


%% Test of impulse

% if t >= 1 && t < 1.01
% %     impulse = D * ones(dim,1);
%     impulse1 = zeros(dim,1);
%     impulse1(1) = .001;
%     PQ1 = PQ;
%     PQ.con(:,4) = PQ.con(:,4) + impulse1;
%     disp('load perturbation time:');
%     disp(t);
% elseif t>= 1.01 && t < 1.02
%     PQ = PQ1;
%     disp('perturbation restore time:');
%     disp(t);
% end
% 

t_stop = 1.0025; % 2nd order
% t_stop = 1.005; % 6th order
if t >= 1.00 && t <= t_stop % 1.001
    
    dim = size(Syn.pm0,1);
    disp('Initial mechanical power:');
    disp(Syn.pm0);
    input = zeros(dim,1);
    loc = 2; % input location
%     input(loc,1) = Syn1.pm0(loc,1) * 1.2;
    if Syn1.pm0(loc,1) >0
        input(loc,1) = Syn1.pm0(loc,1) * 1.2;
    else
        disp('Init. mech. pow. 0, use max.');
        input(loc,1) = max(Syn1.pm0(:,1)) * 1.2;
    end

    Syn.pm0 = Syn1.pm0 + input;
    fprintf('Impulse injected in generator %d at %f s. \n',loc,t);
    disp('Perturbed mechanical power:');
    disp(Syn.pm0);
elseif t <= 0.99
    Syn1 = Syn; % initial
elseif t>= t_stop +0.001 && t<= 1.019 % restore
% elseif t>= t_stop +0.0001 && t<= 1 + 2*(t_stop-1) % restore    
% elseif t>= t_stop +0.0001 && t<= 1.019
%     PQ1 = PQ;
    Syn = Syn1;
    fprintf('Impulse ended at %f s. \n',t);
end


% if t > 0.5
% %     DAE.x = DAE.x + 0.01;
%     dim = size(PQ.con,1);
%     disp(t);
%     
%     alpha = 2e-7; % Scaling coeff
%     gamma = 0.2 * 12.80; % Uniform Damping
% %     gamma_v = gamma * eye(dim); 
%     
%     mu = zeros(dim,1);
%     Sigma = alpha .* gamma .* ones(dim,1);
%     
%     
% %     rng('shuffle');
%     noise = normrnd(mu,Sigma);
% %     disp(noise);
% %     pause
%     
% %     if max(abs(DAE.x + 1 .* noise)) < 2
% %         disp(noise);
%     PQ.con(:,4) = PQ.con(:,4) + 1 .* noise;
% %     end
% 
%     pert_cont = pert_cont + 1;
%         
%     
% else
% %     disp(t,'no pertub.')
% %     pause
%     
%     dim = size(PQ.con,1);
%     
%     alpha = 0.12*0.1; % Scaling coeff
%     gamma = 0.2 * 12.80; % Uniform Damping
% %     gamma_v = gamma * eye(dim); 
%     
%     mu = zeros(dim,1);
%     Sigma = alpha .* gamma .* ones(dim,1);
%     
%     
% %     rng('shuffle');
%     noise = normrnd(mu,Sigma);
% %     disp(noise);
% %     pause
%     
% %     if max(abs(DAE.x + 1 .* noise)) < 2
% %         disp(noise);
%     PQ.con(:,4) = PQ.con(:,4);
% end




end