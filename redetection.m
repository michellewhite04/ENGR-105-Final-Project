case 2 % redetection
            if ATP_table{1} == 1
                % if another tachycardia beat is detected and redection hasn't
                % yet happened twice
                if cycle_length > 0
                    if ATP_table{8} < 3
                        CL_window = cell2mat(ATP_table(12));
                        ATP_table{12} = [CL_window(2), cycle_length]; % shift window
                        binary_store = ATP_table{12} < cell2mat(ATP_table(16));
                        added = sum(binary_store);
                        ATP_table{13} = ATP_table{13} + added; % update detection sum
                        ATP_table{8} = ATP_table{8} + 1; % increment detection counter
                    else
                        
                        
                        if ATP_table{10} >= 4 % minimum sum for 2/3 threshold
                            if ATP_table{14} < ATP_table{15}
                                decision_apply = true;
                                ATP_table{8} = 0;
                                ATP_table{12} = [inf, inf];
                                ATP_table{13} = 0;
                                ATP_table{14} = ATP_table{14} + 1;
                            else
                                ATP_table{7} = 3;
                            end
                            
                            
                        else
                            ATP_table{7} = 1;
                            decision_termination = true;
                            
                            % still reset values
                            ATP_table{8} = 0;
                            ATP_table{12} = [inf, inf];
                            ATP_table{13} = 0;
                            ATP_table{14} = 0; % up to 2 more redetections possible
                        end
                        
                    end
                end
            end
            
     