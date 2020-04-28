function [node_table, ATP_table, RCL, RCL_counter] = AATP(node_table, ATP_table, RCL, RCL_counter, VTCL)          

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% format: {ATP_state_index, impulse_counter_cur, impulse_counter_def, 
%          waiting_cur, waiting_def, impulse_value, detection_state, 
%          detection_counter_VT, detection_counter_VT_max,
%          detection_counter_FVT, detection_counter_FVT_max, CL_window, 
%          detection_sum_VT, detection_sum_FVT,
%          redection_counter_cur, redetection_counter_def,
%          threshold_VT_max, threshold_VT/FVT, ES_def,
%          decision_apply, decision_termination}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
    ATP_table{6} = 0; % for graphing purposes
    
    % decision_termination preceds all: don't want to reinitiate tachy
    if ATP_table{23}
        ATP_table{1} = 1;
        ATP_table{23} = 0; % reset boolean
    end

    switch ATP_table{1}
        
        case 1 % idle
            if ATP_table{22}
                ATP_table{1} = 2;
                ATP_table{22} = 0; % reset boolean
            end
            
        case 2 % apply
            if ATP_table{2} < ATP_table{3}
                if ATP_table{2} == ATP_table{3} - 1
                     node_table{1,9} = 1;
                     ATP_table{6} = 1;
                     ATP_table{2} = ATP_table{2} + 1;
                     ATP_table{4} = ATP_table{21};
                     ATP_table{1} = 3; % change state to waiting
                     
                     % to allow double-wave reentry
                     if node_table{6,2} == 1
                        node_table{6,3} = 110;
                        node_table{6,4} = 110;
                     else 
                        node_table{6,4} = 110;
                     end
                     
                else
                    node_table{1,9} = 1; % activate node_1
                    ATP_table{6} = 1; % for graphing purposes
                    ATP_table{2} = ATP_table{2} + 1;
                    ATP_table{1} = 3; % change state to waiting
                end
            else
                if ATP_table{19} < ATP_table{20}
                    node_table{1,9} = 1; % activate node_1
                    ATP_table{6} = 1; % for graphing purposes
                    ATP_table{19} = ATP_table{19} + 1;
                    ATP_table{4} = ATP_table{21}; % ********************************
                    ATP_table{1} = 3;
                else
                    ATP_table{1} = 4;
                    ATP_table{4} = ATP_table{5};
                    ATP_table{2} = 0; % reset train counter
                    ATP_table{19} = 0;
                end
            end
            
        case 3 % train waiting
                if ATP_table{4} == 0 % for train
                    ATP_table{1} = 2; % change states when timer runs out
                    ATP_table{4} = ATP_table{5};
                else
                    % otherwise decrement waiting counter
                    ATP_table{4} = ATP_table{4} - 1;
                end
            
        case 4 % read RCL
            RCL = 0;
            
            if node_table{1,9} == 1
                RCL = RCL_counter;
                RCL_counter = 0;
            else
                RCL_counter = RCL_counter + 1;
            end

            margin = ATP_table{21} + 5; %*******************************
            if RCL > 0
                if RCL <= VTCL + margin && RCL >= VTCL - margin %reset
                    if ATP_table{20} < 2
                        ATP_table{20} = ATP_table{20} + 1;
                        ATP_table{1} = 2;
                    else 
                        ATP_table{1} = 2;
                    end
                end
                if RCL > VTCL + margin %termination
                    ATP_table{1} = 1;
                    ATP_table{20} = 0;
                end
                 if RCL < VTCL - margin %LOC
                     if ATP_table{20} == 0
%                        ATP_table{3} = ceil(abs(((RCL - VTCL)/(VTCL - ATP_table{5})))) + 1; % set according to Kaiser eqn
                        ATP_table{5} = ATP_table{5} + 70;
                        ATP_table{1} = 2;
                     else
%                         ATP_table{21} = ATP_table{21} - 10;
                        ATP_table{5} = ATP_table{5} + 70;
                        ATP_table{1} = 2;
                        
                     end
                end
            end  
    end
end

   