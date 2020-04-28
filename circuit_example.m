function circuit_example(node_table, path_table)
x = cell(6,1);
y = cell(6,1);
c = cell(6,1);
path_color = cell(6,1);
node_color = cell(6,1);

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

for i=1:6
    if path_table{i,2} == 1 % idle
        path_color{i,1} = [0, 0, 0]; % black
    end
    if path_table{i,2} == 2 % ante conduction
        path_color{i,1} = [0, 1, 0]; % green
    end
    if path_table{i,2} == 3 % retro conduction
        path_color{i,1} = [0, 0, 1]; % blue
    end
    if path_table{i,2} == 4 % temp (rare)
        path_color{i,1} = [1, 0, 0]; % red
    end
    if path_table{i,2} == 5 % crash
        path_color{i,1} = [0.9290, 0.6940, 0.1250]; % orange
    end
end

figure
for i=1:6
    line(x{i},y{i},'color',path_color{i},'linewidth',3);
end

c = {[0, 1]; 
     [-sqrt(3)/2, 1/2];
     [-sqrt(3)/2, -1/2];
     [0, -1];
     [sqrt(3)/2, -1/2];
     [sqrt(3)/2, 1/2]};
 
r = 1/32;

for i=1:6
    if node_table{i,9} == 1 && node_table{i,2} == 2 % activated & refractory
        node_color{i,1} = [0.9290, 0.6940, 0.1250]; % orange
    end
    if node_table{i,9} == 0 && node_table{i,2} == 2 % refractory
        node_color{i,1} = [1, 0, 0]; % red
    end
    if node_table{i,9} == 0 && node_table{i,2} == 1 % ready to conduct
        node_color{i,1} = [0, 0, 0]; % black
    end
    if node_table{i,9} == 1 && node_table{i,2} == 1 % activated & ready to conduct
        node_color{i,1} = [0, 1, 0]; %green
    end
end

a = 2;

hold on;
for i=1:6
    viscircles(c{i}, r,'color',node_color{i},'linewidth',32);
end


