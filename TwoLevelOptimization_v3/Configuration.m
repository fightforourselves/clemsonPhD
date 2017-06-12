classdef Configuration
    
    properties
        % --------------------------------------
        % %% Settings
        % --------------------------------------------
        
        % Optimization Configurations
        %
        % each design var will control the density and volume fraction
        % material of several clustered elements.
        mode =4; % 1 = topology only, 2 = material optimization only. 3 = both,4 = meso only. 5 = meso-structure testing
        doUseMultiElePerDV=0; % 1= true, 0 = false do use multiple elements per (1) design varriable.
        averageMultiElementStrain; % 1= true, 0 = false instead of making 1 large strain field, make sevral and average the sensitivies
        singleMesoDesign; % 1 = yes, 0 = true.
        numXElmPerDV= 2; % Number of elements in the X direction for 1 (per) design varriable.
        numYElmPerDV =2; % Number of elements in the X direction for 1 (per) design varriable.
        macro_meso_iteration = 0; % master loop of the whole macro meso system
        mesoAddAdjcentCellBoundaries = 0; % global property
        useAjacentLocal = 0; % local property that maybe be turned on or off
        testingVerGradMaterail = 0;
        numVarsX;
        numVarsY;
        w1 = 1; % weight elastic for multi-objective, % do not set to zero, instead set to 0.0001.
        w2 = 0;
        
        % For ATC optimization
        addConsistencyConstraints=1;      
        Omega = 0.15;
        
        % Modeling settings
        referenceTemperature = 0; % for thermal expansion, assume that there is not strain when at this temperature.
        addThermalExpansion = 0; % Set to 1 to incorporate thermal expansion
      
        
        % rotation
        useRotation =1; % must be 0 for gradient material optimization
        minRotation =-pi/2;
        maxRotation = pi;
        rotationMoveLimit = pi/45;
        
        
        % number of elements
        nelxMeso = 40;
        nelyMeso = 40;
        nelx = 40; % 40 # of elements in the x direcction, must be a multiple of numXElmPerDV
        nely = 20; % 18 number of elements in the y direction, must be a multiple of numYElmPerDV
        nelxMacro;
        nelyMacro;
        
        % SIMP settings
        penal = 3.0; % penality used for the SIMP method
        rmin = 2; % smoothing radius for sensitivity smoothing.
        voidMaterialDensityCutOff = 0.3; % everything below this density is considered void.
        noNewMesoDesignDensityCutOff = 0.28; % any densities below this will not be redesigned. Having a different value than voidMaterialDensityCutOft helps stabalize the algorithm on the structure edges.
        
        
        % VOLUME Fraction SEttings.
        timestep = 0.001; % time step for the volume fraction update algorithm
        volFractionDamping = 1;
        v1 = 0.6; % amount of material 1 to use. default to 20%
        v2 = 0.4; % amount of material 2 to use. default to 40%, reduced so there is less meso structures to compute
        totalVolume; % = v1+v2;
        
        % Meso Design settings
        mesoVolumeUpdateMethod=1; % 1 = average, 2 = Target the larger
        maxMesoLoops = 120;
        maxNumPseudoStrainLoop=3;
        PseudoStrainEndCriteria = 0.1;  
        TargetECloseNess=0.03; % part of the termination criteria
        volumeUpdateInterval=12;
        coordinateMesoBoundaries = 1;
        mesoDesignInitalConditions = 1; % 1 = randome, 2= square, 3 = circle
        MesoMinimumDensity=0;
        AddBorder=0; % Add border to complete structure. 
        UseLookUpTableForPsuedoStrain=1; %0 = feedback loop, 1 = use look up. 
        
          
        % Exx and Eyy Distribution
        useExxEyy=1;    % must be 0 for gradient material optimization
        useTargetMesoDensity = 1; % 1 = yes, 0 = no and use target Eavg
        targetAvgExxEyy=50000;
        targetExxEyyDensity = 0.6;
        useThetaInSurfaceFit = 0;
        useANN=0;
        useAnnForDensityNotDerivative = 1;
        rminExxEyy = 1.2 % smoothing radius for sensitivity smoothing.
        
        % True anisotropic material
        anisotropicMat=0;
        
         % Use R in Exx and Eyy material model for the shear component
        useRinOrthMaterialModel=0;
      
        
        
        % Plotting information
        plotSensitivityWhilerunning = 0;
        mesoplotfrequency=1; % how often to plot the meso level design.
        iterationsPerPlot = 5;
        doPlotVolFractionDesignVar = 0;
        doPlotTopologyDesignVar = 0;
        doPlotHeat = 0;
        doPlotHeatSensitivityTopology = 0;
        doPlotStress = 0;
        doPlotFinal =0; % blue, green, empty space plot
        doPlotMetrics = 0;
        doPlotConsistencyConstraintsInMetrics = 0;
        doSaveDesignVarsToCSVFile = 0; % set to 1 to write plotFinal csv file instead
        doPlotAppliedStrain = 0; % For debugging only
        doPlotOrthDistributionVar=0;
        doPlotExx = 0  ;
        doPlotEyy =  0 ;
        doPlotEyyExxArrows =0;
        doPlotElasticSensitivity =  0  ;
        doPlotRotationValue =0;
        doSysANDSubSysDiffValues = 0;
        doPlotAnIsotropicValues=0; % 4 plots
        
        % Exx ,Eyy , Theta (and Rho) Plot Data
        doPlotCombinedExxEyyAndRotation = 1;
        doIncludeRho=1;;
        doIncludeSubSystemValues=1;
        %-----------------
        
        recvid = 0; % record video
        maximizePlots= 0;
        
        % ----------------
        % Computational settings
        % ------------------
        iterationNum=0; %  used for parallel computing.
        maxFEACalls = 50;
        maxMasterLoops = 30;             
        terminationAverageCount = 5; % the average change over this number of iterations must be below the termination criteria
        terminationCriteria = 0.001; % if the normalized average change over  terminationAverageCount of iterations is below this value then termainted. ie. 1% change
        % not much faster.
        useGPU = 0; % set to 1 to try to solve matrix using gpu
        parallel =0; % set to 1 to use parfor while preforming the meso design
        numWorkerProcess = 8;
        useCommandLineArgs = 0;
        RunPalmetto =1;
        gr =  (1+sqrt(5))/2 -1 ; % golden ratio  0.618033988749895
        multiscaleMethodCompare=0;% Implemented Coelho's method if this ==1
        
        % ---------------------------
        % Meso Validation seetings
        % mode = 111 or 112, also 113
        % ---------------------------
        validationGridSizeNelx = 11; % , This value cubed  will be the number of sub problems, 22^3 =10648
        validationModeOn=0; % 1 = yes. 
        
        % ANN target test or Loopkup data generator
        strainAndTargetTest =1; % for mode 113
        targetTestVectorLen=20; % 13 is reasonable
        
       
        
        % -----------------
        % Use different mixture rules for effective elastic properteis
        % 1. Simple linear interpolation, Vigot rule of miztures E = w(E1)*(1-w)*E2
        % 2. Hashin�Shtrikam law (average of upper and lower boundary)
        % 3. Reuss -rule, 1/E = w/E1+(1-w)/E2 (not implemented yet)
        % 4. Mori and Tanaka, metal ceramic composite
        % ---------------------
        elasticMaterialInterpMethod =1;
        % -----------------
        % Use different mixture rules for effective Heat properteis
        % 1. Simple linear interpolation, Vigot rule of miztures E = w(E1)*(1-w)*E2
        % 3. Reuss -rule, 1/E = w/E1+(1-w)/E2 (not implemented yet)
        % 4. Kingery's, metal ceramic composite
        % 5. Hashin�Shtrikam law (average of upper and lower boundary)
        % ---------------------
        heatMaterialInterpMethod = 1;
        
        % ---------------------------
        % Loading cases
        % ---------------------------
%         loadingCase = [113]; % left clamped, load, middle right
        %           loadingCase = [111 112 113]; % left clamped
        %            loadingCase = [111 112 ]; % left clamped
        %          loadingCase = [111 120 121]; % up, down, right in top right corrner, left clamp.
        %         loadingCase = [111 120]; % up, down, right in top right corrner, left clamp.
        %              loadingCase = [1];
        
        %  loadingCase = [300 301 302 303 304 305]; % shoe
                   loadingCase = [400 401 402 403 404 405]; % bridge
        %            loadingCase = [404]; % bridge
        %             loadingCase = [113]; % cantilever
        %                 loadingCase = [111]; % top right, force in Y direction
        
        % --------------
        % Meso tiling info
        %--------------
        numTilesX = 3;
        numTilesY = 3;
        
        % oTHER
        generateCompleteStructureCSV=0;
        
    end
    
    %% -----------------------
    % Methods related to modifying the configuration
    %------------------------
    methods
        function obj = Configuration()
            % Constructor.
        end
        
        
        
        % ------------------------------------
        % Update some of the computed settings
        % -------------------------------------
        function [obj]= UpdateRunTimeComputedSettings(obj, useInputArgs, w1text, macro_meso_iteration,mode, singleMeso_elementNumber)
            
            
            % --------------------------------------
            % PALMETTO
            %
            % If running on the palmetto, then update for palmetto with
            % special settings.
            % --------------------------------------
            if(obj.RunPalmetto==0)
                % ------------
                % Normal running case
                % -------------------
                obj.macro_meso_iteration = str2double(macro_meso_iteration);
                obj.nelx = 20;
                obj.nely = 20;
              
                obj.nelxMeso = 25; %35;
                obj.nelyMeso =25; %35;
                obj.w1 = 1; % do not set to zero, instead set to 0.0001. Else we will get NA for temp2
                obj.iterationNum = 0;
                obj.doSaveDesignVarsToCSVFile = 0;
             
                obj.numWorkerProcess = 3;
            else
                % ------------
                % Palmetto running case
                % -------------------
                obj.nelx = 45; %% 30
                obj.nely = 45; %  15
                obj.nelxMeso = 35; %35;
                obj.nelyMeso =35; %35;
                obj.terminationAverageCount = 10;
                obj.terminationCriteria =0.001; % 0.0%
                obj.maxFEACalls = 180;
                obj.maxMasterLoops = 300;
                
            end
            
            % ----------------------------------------
            % INPUT ARGS
            %
            % Process input arguments
            % -----------------------------------------
            if(str2double(useInputArgs) ==1)
                % parse potential input arguments.
                obj.macro_meso_iteration=str2double(macro_meso_iteration);
                obj.mode=str2double(mode);
                obj.w1 =str2double(w1text);
                
            end
            
            % --------------------------------------
            % Update the volume fraction targets and total volume.
            % --------------------------------------
            % Do not allow w1 to be zero. Divide by zero messes stuff up.
            if(obj.w1 ==0)
                obj.w1=0.00001;
            end
            obj.w2  = 1- obj.w1; % weight heat transfer
            obj.totalVolume = obj.v1+obj.v2;
            
            % On the first macro iteration, limit the number of FEA calls. 
            % convergence is simple. 
%             if(obj.macro_meso_iteration ==1)
%                  obj.maxFEACalls=120;
%             end
            
            
            % 111 = Validate Meso (generate Targets)
            % 112 = Read the meso design information and compute validation metrics
            if(obj.mode == 111 || obj.mode==112)
                obj.validationModeOn=1;          
                obj.nelx = obj.validationGridSizeNelx; 
                obj.nely = obj.validationGridSizeNelx;                
            end
           
            if(obj.strainAndTargetTest==1)
                obj.nelx = obj.targetTestVectorLen; 
                obj.nely = obj.targetTestVectorLen; 
               obj.maxNumPseudoStrainLoop=1;
            end
           
           obj.nelxMacro=obj.nelx;
           obj.nelyMacro=obj.nely;
           
           if(obj.multiscaleMethodCompare==1)
               obj.penal=1; % make it into the homogenization method
               obj.maxMasterLoops=1; % 1 macro step 
               obj.maxNumPseudoStrainLoop=1;
              % obj.mesoDesignInitalConditions=1;
               obj.maxFEACalls=1;
           end
           
           if(obj.multiscaleMethodCompare==1)
               obj.DisplayImportantMessage('multiscaleMethodCompare is on. This is basically Coelhos method')
           end
           if(obj.strainAndTargetTest==1)
               obj.DisplayImportantMessage('strainAndTargetTest is on. Generating or meeting systematic targets of psuedo strains and density targets. ')
               if(113<=obj.mode && obj.mode<=115 || obj.mode ==100)
               else
                   fprintf('Wrong mode');
                   error('wrong mode');
               end
           else
                if(113<=obj.mode && obj.mode<=115)
                    fprintf('Forgot to turn on strainAndTargetTest in config. ');
                   error('strainAndTargetTest is not on. ');
                end
           end
           
           if(obj.validationModeOn==1)
               obj.DisplayImportantMessage('Meso structure validation is on. Generating D_targets for meso design problem to try to meet. ')
               if(obj.mode~=111 && obj.mode~=112 && obj.mode~=100)
                   error('Wrong mode');
               end
           else
               if(obj.mode==111 || obj.mode==112)
                   error('Wrong mode. Forgot to turn on config.validationModeOn');
               end
           end
           
           if(obj.validationModeOn==1 && obj.strainAndTargetTest==1)
                obj.DisplayImportantMessage('Validation and Psuedo Strain targets can NOT be on at the same time. Exiting program.  ')
                exit(0);
           end
        
        end
        
        
        function [] = DisplayImportantMessage(obj, message)
            
            fprintf('----------------------------------------------\n\n');
            fprintf('             %s\n',message);
            fprintf('\n----------------------------------------------\n');
            
        end
        
        
        %         function obj = CalculateDesignVarsPerFEAelement(obj)
        %
        %             if(obj.doUseMultiElePerDV ==1)
        %                 if(mod(obj.nely,obj.numYElmPerDV)~=0 || mod(obj.nelx,obj.numXElmPerDV)~=0 )
        %                     disp('nely and numYElmPerDV or nelx and numXElmPerDV not compatible Exiting MATLAB')
        %                     exit
        %                 end
        %
        %                 obj.numVarsX = obj.nelx/obj.numXElmPerDV;
        %                 obj.numVarsY = obj.nely/obj.numYElmPerDV;
        %
        %             end
        %         end
        
        % -----------------------------
        % Given design var position, get list of elements X,Y that are
        % controlled by the design var. Since there are multiple elements
        % the x and y returned values are an array.
        %
        % Only applicable when multiple elements per design var is true.
        %
        % -----------------------------
        %         function [eleXnums, eleYnums,xNodeNums,yNodeNums, macroXdesignVarindex,macroYdesignVarindex] = GetElementsForDesignVar(obj,designvarNumber)
        %             % 1. Get the x,y position of the design var.
        %             % 2. multiply by elements per design var to get positions.
        %
        %             numVarsinRow =obj.numVarsX;
        %             numVarsinColumn =obj.numVarsY;
        %             ydesignVar =   floor( designvarNumber/numVarsinRow)+1;
        %             xdesignVar = mod(designvarNumber/numVarsinColumn);
        %
        %             macroXdesignVarindex = xdesignVar;
        %             macroYdesignVarindex = ydesignVar;
        %
        %             xStart = xdesignVar*obj.numXElmPerDV-(obj.numXElmPerDV);
        %             yStart = ydesignVar*obj.numYElmPerDV-(obj.numYElmPerDV);
        %
        %             numElementsPerDV = obj.numXElmPerDV*obj.numYElmPerDV;
        %             eleXnums = zeros(numElementsPerDV,1);
        %             eleYnums = zeros(numElementsPerDV,1);
        %
        %             count = 1;
        %             for j = 1:obj.numYElmPerDV
        %                 for i = 1:obj.numXElmPerDV
        %                     eleXnums(count) = xStart+i;
        %                     eleYnums(count) = yStart+j;
        %
        %                     count =count+1;
        %                 end
        %             end
        %
        %
        %
        %         end
    end
end