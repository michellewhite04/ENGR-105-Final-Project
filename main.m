function main(node_table, path_table, ATP_table, realTimeVis, videoTitle)
% realTimeVis is a boolean

premature = zeros(1,4000); % for graphing premature impulse
impulse = zeros(1,4000);  % for graphing ATP impulses
node_1_tracker = zeros(1,4000);
CL_tracker = zeros(1,4000);
RCL_tracker = zeros(1,4000);
SPA_ante = zeros(1,4000);
SPA_retro = zeros(1,4000);
FPC_ante = zeros(1,4000); 
FPC_retro = zeros(1,4000);


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
     [0, sqrt(3)/2]; % FPA
     [sqrt(3)/2, sqrt(3)/2]; % FPB
     [sqrt(3)/2, 0]}; % FPC
 
y = {[1, 1/2]; % SPA
     [1/2, -1/2]; % SPB
     [-1/2, -1]; % SPC
     [1, 1/2]; % FPA
     [1/2, -1/2]; % FPB
     [-1/2, -1]}; % FPC
 
% x and y coords of node centers
cx = [0, -sqrt(3)/2, -sqrt(3)/2, 0, sqrt(3)/2, sqrt(3)/2];
cy = [1, 1/2, -1/2, -1, -1/2, 1/2];
 
gifCounter = 1;

if realTimeVis == 1
    v = VideoWriter(char(videoTitle));
    
    %  total time: 60s, total frames: 4000
    v.FrameRate = 30; % frames/sec
    open(v);
end

 % Running the model
 while t <= 4000
     
        % Heart Model
        crash = zeros(1,7); % reset crash before each call to heart_model
        [node_table,path_table, crash]=heart_model(node_table,path_table, crash);
        
        
        % first impulse
        % 120 initiates tachycardia
        
        if t==20
            node_table{1,9} = 1;
            premature(t) = 1;
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
      
        [ATP_table] = detection(t, cycle_length, ATP_table, realTimeVis);
       
     
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
        FPC_ante(t) = path_table{6,15}; 
        FPC_retro(t) = path_table{6,14}; 
    
        if realTimeVis == 1
            gifImageTitle = ['heart', num2str(gifCounter), '.jpg'];
            imdata = imread(gifImageTitle);
            
            
            % Circuit Image
            circuit_example(x, y, cx, cy, node_table, path_table, t, imdata, crash, realTimeVis);
            
            video = getframe(gcf);
            writeVideo(v, video);
            cla % clear axes for faster run time
            
            if gifCounter == 24
                gifCounter = 1;
            elseif gifCounter < 24
                gifCounter = gifCounter + 1;
            end
        end
        
     t=t+1;
     
 end

if realTimeVis == 1
    close(v); 
end

saveName = 'Circuit History';

figure('Name', saveName, 'Position', [4000, 40, 790, 560])
subplot(6,1,1)
plot(impulse)
title('ATP Impulse')

subplot(6,1,2)
plot(premature)
title('Premature Impulse')

subplot(6,1,3)
plot(SPA_ante)
title('SPA-A')

subplot(6,1,4)
plot(SPA_retro)
title('SPA-R')

subplot(6,1,5)
plot(FPC_ante)
title('FPC-A')

subplot(6,1,6)
plot(FPC_retro)
title('FPC-R')
xlabel('Time (ms/10)')

print(saveName, '-djpeg', '-r300')

close all 
% these are for debugging purposes
% plot(CL_tracker)
% plot(RCL_tracker)