clear
clc
close all

create_scenarios;


premature = zeros(1,4000); % for graphing premature impulse
impulse = zeros(1,4000);  % for graphing ATP impulses
node_1_tracker = zeros(1,4000);
CL_tracker = zeros(1,4000);
RCL_tracker = zeros(1,4000);


t=1;
CL_counter = 0; % initialize outside of loop
cycle_length = 0; % initialize outside of loop
RCL_counter = 0;
RCL = 0;
VTCL = 0;

% coordinates of paths
x = {[0, -sqrt(3)/2]; % SPA
     [-sqrt(3)/2, -sqrt(3)/2]; % SPB
     [-sqrt(3)/2, 0]; % SPC
     [sqrt(3)/2, 0]; % FPA
     [sqrt(3)/2, sqrt(3)/2]; % FPB
     [0, sqrt(3)/2]}; % FPC
 
y = {[1, 1/2]; % SPA
     [1/2, -1/2]; % SPB
     [-1/2, -1]; % SPC
     [1/2, 1]; % FPA
     [-1/2, 1/2]; % FPB
     [-1, -1/2]}; % FPC
 
% x and y coords of node centers
cx = [0, -sqrt(3)/2, -sqrt(3)/2, 0, sqrt(3)/2, sqrt(3)/2];
cy = [1, 1/2, -1/2, -1, -1/2, 1/2];
 
 % Running the model
 while t<=4000
     
        % Heart Model
        [node_table,path_table]=heart_model(node_table,path_table);
        
        % first impulse
        %120 initiates tachicardia
        if t==120
            node_table{1,9} = 1;
            premature(t) = 1;
        end
        
        if t==1000
            a = 1;
        end
        
% %       manually initiate DWR
%          if t == 5880
%            node_table{1,9} = 1;
%            premature(t) = 1;
%              if node_table{6,2} == 1
%                  node_table{6,3} = 110;
%                  node_table{6,4} = 110;
%              else 
%                  node_table{6,4} = 110;
%              end
%         end

        if cycle_length > 0
            if ATP_table{1} == 1
                VTCL = cycle_length;
            end
        end
        
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
     
        [node_table, ATP_table, RCL, RCL_counter] = AATP(node_table, ATP_table, RCL, RCL_counter, VTCL);
        impulse(t) = ATP_table{6};
        RCL_tracker(t) = RCL;
      
        [ATP_table] = detection(t, cycle_length, ATP_table);
       
     
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Everything below this line must come after calling ATP.m
     
        cycle_length = 0;
     
        if node_table{1,9} == 1
            cycle_length = CL_counter;
            CL_counter = 0;
        else
            CL_counter = CL_counter + 1;
        end
        
        CL_tracker(t) = cycle_length;
        node_1_tracker(t) = node_table{1,9};
     
     
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
        % recording path impulses
        % activation of exit node = antegrade cond
        % activation of entry node = retrograde cond
        
        SPA_ante(t) = path_table{1,15};
        SPA_retro(t) = path_table{1,14};
        SPB_ante(t) = path_table{2,15}; 
        SPB_retro(t) = path_table{2,14}; 
        SPC_ante(t) = path_table{3,15}; 
        SPC_retro(t) = path_table{3,14}; 
        FPA_ante(t) = path_table{6,15}; 
        FPA_retro(t) = path_table{6,14}; 
        FPB_ante(t) = path_table{5,15}; 
        FPB_retro(t) = path_table{5,14}; 
        FPC_ante(t) = path_table{4,15}; 
        FPC_retro(t) = path_table{4,14}; 
        int_ante(t) = path_table{7,15};
        int_retro(t) = path_table{7,14};
    
        % Circuit Image
        %circuit_example(x, y, cx, cy, node_table, path_table, t);
        
     t=t+1;
     
 end

subplot(4,1,1)
plot(impulse)
title('ATP Impulse')

subplot(4,1,2)
plot(premature)
title('Premature Impulse')

% subplot(5,1,2)
% plot(int_ante)
% title('Intervening Ante')

% subplot(5,1,3)
% plot(int_retro)
% title('Intervening Retro')

% subplot(7,1,3)
% plot(node_1_tracker)
% title('Node 1 Tracker')

subplot(4,1,3)
plot(SPA_ante)
title('SPA-A')
% 
% subplot(4,1,3)
% plot(SPA_ante)
% title('SPA-A')
%  
% subplot(6,1,2)
% plot(SPB_ante)
% title('SPB-A')
% 
% subplot(6,1,3)
% plot(SPC_ante)
% title('SPC-A')
 
% subplot(6,1,4)
% plot(FPC_retro)
% title('FPC-R')
% 
% subplot(6,1,5)
% plot(FPB_retro)
% title('FPB-R')

subplot(4,1,4)
plot(FPA_retro)
title('FPA-R')

% subplot(4,1,4)
% plot(FPA_retro)
% title('FPA-R')

% subplot(4,1,4)
% plot(FPC_ante)
% title('FPC-A')

% plot(CL_tracker)
% plot(RCL_tracker)


 