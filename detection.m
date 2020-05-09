function [ATP_table] = detection(t, cycle_length, ATP_table)

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

    switch ATP_table{7}
        
        case 1 % detection
            % VT detection
            if ATP_table{1} == 1
                if cycle_length > 0
                    if ATP_table{8} < ATP_table{9}
                        CL_window = cell2mat(ATP_table(12));
                        ATP_table{12} = [CL_window(2), cycle_length]; % shift window
                        sum_VT = 0;
                        conditional = cell2mat(ATP_table(12));
                        for i=1:2
                            if conditional(i) < ATP_table{17} && conditional(i) > ATP_table{18}
                                sum_VT = sum_VT + 1;
                            end
                        end
                        ATP_table{13} = ATP_table{13} + sum_VT; % update detection sum
                        
                        binary_store_FVT = ATP_table{12} < cell2mat(ATP_table(18));
                        sum_FVT = sum(binary_store_FVT);
                        ATP_table{14} = ATP_table{14} + sum_FVT; % update detection sum
                        
                        ATP_table{8} = ATP_table{8} + 1; % increment detection counter
                        
                    else
                        if ATP_table{13} >= ((ATP_table{9}*2) - 1) || ATP_table{14} >= ((ATP_table{11}*2) - 1) % sum for 16 consecutive beats
                            
                            ATP_table{22} = 1; % apply AATP

                            % reset values after application
                            ATP_table{8} = 0;
                            ATP_table{12} = [inf, inf];
                            ATP_table{13} = 0;
                            ATP_table{14} = 0;
                            S = 'badsong_48kHz.mp3';
                            sound(S.y,S.Fs)
                        else

                            ATP_table{23} = 1; % don't apply AATP

                            % still reset values
                            ATP_table{8} = 0;
                            ATP_table{12} = [inf, inf];
                            ATP_table{13} = 0;
                            ATP_table{14} = 0;
                        end
                    end
                end
            end
            
        case 3 % SHOCK
            a = 1;
    end