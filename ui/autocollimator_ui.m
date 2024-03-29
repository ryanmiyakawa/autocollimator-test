classdef autocollimator_ui < mic.Base

    
    properties (Constant)
        dWidth  = 800;
        dHeight =  800;
      
    end
    
    properties
        hFigure
        hAxes % main axes
        
        % buttons
        uibGo
        uibAbort
        uibReset
        uibUp
        uibDown
        uibLeft
        uibRight
        
        % edit box
        uieNumSteps
        uieStepSize
        uieStepSizeF
       
        
    end
    
    properties (SetAccess = private)
        
    end
    
    methods
        function this = autocollimator_ui()
            this.init()
        end
        
        
        
        function init(this)
            
           % Instantiate buttons
           this.uibGo = mic.ui.common.Button(...
                           'cText', 'GO!',...
                           'fhDirectCallback', @this.cb);
                       
           this.uibAbort = mic.ui.common.Button(...
                           'cText', 'Abort!',...
                           'fhDirectCallback', @this.cb);
                       
           this.uibReset = mic.ui.common.Button(...
                           'cText', 'Reset',...
                           'fhDirectCallback', @this.cb);
           this.uibUp = mic.ui.common.Button(...
                           'cText', 'Up',...
                           'fhDirectCallback', @this.cb);            
           this.uibDown = mic.ui.common.Button(...
                           'cText', 'Down',...
                           'fhDirectCallback', @this.cb);
           this.uibLeft = mic.ui.common.Button(...
                           'cText', 'Left',...
                           'fhDirectCallback', @this.cb);
           this.uibRight = mic.ui.common.Button(...
                           'cText', 'Right',...
                           'fhDirectCallback', @this.cb);            
                       
           % instantiate edit boxes:
           this.uieNumSteps = mic.ui.common.Edit(...
               'cLabel', 'Num Steps',...
               'cType', 'd');
           
           this.uieStepSize = mic.ui.common.Edit(...
               'cLabel', 'Step Size (mm)',...
               'cType', 'd');
           this.uieStepSizeF = mic.ui.common.Edit(...
               'cLabel', 'Step (mm)',...
               'cType', 'd');
          
        end
        
        % Callback handler
        function cb(this, src, evt)
            
            % read edit box:
                    dNStep = this.uieNumSteps.get(); 
                    dStep = this.uieStepSize.get();
                    dStepF = this.uieStepSizeF.get();
                    dPause = 1;
                    
            % create empty matrix 
            img = zeros(dNStep, dNStep);
                  
            switch src
                
                case this.uibGo % user clicked go
                    % scans/reads the amounts inputted
                    for c = 1:dNStep
   
                        for r = 1:dNStep
                            val1 = keith.read();
       
                            if mod(c, 2) == 0 % c is even in this case
                                img (r,c) = val1;
                                xaxis.moveRelative(dStep) % positive is up
                            else
                                img (dNStep + 1 - r,c) = val1;
                                xaxis.moveRelative(-dStep) % negative is down
                            end
                            pause(dPause);
                            
                        end
                        zaxis.moveRelative(dStep) % positive is right
                        pause(dPause);
                        imagesc(this.hAxes,img)
                    end
                    
                %case this.uibAbort % user clicked abort
                    % stages stop
                    
                    
                    
                case this.uibReset % user clicked Reset
                    % laser goes back to (1,1)
                    c = dNStep;
                    r = dNStep;
                    if mod(c,2) ~= 0 % c is odd therefore the laser will be at the bottom and needs to go back up
                        xaxis.moveRelative(dNStep) % move back to r = 1
                    end
                    zaxis.moveRelative(-dNStep)
                    
                
                case this.uibUp
                    xaxis.moveRelative(dStepF)
                    
                case this.uibDown
                    xaxis.moveRelative(-dStepF)
                    
                case this.uibLeft
                    zaxis.moveRelative(-dStepF)
                    
                case this.uibRight
                    zaxis.moveRelative(dStepF)
                    
            end
          
            
                  
        end
        
       
        
        function build(this)

            % build the main window
            this.hFigure = figure(...
                'name', 'Autocollimator UI v0.0',...
                'Units', 'pixels',...
                'Position', [1, 1,  this.dWidth, this.dHeight],...
                'handlevisibility','off',... %out of reach gcf
                'numberTitle','off',...
                'Toolbar','none',...
                'Menubar','none');
                
            
            

             this.hAxes = axes(     'Parent',       this.hFigure, ...
                                    'Units',        'pixels', ...
                                    'Position',     [275, 100, 500, 650] ...
                                    );

             this.uibGo.build(this.hFigure, 120, 50, 100, 40);
             this.uibAbort.build(this.hFigure, 120, 75, 100, 40);
             this.uibReset.build(this.hFigure, 120, 115, 100, 40);
             this.uibUp.build(this.hFigure, 120, 398, 40, 40);
             this.uibDown.build(this.hFigure, 120, 480, 40, 40);
             this.uibLeft.build(this.hFigure, 80, 440, 40, 40);
             this.uibRight.build(this.hFigure, 160, 440, 40, 40);
             
             this.uieNumSteps.build(this.hFigure, 50, 100, 60, 30);
             this.uieStepSize.build(this.hFigure, 50, 50, 60, 30);
             this.uieStepSizeF.build(this.hFigure, 123, 435, 30, 30);
             
           
        end
        
    end
    
end

