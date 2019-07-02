function [xaxis, zaxis] = initGalil()

% Get master instance of a Galil stage
stage =  cxro.serm.device.GalilXZStage('cxro/test/GalilXZStageTest','192.168.1.110');

% Get the xaxis
xaxis = stage.getXAxis();
% Get the zaxis:
zaxis = stage.getZAxis();

% Initialize stages if not already:
if ~xaxis.isInitialized() 
    xaxis.setInitialized(true);
end

% Initialize stages if not already:
if ~zaxis.isInitialized() 
    zaxis.setInitialized(true);
end




