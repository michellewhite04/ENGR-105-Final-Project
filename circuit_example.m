function circuit_example(x, y, cx, cy, node_table, path_table, iteration, imdata, crash)
node_color = cell(6,1);

state = zeros(1,6); % to store the current state of each path

for i=1:6
    if path_table{i,2} == 1 % idle
        state(i) = 0; % do nothing
    elseif path_table{i,2} == 2 % ante conduction
        state(i) = 1;
    elseif path_table{i,2} == 3 % retro conduction
        state(i) = 2;
    elseif path_table{i,2} == 4 % temp (rare)
        state(i) = 3;
    elseif path_table{i,2} == 5 % double
        state(i) = 4;
    end
end

% for i=1:6
%     if path_table{i,2} == 1 % idle
%         path_color{i,1} = [0, 0, 0]; % black
%     elseif path_table{i,2} == 2 % ante conduction
%         path_color{i,1} = [0, 1, 0]; % green
%     elseif path_table{i,2} == 3 % retro conduction
%         path_color{i,1} = [0, 0, 1]; % blue
%     elseif path_table{i,2} == 4 % temp (rare)
%         path_color{i,1} = [1, 0, 0]; % red
%     elseif path_table{i,2} == 5 % crash
%         path_color{i,1} = [0.9290, 0.6940, 0.1250]; % orange
%     end
% end

a = 1;
b = 2;
for i = 1:6
    if state(i) == 1 % antegrade conduction
        xi = linspace(x{i}(a), x{i}(b), 10000); 
        yi = linspace(y{i}(a), y{i}(b), 10000); 
        difference = length(xi) / path_table{i,9};
        increment = difference * (path_table{i,9} - path_table{i,8});
        if increment == 0
            increment = 1;
        end
        c = linspace(0, 1, increment);
        
        scatter(xi(increment+1:end), yi(increment+1:end), [], 'k', 'filled');
        scatter(xi(1:increment), yi(1:increment), [], c, 'filled');
     
    elseif state(i) == 2 % retrograde conduction
        xi = linspace(x{i}(b), x{i}(a), 10000); 
        yi = linspace(y{i}(b), y{i}(a), 10000); 
        difference = length(xi) / path_table{i,11};
        increment = difference * (path_table{i,11} - path_table{i,10});
        if increment == 0
            increment = 1;
        end
        c = linspace(0, 1, increment);
        
        scatter(xi(increment+1:end), yi(increment+1:end), [], 'k', 'filled');
        scatter(xi(1:increment), yi(1:increment), [], c, 'filled');
        
    elseif state(i) == 3 || state(i) == 0 % idle or temp (rare)
        xi = linspace(x{i}(a), x{i}(b), 10000); 
        yi = linspace(y{i}(a), y{i}(b), 10000);
        
        if crash(i) == 1
            scatter(xi, yi, [], 'r', 'filled');
        else
            scatter(xi, yi, [], 'k', 'filled');
        end
        
    elseif state(i) == 4
        
        xi = linspace(x{i}(a), x{i}(b), 10000);
        yi = linspace(y{i}(a), y{i}(b), 10000);
        differenceAnte = length(xi) / path_table{i,9};
        differenceRetro = length(xi) / path_table{i,11};
        incrementAnte = differenceAnte * (path_table{i,9} - path_table{i,8});
        incrementRetro = differenceRetro * (path_table{i,11} - path_table{i,10});
        if incrementAnte == 0
            incrementAnte = 1;
        end
        
        cA = linspace(0, 1, incrementAnte);
        cR = linspace(1, 0, incrementRetro + 1);
        
        scatter(xi(incrementAnte+1:end-incrementRetro-1), yi(incrementAnte+1:end-incrementRetro-1), [], 'k', 'filled');
        scatter(xi(1:incrementAnte), yi(1:incrementAnte), [], cA, 'filled');
        scatter(xi(end-incrementRetro:end), yi(end-incrementRetro:end), [], cR, 'filled');
        
    end
    
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
    scatter(cx(i), cy(i), 150, node_color{i}, 'filled');
    hold on;
end
title(['Iteration: ', num2str(iteration)])

hold on 
h = image(2*xlim,2*flip(ylim),imdata); 
uistack(h,'bottom')

axis tight
set(gca,'XTick',[], 'YTick', [])

drawnow
cla

end


