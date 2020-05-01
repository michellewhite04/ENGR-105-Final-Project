function circuit_example(x, y, cx, cy, node_table, path_table, iteration)
path_color = cell(6,1);
node_color = cell(6,1);



for i=1:6
    if path_table{i,2} == 1 % idle
        path_color{i,1} = [0, 0, 0]; % black
    elseif path_table{i,2} == 2 % ante conduction
        path_color{i,1} = [0, 1, 0]; % green
    elseif path_table{i,2} == 3 % retro conduction
        path_color{i,1} = [0, 0, 1]; % blue
    elseif path_table{i,2} == 4 % temp (rare)
        path_color{i,1} = [1, 0, 0]; % red
    elseif path_table{i,2} == 5 % crash
        path_color{i,1} = [0.9290, 0.6940, 0.1250]; % orange
    end
end

for i = 1:6
    line(x{i}, y{i}, 'color', path_color{i}, 'linewidth', 3);
    hold on;
end

for i=1:6
    if node_table{i,9} == 1 && node_table{i,2} == 2 % activated & refractory
        node_color{i,1} = [0.9290, 0.6940, 0.1250]; % orange
    elseif node_table{i,9} == 0 && node_table{i,2} == 2 % refractory
        node_color{i,1} = [1, 0, 0]; % red
    elseif node_table{i,9} == 0 && node_table{i,2} == 1 % ready to conduct
        node_color{i,1} = [0, 0, 0]; % black
    elseif node_table{i,9} == 1 && node_table{i,2} == 1 % activated & ready to conduct
        node_color{i,1} = [0, 1, 0]; %green
    end
end

for i = 1:6
    scatter(cx(i), cy(i), 120, node_color{i}, 'filled');
    hold on;
end
title(['Iteration: ', num2str(iteration)])
drawnow
hold on;


