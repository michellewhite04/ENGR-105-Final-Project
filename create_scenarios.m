clear
clc
close all

% node_table: Cell array, each row contains parameters for one node
%
%    format: {'node name', node_state_index, TERP_current,
%            TERP_default, TRRP_current, TRRP_default, Trest_current,
%            Trest_default, node_activation,[Terp_min,Terp_max],
%            index_of_path_activate_the_node, CL_counter_state} 
%
% path_table: Cell array, each row contains parameters for one path
%
%    format: {'path_name',path_state_index, entry_node_index,
%            exit_node_index, amplitude_factor, forward_speed,
%            backward_speed, forward_timer_current, forward_timer_default,
%            backward_timer_current, backward_timer_default, path_length,
%            path_slope, entry_node_activation, exit_node_activation}
%
% ATP_table: 
%
% format: {ATP_state_index, impulse_counter_cur, impulse_counter_def, 
%          waiting_cur, waiting_def, impulse_value, detection_state, 
%          detection_counter_VT, detection_counter_VT_max,
%          detection_counter_FVT, detection_counter_FVT_max, CL_window, 
%          detection_sum_VT, detection_sum_FVT,
%          redection_counter_cur, redetection_counter_def,
%          threshold_VT_max, threshold_VT/FVT, ES_cur, ES_def,
%          ES_waiting, decision_apply, decision_termination}

%create tables for reentry
node_table=cell(7,13);
path_table=cell(7,15);

%initialize tables
node_table = {
    'One', 1, 1, 1, 0, 0, 100, 100, 1, 0, 0, 0, 0;
    'Two', 1, 8, 8, 0, 0, inf, inf, 0, 0, 0, 0, 0;
    'Three', 1, 8, 8, 0, 0, inf, inf, 0, 0, 0, 0, 0;
    'Four', 1, 1, 1, 0, 0, inf, inf, 0, 0, 0, 0, 0;
    'Five', 1, 11, 11, 0, 0, inf, inf, 0, 0, 0, 0, 0;
    'Six', 1, 32, 32, 0, 0, inf, inf, 0, 0, 0, 0, 0;
    'begin', 1, 1, 1, 0, 0, inf, inf, 0, 0, 0, 0, 0};




path_table = {
    'SPA', 1, 1, 2, 0, 0, 0, 7, 7, 7, 7, 0, 0, 0, 0;
    'SPB', 1, 2, 3, 0, 0, 0, 7, 7, 7, 7, 0, 0, 0, 0;
    'SPC', 1, 3, 4, 0, 0, 0, 7, 7, 7, 7, 0, 0, 0, 0;
    'FPA', 1, 1, 6, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0;
    'FPB', 1, 6, 5, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0;
    'FPC', 1, 5, 4, 0, 0, 0, 5, 5, 5, 5, 0, 0, 0, 0;
    'intervening', 1, 7, 1, 0, 0, 0, 30, 30, 30, 30, 0, 0, 0, 0};

% ATP
ATP_table = cell(1,23);

%intitialize ATP table
%set ATP_table{11} = ATP_table{12} if you don't want redetection
%be sure to set ATP_table{4} = ATP_table{5} from start

%ATP_table = {1, 0, 7, 25, 25, 0, 1, 0, 10, 0, 10, [inf,inf], 0, 0, 2, 2, 60, 32, 0, 0, 6, 0, 0};
ATP_table = {1, 0, 7, 33, 33, 0, 1, 0, 12, 0, 12, [inf,inf], 0, 0, 2, 2, 60, 32, 0, 0, 6, 0, 0};

%save mat structure
save('reentry.mat', 'node_table', 'path_table');
save('AATP.mat', 'ATP_table');