% makes it so that anything in this folder MATLAB treats as fair game
addpath('../Keithley2002GPIB/');


% create a keithley "instance"
keith = Keithley2002();

% init galil:
[xaxis, zaxis] = initGalil();

% Here's how to use galil:
%
% xaxis.moveRelative(10);
% zaxis.moveRelaitve(10);
%

%%

dStep = 1; % 1 mm
dNSteps = 10;
dPause = 1; % seconds

% create an empty matrix
img = zeros(dNSteps, dNSteps);

for c = 1:dNSteps
   
   for r = 1:dNSteps
        val1 = keith.read();
       
        if mod(c, 2) == 0 % c is even in this case
            img (r,c) = val1;
            xaxis.moveRelative(dStep) % positive is up
        else
            img (dNSteps + 1 - r,c) = val1;
            xaxis.moveRelative(-dStep) % negative is down
        end
        pause(dPause);
        imagesc(img)
    end
    zaxis.moveRelative(dStep) % positive is right
    pause(dPause);
end

%%
% test the matrix 

% 
% if (img(1,1) == val1)
%     fprintf('function works')
% else 
%     fprintf('function does not work')
% end

   

%% 
%reset position
c = dNSteps;
r = dNSteps;
if mod(c,2) ~= 0 %c is odd therefore the laser will be at the bottom
    xaxis.moveRelative(dNSteps) % supposed to move back up to r =1 but overshoots every time)
end

zaxis.moveRelative(-dNSteps)% go back to c=1






%{
Thinking space: (pseudo code)

1) assume that mirrors are located so spot is in top left hand corner of
grid?

2) read diode, store in appropriate location in "img" matrix using img(row,
col) = read value

3) nudge to new value (but, this might be left, right, up or down depending
on where we are... hmmm)

4) repeat



some coding tips:

1) make pseudo code

2) follow the steps the computer is going to take, but in your head, do the
instructions match what you intended

3) make "unit tests"

steps (5 x 5), but let's generalize to (N X N): 
(assuming the reading starts at top left corner still)

1) starting at whatever position it is at, read and place in first matrix
spot (starting w/ top left) (keith.read() -> img (1,1) = ans)

2) for c=1, move mirror relative 1 mm (?) down (if c odd) up (c even) (logically down makes more sense just based on the orientation of the matrix) (moving x axis) 

3) read and place in second spot (2,1): img(r,c) = ans (if c odd) img(N + 1 - r,c) = ans  (if c
even)

4) repeat for r = 1:N

5) for c = 2, move right (logically makes sense but could be left?) 1 mm

6) repeat steps 2-4

7) move 1 mm for each c increase by 1 and then read those

8) test the readings by spitting out the matrix and seeing if it read any
values (if it's all zeros still it could be because the mirrors missed the
diode??);; choose random coordinates for it to read (or all if really
necessary)

ideas on how to do this:
val = keith.read() 
img (1,1) = val

first column reading:
for c = 1
    for r = 1:5
        xaxis.moveRelative([+/-]1)
        val1 = keith.read()
        img (r,c) = val1
end
end

second column reading: (not sure if i just have to move the column 1mm each
time// can i do 2:6 and it will move relative per each number?)

dStep = 1; % 1 mm
dNSteps = 5;
for c = 1:dNSteps
   
   for r = 1:5
        val1 = keith.read()
       
        if mod(c, 2) == 0 % c is even in this case
             img (r,c) = val1
            xaxis.moveRelative(dStep) % positive is down
        else
             img (dNSteps + 1 - r,c) = val1
            xaxis.moveRelative(-dStep) % positive is down
        end
    end
    zaxis.moveRelative(dStep) % positive is right
end

example tests: 
if (img(1,1) ~= val1)
    fprintf('function doesn't work')
end
if (img(4,5) ~= val1)
    fprintf('function doesn't work')
end



Process steps pretending we're computer:

r = 1, c = 1

img = [ val 0 0 0 0 
        0   0 0 0 0
        ..

r = 2, c = 1

img = [ val 0 0 0 
        val2 0 0 0
        ]

r = ...
r = 5

img = [ val 00
        val
        ...
        val5

r = 1, c = 2
read. (ok)

img = [val1  val6 0 0 
        val2
        ...
        val5]



%}








