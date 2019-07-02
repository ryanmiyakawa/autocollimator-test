classdef autocollimator_ui < mic.Base

    
    properties (Constant)
        dWidth  = 900;
        dHeight =  900;
      
    end
    
    properties
        hFigure
        hAxes % main axes
        
        
        uibGo
        uibAbort
        
        uieNumSteps
        
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
                       
           % instantiate edit boxes:
           this.uieNumSteps = mic.ui.common.Edit(...
               'cLabel', 'Num Steps',...
               'cType', 'd');
          
        end
        
        % Callback handler
        function cb(this, src, evt)
            
            switch src
                case this.uibGo % user clicked go
                    %
                    fprintf('Going!\n')
                case this.uibAbort % user clicked go
                    fprintf('Aborting!\n')
                    
                    
                    img = rand(5);
                    imagesc(this.hAxes, img);
                    
                    % example of how to read edit box:
                    val = this.uieNumSteps.get(); % ?
                    
                    fprintf('The edit box says: %d!\n', val);
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
                                    'Position',     [400, 400, 450, 450] ...
                                    );

             this.uibGo.build(this.hFigure, 400, 600, 100, 40);
             this.uibAbort.build(this.hFigure, 550, 600, 100, 40);
             
             this.uieNumSteps.build(this.hFigure, 200, 600, 60, 30);
           
        end
        
    end
    
end

