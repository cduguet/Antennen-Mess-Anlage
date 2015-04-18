function varargout = Messdaten_Converter(varargin)
% MESSDATEN_CONVERTER M-file for Messdaten_Converter.fig
% Conversion from Antennenmessanlage (AMA) format (*.001 - *.0xx)
% to a Matlab lookuptable format. 
% 
% AMA coordinates: Phi_0 (azimuthal) and Theta_0 (zenithal) 
% Antenna coordinates: Phi (Azimuth) and Theta (from Zenit to backfire)
% 
% AMA format: measures of 2 orthogonal polarizations of an Antenna Pattern (AP)
% 
% The Array has NAnt Antenna elements, in a sqare structure, saparated each
% in a distance d_elements, and the pattern is measured in NPhi_0 
% Phi_0 points and NTheta_0 Theta_0 points.
% 
% Each file represents the measurement for all the Theta_0 points of ONE Phi_0 
% point in ONE element. Zum Beispiel  "DD_E1An1.008"
% Enthï¿½t die Messungen fï¿½ die Antenne An1, im 8. Phi0 Punkt.
%
%**************************************************************************
%* ACHTUNG: Die Name des Ordners soll so sein: 
%*          \<------Freiwillig------>_jede_<Y>ï¿½bis_<ZZZ>ï¿½
%* 
%* Wo:      
%*          <Y>  ist die Entfernung der Phi Messungen
%*          <ZZZ>ist die letzte Phi Messung.                             
%**************************************************************************
%-------------------------------------------------------------------------%
% Data struktur von AMA files:
%-------------------------------------------------------------------------%
% CITIFILE A.01.01
% #NA VERSION HP8530A.01.64
% #NA TITLE / FILENAME: DD_E1An1.001
% NAME DATA
% #NA REGISTER 2
% VAR ANGLE MAG 721
% DATA P[1] RI
% DATA P[2] RI
% SEG_LIST_BEGIN
% SEG -180.0  180.0  721
% SEG_LIST_END
% #NA CW_FREQ  1.575 GHZ
% COMMENT       YEAR MONTH DAY HOUR MINUTE SECONDS
% CONSTANT TIME 2010  Jul   15  08    47    52.0
% BEGIN
%  ****Data structure of Channel 1 ****
%       [RE_column],[IM_column]
%  ****Data structure of Channel 1 ****
%  END
%  BEGIN
%  ****Data structure of Channel 2 ****
%       [RE_column],[IM_column]
%  ****Data structure of Channel 2 ****
%-------------------------------------------------------------------------%
% Created:
% Date          -               Who?
% 17.03.2011    -          Cristian Duguet S. 
%
% 
% Modified:
% Date          -               Who?               -        Was?
% 18.03.2011    -          Cristian Duguet S. - Nach Besprechen mit Wahid
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%
%-------------------------------------------------------------------------%


%      MESSDATEN_CONVERTER, by itself, creates a new MESSDATEN_CONVERTER or raises the existing
%      singleton*.
%
%      H = MESSDATEN_CONVERTER returns the handle to a new MESSDATEN_CONVERTER or the handle to
%      the existing singleton*.
%
%      MESSDATEN_CONVERTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MESSDATEN_CONVERTER.M with the given input arguments.
%
%      MESSDATEN_CONVERTER('Property','Value',...) creates a new MESSDATEN_CONVERTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Messdaten_Converter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Messdaten_Converter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Messdaten_Converter_OpeningFcn, ...
                   'gui_OutputFcn',  @Messdaten_Converter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Messdaten_Converter is made visible.
function Messdaten_Converter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Messdaten_Converter (see VARARGIN)

% Choose default command line output for Messdaten_Converter
handles.output = hObject;

handles.OriginPosition = [0 0];
set(handles.OriginPosition_buttongroup,'SelectionChangeFcn',@OriginPosition_buttongroup_SelectionChangeFcn);

set(handles.Format_type_buttongroup,'SelectionChangeFcn',@Format_type_buttongroup_SelectionChangeFcn);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Messdaten_Converter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Messdaten_Converter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

clc
% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function element1_Callback(hObject, eventdata, handles) %#ok<*DEFNU>
% hObject    handle to element1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of element1 as text
%        str2double(get(hObject,'String')) returns contents of element1 as a double

% store the contents of element1 as a string.If the string is not a number then
% input will be empty

% checks to see if input is empty. if so, default el is set 0
guidata(hObject,handles);


function element1_CreateFcn(hObject, eventdata, handles) %#ok<*INUSD>
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function el2_Callback(hObject, eventdata, handles)
guidata(hObject,handles);

function el2_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function el3_Callback(hObject, eventdata, handles)
guidata(hObject,handles);

function el3_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function el4_Callback(hObject, eventdata, handles)
guidata(hObject,handles);

function el4_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Folder_Callback(hObject, eventdata, handles)
% hObject    handle to Folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Folder as text
%        str2double(get(hObject,'String')) returns contents of Folder as a double

% --- Executes during object creation, after setting all properties.
function Folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in search_pushbutton.
function search_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to search_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

folder = uigetdir('','Select experiment folder');
%When using Windows, the delimiter must be used doubled
%'\\'in order to be used as a parameter in textscan
if strcmp(filesep,'\')     ; sep = [filesep filesep];
elseif strcmp(filesep,'/') ; sep = filesep;
end
if folder
    set(handles.Folder,'String',folder)
    fclose all; 
    handles.logfile  = fopen([folder '/log.txt'],'w','n','ISO-8859-1');
    fprintf('Writing on file %s\\log.txt. \n',folder);
    fwrite(handles.logfile, sprintf('Reading folder %s \r\n',folder));
    fprintf('Reading folder %s\n',folder);
    
    switch handles.Format
        case 'AMA'
            %--------------CASE 1: AMA Measurements
            %with the following we pretend to copy the values of Phi0_end and Phi0_step
            %from the readed folder into the boxes in the same GUI. In case the name of
            %the folder is not in the required format for recognition, just throw a
            %warning
            
            dummy = textscan(folder,'%s','delimiter',sep);
            dummy = dummy{1};
            dummy = textscan(dummy{length(dummy)},'%s','delimiter','_');
            dummy = dummy{1};
            
            if length(dummy)>1
                Phi0_step = textscan(dummy{length(dummy)-1},'%d%*s');
                Phi0_end = textscan(dummy{length(dummy)},'%d%*s');
                Phi0_step = Phi0_step{1};
                Phi0_end = Phi0_end{1};
                
                if isnumeric(Phi0_step) && isnumeric(Phi0_end) &&...
                        ~isempty(Phi0_step) && ~isempty(Phi0_end)
                    set(handles.Phi0_step,'String',num2str(Phi0_step));
                    set(handles.Phi0_end,'String',num2str(Phi0_end));
                    set(handles.Phi0_start,'String','0');
                    display(['The Phi values were adjusted according to the folder'...
                       'name structure specified in "help".']);
                    fwrite(handles.logfile,['The Phi values were adjusted according to the folder'...
                       'name structure specified in "help".\r\n']);
                else
                    warning('NameStandard:FolderNameStructure',...
                        ['Folder Name does not have the desired structure.', ...
                        'We recommend to adjust it. See help Messdaten_converter']);
                end
            else
                warning(['Folder Name does not have the desired structure.', ...
                    'We recommend to adjust it. See help Messdaten_converter']);
            end
            
            % Choose elements
            
            prev_fol = cd;
            cd(folder);
            list_files = dir('*.001');
            list_files = { list_files(:).name };
            if isempty(list_files)
                fwrite(handles.logfile,'ERROR: No files were found in the directory');
                errordlg('No files were found in the directory','Error');
                cd(prev_fol); error('No files were found in the directory');
            end
            
            set(handles.element1,'String',list_files);
            set(handles.element2,'String',list_files);
            set(handles.element3,'String',list_files);
            set(handles.element4,'String',list_files);
            cd(prev_fol);
            
        case 'AMA_individual'
            % Choose elements
            
            prev_fol = cd;
            cd(folder);
            list_files = dir('*.001');
            list_files = { list_files(:).name };
            if isempty(list_files)
                fwrite(handles.logfile,'ERROR: No files were found in the directory');
                errordlg('No files were found in the directory','Error');
                cd(prev_fol); error('No files were found in the directory');
            end
            
            set(handles.element1,'String',list_files);
            cd(prev_fol);
            
        case 'Fraunhofer'
            % Choose elements
            prev_fol = cd;
            cd(folder);
            list_files = dir('*.txt');
            list_files = { list_files(:).name };
            %eliminate the log file if we find it.
            list_files(strcmp(list_files,'log.txt')) = [];
            
            if isempty(list_files)
                fwrite(handles.logfile,'ERROR: No files were found in the directory');
                errordlg('No files were found in the directory','Error');
                cd(prev_fol); error('No files were found in the directory');
            end
            
            set(handles.element1,'String',list_files);
            set(handles.element2,'String',list_files);
            set(handles.element3,'String',list_files);
            set(handles.element4,'String',list_files);
            cd(prev_fol);
        case 'HR'
            % Choose elements
            
            prev_fol = cd;
            cd(folder);
            list_files = dir('*.csv');
            list_files = { list_files(:).name };
            if isempty(list_files)
                fwrite(handles.logfile,'ERROR: No files were found in the directory');
                errordlg('No files were found in the directory','Error');
                cd(prev_fol); error('No files were found in the directory');
            end
            
            set(handles.element1,'String',list_files);
            set(handles.element2,'String',list_files);
            set(handles.element3,'String',list_files);
            set(handles.element4,'String',list_files);
            set(handles.element1_cross,'String',list_files);
            set(handles.element2_cross,'String',list_files);
            set(handles.element3_cross,'String',list_files);
            set(handles.element4_cross,'String',list_files);

            cd(prev_fol);
        case'HFSS'
            % Choose elements
            
            prev_fol = cd;
            cd(folder);
            list_files = dir('*.tab');
            list_files = { list_files(:).name };
            
            if isempty(list_files)
                fwrite(handles.logfile,'ERROR: No files were found in the directory');
                errordlg('No files were found in the directory','Error');
                cd(prev_fol); error('No files were found in the directory');
            end
            set(handles.element1,'String',list_files);
            set(handles.element2,'String',list_files);
            set(handles.element3,'String',list_files);
            set(handles.element4,'String',list_files);
            set(handles.element1_cross,'String',list_files);
            set(handles.element2_cross,'String',list_files);
            set(handles.element3_cross,'String',list_files);
            set(handles.element4_cross,'String',list_files);
            cd(prev_fol);
        otherwise
    end
else
    display('Folder name not specified.');
end
guidata(hObject,handles);

% --- Executes on button press in save_flag.
function save_flag_Callback(hObject, eventdata, handles)
% hObject    handle to save_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_flag


% --- Executes on button press in colorplots_flag.
function colorplots_flag_Callback(hObject, eventdata, handles)
% hObject    handle to colorplots_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of colorplots_flag


% --- Executes on button press in threeD_flag.
function threeD_flag_Callback(hObject, eventdata, handles)
% hObject    handle to threeD_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  Hint: get(hObject,'Value') returns toggle state of threeD_flag

%% Converter
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                     888                    
%                                                     888                    
%                                                     888                    
%  .d8888b .d88b.  88888b.  888  888  .d88b.  888d888 888888 .d88b.  888d888 
% d88P"   d88""88b 888 "88b 888  888 d8P  Y8b 888P"   888   d8P  Y8b 888P"   
% 888     888  888 888  888 Y88  88P 88888888 888     888   88888888 888     
% Y88b.   Y88..88P 888  888  Y8bd8P  Y8b.     888     Y88b. Y8b.     888     
%  "Y8888P "Y88P"  888  888   Y88P    "Y8888  888      "Y888 "Y8888  888    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

    function convert_Callback(hObject, eventdata, handles)
        % hObject    handle to convert (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        clc
        
        %% Variable & Constant Declaration
        NAnt        = 4;                       %No. of Antennas
        c           = 299792458;        %#ok<*NASGU> % speed of light [m/s]
        
        %% Close all other windows except the GUI window
        all_fig = findobj(0,'type','figure');
        delete(setdiff(all_fig,handles.output));
        
        %% Importing Variables from GUI
        %Channels:  to know with which channel we should work
        ch1_flag = get(handles.ch1_flag,'Value');
        ch2_flag = get(handles.ch2_flag,'Value');
         %Polarization flags
        copolar_flag = get(handles.copolar_flag,'Value');
        crosspolar_flag = get(handles.crosspolar_flag,'Value');
        
        %To know the polarization of each channel
        pol1= get(handles.ch1_pol,'String');
        pol1 = pol1{get(handles.ch1_pol,'Value')};
        pol2= get(handles.ch2_pol,'String');
        pol2 = pol2{get(handles.ch2_pol,'Value')};
        
        %check whether there were files selected or not
        if strcmp(get(handles.Folder,'String'),'Choose Directory') 
            ed = errordlg('You have to choose a folder!','Error');
            set(ed, 'WindowStyle', 'modal');
            uiwait(ed);
            error('You have to choose a folder!');
        end
        
        %Elements names/order
        if strcmp(handles.Format,'AMA_individual')
            
            files =   get(handles.element1,'String');
            files =   files{get(handles.element1,'Value')};
        end
        if strcmp(handles.Format,'AMA') ||strcmp(handles.Format,'Fraunhofer')
            files = cell(1,NAnt);
            files{1} =   get(handles.element1,'String');
            files{1} =   files{1}{get(handles.element1,'Value')};
            files{2} =   get(handles.element2,'String');
            files{2} =   files{2}{get(handles.element2,'Value')};
            files{3} =   get(handles.element3,'String');
            files{3} =   files{3}{get(handles.element3,'Value')};
            files{4} =   get(handles.element4,'String');
            files{4} =   files{4}{get(handles.element4,'Value')};
        elseif strcmp(handles.Format,'HR') ||strcmp(handles.Format,'HFSS')
            files = cell(NAnt,2);
            files{1,1} =   get(handles.element1,'String');
            files{1,1} =   files{1,1}{get(handles.element1,'Value')};
            files{2,1} =   get(handles.element2,'String');
            files{2,1} =   files{2,1}{get(handles.element2,'Value')};
            files{3,1} =   get(handles.element3,'String');
            files{3,1} =   files{3,1}{get(handles.element3,'Value')};
            files{4,1} =   get(handles.element4,'String');
            files{4,1} =   files{4,1}{get(handles.element4,'Value')};
            files{1,2} =   get(handles.element1_cross,'String');
            files{1,2} =   files{1,2}{get(handles.element1_cross,'Value')};
            files{2,2} =   get(handles.element2_cross,'String');
            files{2,2} =   files{2,2}{get(handles.element2_cross,'Value')};
            files{3,2} =   get(handles.element3_cross,'String');
            files{3,2} =   files{3,2}{get(handles.element3_cross,'Value')};
            files{4,2} =   get(handles.element4_cross,'String');
            files{4,2} =   files{4,2}{get(handles.element4_cross,'Value')};
        end
        
        %Coordinate Points
        Theta0_start = str2double(get(handles.Theta0_start,'String'));
        Theta0_end = str2double(get(handles.Theta0_end,'String'));
        Theta0_step = str2double(get(handles.Theta0_step,'String'));
        NTheta0 = (Theta0_end-Theta0_start)/Theta0_step+1;
        Theta0_axis = linspace(Theta0_start,Theta0_end,NTheta0);
        
        Phi0_start = str2double(get(handles.Phi0_start,'String'));
        Phi0_end = str2double(get(handles.Phi0_end,'String'));
        Phi0_step = str2double(get(handles.Phi0_step,'String'));
        NPhi0 = (Phi0_end-Phi0_start)/Phi0_step+1;
        Phi0_axis = linspace(Phi0_start,Phi0_end,NPhi0);
        
        %Antenna structure and coordinates origin 
        d_elements = str2double(get(handles.d_elements,'String')) * 1e-3;
        OriginPosition = handles.OriginPosition*d_elements; 
        RegionofInterest  = str2double(get(handles.coverage_zone,'String'));
        
        %Phase center bias correction 
        correction = zeros(1,3);
        correction(1) = -str2double(get(handles.correction_x,'String'));
        correction(2) = -str2double(get(handles.correction_y,'String'));
        correction(3) = -str2double(get(handles.correction_z,'String'));
        
        %Flags and tasks to do
        save_flag = get(handles.save_flag,'Value');
        colorplots_flag = get(handles.colorplots_flag,'Value');
        gaincuts_flag = get(handles.gaincuts_flag,'Value');
        phasecuts_flag = get(handles.phasecuts_flag,'Value');
        threeD_flag = get(handles.threeD_flag,'Value');
        phasecentercorr_flag = get(handles.phasecentercorr_flag,'Value');
        export_xls = get(handles.xls_flag,'Value');
        export_dat = get(handles.dat_flag,'Value');
        export_mat = get(handles.mat_flag,'Value');
        
       %Name of the folder in which is the data
        folder = get(handles.Folder,'String');
        %% Create log file
        fclose all;  % fuer sicherheit
        handles.logfile  = fopen([folder '/log.txt'],'a','n','ISO-8859-1');
        logfile = handles.logfile;
        
        %% Data Reading  
       

        switch handles.Format
            case 'AMA'
                if ~ch1_flag && ~ch2_flag
                    error('You must select at least one channel/polarization');
                end
                [E_Gain,E_Phase] = read_AMA(folder,NAnt,files,...
                    Theta0_axis,Phi0_axis,ch1_flag,ch2_flag,pol1,pol2);
                fprintf('AMA Data read.\n');
                phasetrend_flag =1;
     crosspolar_flag
            if ~copolar_flag && ~crosspolar_flag
                    ed = errordlg('You must select at least one channel/polarization','Error');
                    error('You must select at least one channel/polarization');
                end
                [E_Gain,E_Phase,Theta_axis,filenames] = read_AMA_individual(folder,files,logfile,copolar_flag,crosspolar_flag);
                fprintf('AMA Data read.\n');
                
                plotcuts_individual(E_Gain,'Gain (dB)',Theta_axis,folder,filenames,1);
                plotcuts_individual(E_Phase,'Phase (rad)',Theta_axis,folder,filenames,1);
                fclose all;
                return
            case 'Fraunhofer' 
                 if ~copolar_flag && ~crosspolar_flag
                    errordlg('You must select at least one channel/polarization','Error');
                    error('You must select at least one channel/polarization');
                end
                [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_Fraunhofer(folder,NAnt,files,copolar_flag,crosspolar_flag);
                fprintf('Fraunhofer Data read.\n');
                phasetrend_flag=1;
            case 'HR'
                if ~copolar_flag && ~crosspolar_flag
                    errordlg('You must select at least one channel/polarization','Error');
                    error('You must select at least one channel/polarization');
                end
                [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_HR(folder,NAnt,files,copolar_flag,crosspolar_flag);
                fprintf('HR Data read.\n');
                phasetrend_flag=0;
            case 'HFSS'
                 if ~copolar_flag && ~crosspolar_flag
                    errordlg('You must select at least one channel/polarization','Error');
                    error('You must select at least one channel/polarization');
                 end
                [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_HFSS(folder,NAnt,files,copolar_flag,crosspolar_flag);
                fprintf('HFSS Data read.\n');
                phasetrend_flag=1;
        end
            
        
        

        

        %% Convert coordinates from Thet0,Phi0 to Theta,Phi
        
        [E_Gain,Theta_axis,Phi_axis] = coord_converter(E_Gain,Theta0_axis,Phi0_axis);
        [E_Phase,Theta_axis,Phi_axis] = coord_converter(E_Phase,Theta0_axis,Phi0_axis);
        
        %Create grid for plotting
        [Theta_grid,Phi_grid]= ndgrid(Theta_axis,Phi_axis);
        NTheta = length(Theta_axis);
        NPhi = length(Phi_axis);

        %% Normalize Gain PAttern
        E_Gain = normalize(E_Gain);
        
        %% Correct Phase measurements
        E_Phase = correctPhase(E_Phase,d_elements,Theta_grid,Phi_grid,OriginPosition,phasetrend_flag);
        
        %% Antenna Phase center
        %Determine the position of the phase center of each antenna element
        %and calculate the mean center, for a certain region of interest
        [center,mse] = phasecenter_find(E_Phase,Theta_axis,Phi_axis,RegionofInterest,logfile,0);
        
        %% Correct Antenna Phase Center
        if phasecentercorr_flag
            E_Phase = phasecenter_correct(E_Phase,correction,Theta_axis,Phi_axis,logfile);
            fprintf('The Phase diagram were corrected to the given phase center.\n')
            fwrite(handles.logfile,'The Phase diagram were corrected to the given phase center.\r\n');
        end
        
        
        %% Plot 2D Colorplot Patterns of Channels
        if colorplots_flag
            plot2DGain(E_Gain,Theta_grid,Phi_grid,folder,save_flag);
            plot2DPhase(E_Phase,Theta_grid,Phi_grid,folder,save_flag);
        end
        
        
        %% Plot 2D Cuts
        if gaincuts_flag
            %% Plot 2D Gain cuts
            plotcuts(E_Gain,'Gain (dB)',Theta_axis,Phi_axis,folder,save_flag)
        end
        
        if phasecuts_flag
            %% Plot 2D Phase cuts
            plotcuts(E_Phase,'Phase (deg)',Theta_axis,Phi_axis,folder,save_flag)
        end

        
        %% Plot 3D Diagrams
        if threeD_flag
            plot3D(E_Gain,Theta_grid,Phi_grid,folder,save_flag);
        end
        
        
        %% Export as XLS 
        if export_xls
            exportxls(E_Gain,Theta_axis,Phi_axis,'Gain(dB)',folder);
            exportxls(E_Phase,Theta_axis,Phi_axis,'Phase(rad)',folder);
        end
        
        %% Export as binary DAT 
        if export_dat
            exportdat(E_Gain,'Gain(dB)',NTheta,NPhi,folder);
            exportdat(E_Phase,'Phase(rad)',NTheta,NPhi,folder);
        end
        
        %% Export MAT files
        if export_mat
            exportmat(E_Gain,E_Phase,Theta_grid,Phi_grid,folder)
        end
        
        fclose('all');
            
%% end of convert_Callback
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function E_Phase = phasecenter_correct(E_Phase,center,Theta_axis,Phi_axis,logfile)
    c = 299792458;        % speed of light [m/s]
    [NAnt NPol Nfreq] = size(E_Phase);
    [Theta_grid,Phi_grid]= ndgrid(Theta_axis,Phi_axis);
    
    for ifreq=1:Nfreq
        lambda = c/E_Phase{1,1,ifreq}.frequency;
        k =2*pi/lambda;
        
        for iAnt =1:NAnt
            for iPol = 1:NPol
                E_Phase{iAnt,iPol,ifreq}.pattern = E_Phase{iAnt,iPol,ifreq}.pattern - ...
                    k .*( center(1)*cos(deg2rad(Phi_grid)).* sin(deg2rad(Theta_grid)) + ...
                    center(2)*sin(deg2rad(Phi_grid)).* sin(deg2rad(Theta_grid)) + ...
                    center(3)*cos(deg2rad(Theta_grid))) * 1e-3; % because the interface is in mm
            end
        end
    end
    
function [center,mse]= phasecenter_find(E_Phase,Theta_axis,Phi_axis,RegionofInterest,logfile,preanalysis)
if preanalysis==0
    fprintf('Phase center estimated position for each element\n');
    fwrite(logfile,sprintf('Phase center estimated position for each element\r\n'));
end
    [NAnt NPol Nfreq] = size(E_Phase);
    [Theta_grid,Phi_grid]= ndgrid(Theta_axis,Phi_axis);
    
    c = 299792458;
    center = cell(NAnt,NPol,Nfreq);
    mse    = cell(NAnt,NPol,Nfreq);
    
    for ifreq = 1:Nfreq
        if preanalysis==0
            display(sprintf('Position of phase center (x, y, z) in mm. Frequency %g GHz',E_Phase{1,1,ifreq}.frequency/1e9));
            fwrite(logfile,sprintf('Position of phase center (x, y, z) in mm. Frequency %g GHz',E_Phase{1,1,ifreq}.frequency/1e9));
        end
        
        lambda = c/E_Phase{1,1,ifreq}.frequency;
        k = 2*pi/lambda;
        
        maxindex = find(Theta_axis>=RegionofInterest);
        phi_grid_ROI = deg2rad(Phi_grid(1:maxindex,:));
        theta_grid_ROI = deg2rad(Theta_grid(1:maxindex,:));
        
        for iPol=1:NPol
            for iAnt =1:NAnt
                phase_ROI = (E_Phase{iAnt,iPol,ifreq}.pattern(1:maxindex,:));
                [center{iAnt,iPol,ifreq},mse{iAnt,iPol,ifreq}] = phaseFrontFit(phase_ROI(:),...
                    theta_grid_ROI(:),phi_grid_ROI(:));
                center{iAnt,iPol,ifreq}  = center{iAnt,iPol,ifreq}/k * 1000; %mm
                mse{iAnt,iPol,ifreq}     = (mse{iAnt,iPol,ifreq}*1000/k)/length(Phi_grid); %mm
               if preanalysis ==0
                    if iAnt ==1 
                        fprintf('Polarization:      %s\n',E_Phase{iAnt,iPol,ifreq}.polarization);
                        fwrite(logfile,sprintf('Polarization:      %s',E_Phase{iAnt,iPol,ifreq}.polarization));
                    end
                    fprintf('Element %d: (%11.2f, %11.2f, %11.2f) (MMSE = %7.2f mm)\n', iAnt,...
                        center{iAnt,iPol,ifreq}(1), ...
                        center{iAnt,iPol,ifreq}(2), ...
                        center{iAnt,iPol,ifreq}(3),...
                        mse{iAnt,iPol,ifreq});
                    fwrite(logfile,sprintf('Element %d: (%11.2f, %11.2f, %11.2f) (MMSE = %7.2f mm) \r\n', iAnt,...
                        center{iAnt,iPol,ifreq}(1), ...
                        center{iAnt,iPol,ifreq}(2), ...
                        center{iAnt,iPol,ifreq}(3),...
                        mse{iAnt,iPol,ifreq}));
                end
            end
        end
    end
    fprintf('\n');
    
% Export MAT data
function exportmat(E_Gain,E_Phase,Theta_grid,Phi_grid,folder)
    prev_fol = cd;
    cd(folder);
    if ~exist('export','file');     mkdir('export'); end    
    cd('export');
    [NAnt NPol Nfreq] = size(E_Phase);
    fprintf('Writing file Gain_and_Phase_Patterns.mat...');
    save(sprintf('Gain_and_Phase_Patterns.mat'),'E_Gain','E_Phase','Theta_grid','Phi_grid','NAnt','NPol','Nfreq');
    fprintf(' Done.\n');
    cd(prev_fol);
    
% AMA Data Reading 
function [E_Gain0,E_Phase0] = read_AMA(folder,NAnt,files,Theta0_axis,Phi0_axis,ch1_flag,ch2_flag,pol1,pol2)
    prev_fol = cd;     
    % the previous folder is loaded to return to the original at the
    % end of the function
    cd(folder);

    NTheta0 = length(Theta0_axis);
    Theta0_start= Theta0_axis(1);
    Theta0_end  = Theta0_axis(NTheta0);
    NPhi0 = length(Phi0_axis);
    Phi0_start  = Phi0_axis(1);
    Phi0_end    = Phi0_axis(NPhi0);
    NPol = ch1_flag + ch2_flag;
    
%     Here we assume we have just one frequency component
    Nfreq=1;
    
    for iAnt = 1:NAnt
        filename_common =files{iAnt}(1:find(files{iAnt}=='.',1,'last')-1);
        files{iAnt} = dir([filename_common '*']);
        files{iAnt} = {files{iAnt}(:).name};    %now files{iAnt} is itself a cell of strings with the filenames;
    end

    if NAnt==4
        if ~isequal(NPhi0,length(files{1}),length(files{2}),...
                length(files{3}),length(files{4}))
            errordlg(['One file is missing, or the amount of files'...
                ,' does not match the number of Phi points given'],'Error');
            cd(prev_fol); error(['One file is missing, or the amount of files'...
                ,' does not match the number of Phi points given']);
        end
    end

   for iAnt = 1:NAnt
        for ifreq = 1:Nfreq
            for iPhi0 = 1:NPhi0

                % "file" is the pointer to the actual opened element of the
                % list "files"
                % Read the first 30 lines to find the
                % beginning of the data
                fprintf('Reading file %s ...\n',files{iAnt}{iPhi0});
                header_text = textread(files{iAnt}{iPhi0}, '%s', 30, 'delimiter', '\n');

                %Scan The line no. 10 with info about Theta0
                [data_read]=textscan(header_text{10},'%*s %f %f %u',1);%,'Headerlines',9);
                Theta0_start_file = data_read{1};
                Theta0_end_file   = data_read{2};
                NTheta0_file      = data_read{3};

                %Check if the number of Theta0 points agree
                if iPhi0 ==1
                    if Theta0_start_file ~= Theta0_start || ...
                            Theta0_end_file ~= Theta0_end || ...
                            NTheta0_file ~= NTheta0;
                        warning('Messdaten_Converter:WrongInput',...
                            'The given Theta points do not coincide with the files. They will be replaced');
                        Theta0_start = Theta0_start_file;
                        Theta0_end = Theta0_end_file;
                        NTheta0 = NTheta0_file;
                    end
                end

                %Scan the line no. 12 for the frequency information.
%                 data_read = textscan(file,'%s',1,'Delimiter','\n','Headerlines',2);
                data_read = textscan(header_text{12},'%s');
                Nfreq = length(data_read{1})-3; %min =1
                freq = data_read{1}{3:2+Nfreq};
                freq = str2double(freq);
                
                if strcmpi(data_read{1}{4},'GHZ')  ;    freq = freq*1e9;
                elseif strcmpi(data_read{1}{4},'MHZ');  freq = freq*1e6;
                elseif strcmpi(data_read{1}{4},'Hz');   freq;
                else
                    errordlg('A frequency scale could not be found.','Error');
                    cd(prev_fol); error('A frequency scale could not be found.');
                end;

                if iAnt ==1 && ifreq ==1 && iPhi0 == 1
                    E_Gain0 = cell(NAnt,NPol,Nfreq);
                    E_Phase0= cell(NAnt,NPol,Nfreq);
                end
    
                index_found = strncmp(header_text, 'BEGIN',5);
                index_found = find(index_found==1);
                clear header_text
                
                % read DATA
                file = fopen(files{iAnt}{iPhi0});
                data_read_ch1 = textscan(file,'%f %f','Delimiter',',','Headerlines',index_found);
                data_read_ch2 = textscan(file,'%f %f','Delimiter',',','Headerlines',2);
                
                data_read_ch1 = data_read_ch1{1} + 1i* data_read_ch1{2};
                data_read_ch2 = data_read_ch2{1} + 1i* data_read_ch2{2};

                clear data_read;
                %check if all the data were read
                if length(data_read_ch1) ~= length(data_read_ch2) || length(data_read_ch1)~=NTheta0
                    errordlg('Not all the data fields were read','Error');
                    cd(prev_fol); error('Not all the data fields were read');
                end
                if NPol==1
                    if ch1_flag==1
                        pol={pol1};
                        data_read={data_read_ch1};
                    elseif ch2_flag==1
                        pol={pol2};
                        data_read={data_read_ch2};
                    end
                elseif NPol ==2
                    pol = {pol1 pol2};
                    data_read = {data_read_ch1 data_read_ch2};
                end

                for iPol = 1:NPol
                    
                    if iPhi0 ==1
                        E_Gain0{iAnt,iPol,ifreq} = struct('type',{'Gain (dB)'},...
                            'element',{iAnt},'polarization',{pol{iPol}},...
                            'frequency',{freq(ifreq)},'pattern',zeros(NTheta0,NPhi0));
                        E_Phase0{iAnt,iPol,ifreq} = struct('type',{'Phase (rad)'},...
                            'element',{iAnt},'polarization',{pol{iPol}},...
                            'frequency',{freq(ifreq)},'pattern',zeros(NTheta0,NPhi0));
                    end
                     E_Phase0{iAnt,iPol,ifreq}.polarization;

                    %The Antenna Pattern is constructed from the 2
                    %column components
                    
                    E_Gain0{iAnt,iPol,ifreq}.pattern(:,iPhi0) = mag2db(abs(data_read{iPol}));
                    E_Phase0{iAnt,iPol,ifreq}.pattern(:,iPhi0) = (angle(data_read{iPol}));
                end
                fclose(file);
            end
        end
    end
    
    cd(prev_fol);
    
function [E_Gain0,E_Phase0,Theta0_axis,files] = read_AMA_individual(folder,files,logfile,copolar_flag,crosspolar_flag)
prev_fol = cd;     
% the previous folder is loaded to return to the original at the
% end of the function
cd(folder);
NAnt=1;
NPol = copolar_flag + crosspolar_flag;

filename_common =files(1:find(files =='.',1,'last')-1);
files = dir([filename_common '*']);
files = {files(:).name};    %now files is itself a cell of strings with the filenames;
Ncuts = length(files); % it shows the number of files present with a common name. This will be replacin the 'freq' index

for icuts = 1:Ncuts
    % "file" is the pointer to the actual opened element of the
    % list "files"
    % Read the first 30 lines to find the
    % beginning of the data
    fprintf('Reading file %s ...',files{icuts});
    fwrite(logfile,sprintf('Reading file %s ...',files{icuts}));
    header_text = textread(files{icuts}, '%s', 30, 'delimiter', '\n');

    %Scan The line no. 10 with info about Theta0
    [data_read]=textscan(header_text{10},'%*s %f %f %u',1);%,'Headerlines',9);
    Theta0_start = data_read{1};
    Theta0_end   = data_read{2};
    NTheta0      = data_read{3};
    Theta0_axis = linspace(Theta0_start,Theta0_end,NTheta0);

    %Scan the line no. 12 for the frequency information.
    data_read = textscan(header_text{12},'%s');
    thisfreq = data_read{1}{3};
    thisfreq = str2double(thisfreq);

    %frequency scale
    if strcmpi(data_read{1}{4},'GHZ')  ;    thisfreq = thisfreq*1e9;
    elseif strcmpi(data_read{1}{4},'MHZ');  thisfreq = thisfreq*1e6;
    elseif strcmpi(data_read{1}{4},'Hz');   thisfreq;
    else
        errordlg('A frequency scale could not be found.','Error');
        cd(prev_fol); error('A frequency scale could not be found.');
    end;

    if icuts ==1
        E_Gain0 = cell(NAnt,NPol,Ncuts);
        E_Phase0= cell(NAnt,NPol,Ncuts);
    end

    index_found = strncmp(header_text, 'BEGIN',5);
    index_found = find(index_found==1);


    % read DATA
    file = fopen(files{icuts});
    data_read_ch1 = textscan(file,'%f %f','Delimiter',',','Headerlines',index_found);
    data_read_ch2 = textscan(file,'%f %f','Delimiter',',','Headerlines',2);

    data_read_ch1 = data_read_ch1{1} + 1i* data_read_ch1{2};
    data_read_ch2 = data_read_ch2{1} + 1i* data_read_ch2{2};

    clear data_read;
    %check if all the data were read
    if length(data_read_ch1) ~= length(data_read_ch2) || length(data_read_ch1)~=NTheta0
        errordlg('Not all the data fields were read','Error');
        cd(prev_fol); error('Not all the data fields were read');
    end
    if NPol==1
        if copolar_flag==1
            pol={'co'};
            data_read={data_read_ch1};
        elseif crosspolar_flag==1
            pol={'cx'};
            data_read={data_read_ch2};
        end
    elseif NPol ==2
        pol = {'co' 'cx'};
        data_read = {data_read_ch1 data_read_ch2};
    end
    
    for iPol = 1:NPol
        E_Gain0{1,iPol,icuts} = struct('type',{'Gain (dB)'},...
            'element',{1},'polarization',{pol{iPol}},...
            'frequency',{thisfreq},'pattern',zeros(NTheta0,1));
        E_Phase0{1,iPol,icuts} = struct('type',{'Phase (rad)'},...
            'element',{1},'polarization',{pol{iPol}},...
            'frequency',{thisfreq},'pattern',zeros(NTheta0,1));
        
        %The Antenna Pattern is constructed from the 2
        %column components
        
        E_Gain0{1,iPol,icuts}.pattern(:) = mag2db(abs(data_read{iPol}));
        E_Phase0{1,iPol,icuts}.pattern(:) = (angle(data_read{iPol}));
    end
    fclose(file);
    fprintf('Done.\n');
    fwrite(logfile,sprintf('Done.\n'));
    
    %Write XLS file
    
    fprintf('Exporting XLS ...');
    fwrite(logfile,sprintf('Exporting XLS ...'));
    
    if ~exist('export','file');     mkdir('export'); end
    cd('export');
    
    %Check whether the xls file is already open or not
    [fid, msg] = fopen(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9)); %#ok<NASGU>
    if fid==-1
%         disp('The excel file does not exist or is already open.');
    else
        fclose(fid);
    end
    
    warning off MATLAB:xlswrite:AddSheet;
    
    %exporting to xls (Windows) has some differences with exporting to
    %cls
    if ispc
        xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
            [header_text(1:index_found)],sprintf('%s',files{icuts}),sprintf('A1:A%d',index_found));
        xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
            {'Angle(°)'},sprintf('%s',files{icuts}),sprintf('A%d',index_found+1));
        xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
            Theta0_axis',sprintf('%s',files{icuts}),sprintf('A%d',index_found+2));
        
        for iPol=1:NPol
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                {sprintf('Real %s',pol{iPol})},sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+1),index_found+1));
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                real(data_read{iPol}),sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+1),index_found+2));
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                {sprintf('Imag. %s',pol{iPol})},sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+2),index_found+1));
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                imag(data_read{iPol}),sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+2),index_found+2));
            
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                {sprintf('Gain %s (dB)',pol{iPol})},sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+3),index_found+1));
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                E_Gain0{1,iPol,icuts}.pattern,sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+3),index_found+2));
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                {sprintf('Phase %s (rad)',pol{iPol})},sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+4),index_found+1));
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                E_Phase0{1,iPol,icuts}.pattern,sprintf('%s',files{icuts}),sprintf('%s%d',char(65+4*(iPol-1)+4),index_found+2));
        end
        %Delete Empty Sheets
        DeleteEmptyExcelSheets(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9));
    elseif icuts ==1;
        errordlg(['You are running in an OS other than Windows.'...
            'It cannot be exported to XLS under another OS.\n'...
            'An CSV with the raw data is being created instead.'], 'ERROR');
        for ii = 1:index_found
            xlswrite(sprintf('%s(%gGHz).xls',files{icuts},thisfreq/1e9),...
                header_text(ii),sprintf('%s',files{icuts}),sprintf('A%d',ii));
            if ii==1;  warning off MATLAB:xlswrite:NoCOMServer; end;
        end
    end
    fprintf('Done.\n');
    fwrite(logfile,sprintf('Done.\n'));
    cd(folder);
end
cd(prev_fol);
    
% % export binary dat 
% The data is arranged as follows:
%   -Theta: 0ï¿½ -> 180ï¿½ rowwise      
%   -Phi:  0ï¿½  -> 360ï¿½ columnwise
%  The elements are equivalently spaced, so the angle distance between them
%   is 180ï¿½/(NTheta-1) for Theta, and 360/(NPhi-1) for Phi. 
function exportdat(E_Pattern,patterntype,NTheta,NPhi,folder)
    [NAnt NPol Nfreq] = size(E_Pattern);
    prev_fol = cd;
    cd(folder);
    if ~exist('export','file');     mkdir('export'); end
    cd('export');
    
    for iAnt = 1:NAnt
        for iPol=1:NPol
            pol= E_Pattern{iAnt,iPol,1}.polarization;
            for ifreq=1:Nfreq
                f=E_Pattern{iAnt,iPol,ifreq}.frequency;
                fid = fopen(sprintf('%s_element%d_%s_%gGHz_-_NTheta%g-NPhi%g.dat',patterntype,iAnt,pol,f,NTheta,NPhi),'wb');
                fprintf('Writing file %s_element%d_%s_%gGHz_-_NTheta%g-NPhi%g.dat...\n',patterntype,iAnt,pol,f,NTheta,NPhi);
                fwrite(fid,E_Pattern{iAnt,iPol,ifreq}.pattern,'double'); %FIXME adjust precision and Machine format.
                fclose(fid);
            end
        end
    end
    cd(prev_fol);
    

% % export xls data
function exportxls(E_Pattern,Theta_axis,Phi_axis,patterntype,folder)
fprintf('Excel XLS exporter running...\n');
NTheta = length(Theta_axis);
NPhi = length(Phi_axis);
[NAnt NPol Nfreq] = size(E_Pattern);

%Create new coordinates order
Theta0_axis = [-fliplr(Theta_axis(2:NTheta)) Theta_axis];
Phi0_axis = Phi_axis(1:ceil(NPhi/2));
NPhi0 = length(Phi0_axis);
NTheta0 = length(Theta0_axis);

%Create labels for writing into each cell in the excel file
Theta0_label = cell(1,NTheta0);
Phi0_label = cell(1,NPhi0);

for k=1:NTheta0
    Theta0_label(k) = {sprintf('theta = %g', Theta0_axis(k))};
end
for k =1:NPhi0
    Phi0_label(k) =  {sprintf('phi = %g', Phi0_axis(k))};
end
Theta0_label = Theta0_label';

%Create or move to the export directory
prev_fol = cd;
cd(folder);
if ~exist('export','file');     mkdir('export'); end
cd('export');

for iAnt = 1:NAnt
    for iPol=1:NPol
        pol=E_Pattern{iAnt,iPol,1}.polarization;
        
        %Check whether the xls file is already open or not
        [fid, msg] = fopen([folder, filesep,sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol)]); %#ok<NASGU>
        if fid==-1
            disp('The excel file does not exist or is already open.');
        else
            fclose(fid);
            disp(['The file ',sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol),' has been created.']);
        end
        
        warning off MATLAB:xlswrite:AddSheet
        
        fprintf('    Writing %s for element %d, %s...\n',patterntype,iAnt,pol);
        
        for ifreq=1:Nfreq
            f= E_Pattern{iAnt,iPol,ifreq}.frequency;
            m1 = E_Pattern{iAnt,iPol,ifreq}.pattern(:,1:ceil(NPhi/2));
            m2 = E_Pattern{iAnt,iPol,ifreq}.pattern(2:NTheta,1:ceil(NPhi/2));
            iPattern = [flipud(m2);m1];
            %save Pattern
            xlswrite(sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol),...
                {sprintf('%s, Element %d. %s.',patterntype,iAnt,pol)},sprintf('f = %gGHz',f/1e9),'A1');
            warning off MATLAB:xlswrite:NoCOMServer
            xlswrite(sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol),...
                Phi0_label,sprintf('f = %gGHz',f/1e9),sprintf('B2'));
            %exporting to xls (Windows) has some differences with exporting to cls
            if ispc
                xlswrite(sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol),...
                    Theta0_label,sprintf('f = %gGHz',f/1e9),sprintf('A3:A%d',2+NTheta0));
            else
                if iAnt ==1; errordlg(['You are running in an OS other than Windows.'...
                        'It cannot be exported to XLS under another OS.\n'...
                        'An CSV with the raw data is being created instead.'], 'ERROR');
                    for ii = 1:NTheta0
                        xlswrite(sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol),...
                            Theta0_label(ii),sprintf('f = %gGHz',f/1e9),sprintf('A%d',2+ii));
                    end
                end
            end
            xlswrite(sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol),...
                iPattern,sprintf('f = %gGHz',f/1e9),'B3');
            
            %Delete Empty Sheets
            if ispc
                DeleteEmptyExcelSheets(sprintf('%s_element%d_%s.xls',patterntype,iAnt,pol));
                fprintf('%s_element%d_%s.xls succesfully written.\n',patterntype,iAnt,pol)
            else
                fprintf('%s_element%d_%s.csv succesfully written.\n',patterntype,iAnt,pol)
            end
        end
    end
end
cd(prev_fol);

% % Create  2d cuts of Pattern (Gain or Phase)
function plotcuts(E_Pattern,patterntype,Theta_axis,Phi_axis,folder,save_flag)
NPhi  = length(Phi_axis);
[NAnt NPol Nfreq] = size(E_Pattern);
index_Thetamax = find(Theta_axis <= 90,1,'last');
Theta0_axis =  Theta_axis(2:index_Thetamax);
Theta0_axis = [-fliplr(Theta0_axis) 0 Theta0_axis]; % construct the -90 ->90 degrees axis
for iAnt=1:NAnt
    for iPol = 1:NPol
        pol = E_Pattern{iAnt,iPol,1}.polarization;
        for ifreq = 1:Nfreq
            f = E_Pattern{iAnt,iPol,ifreq}.frequency;
            hPlot   = figure('Name', sprintf('%s Pattern Cuts for element %g, Pol %s, freq %gGHz', patterntype, iAnt, pol, f/1e9));
            for cut=0:3
                m1 = E_Pattern{iAnt,iPol,ifreq}.pattern(1:index_Thetamax,floor(cut*NPhi/8)+1);
                m2 = E_Pattern{iAnt,iPol,ifreq}.pattern(2:index_Thetamax,floor(cut*NPhi/8)+1 + ceil(NPhi/2));
                cut_pattern = [flipud(m2);m1];
                %plot the cut
                subplot(4,1,cut+1)
                plot(Theta0_axis,cut_pattern);
                title(sprintf('%s pattern cut for \\phi =  %dÂ°',patterntype, Phi_axis(floor(cut*NPhi/4)+1)),'FontName','Times','FontSize',13);
                axis tight;  xlabel('\theta (degrees)','FontName','Times','FontSize',12) ; grid on;
                ylabel(patterntype,'FontName','Times','FontSize',12);
            end
            %make the window size bigger
            h = get(gcf,'Position');
            h(2) = 0;
            h(4) = 1000; set(gcf,'Position',h);
            if save_flag
                %Just change the name from 'Gain (dB)' to 'Gain' (or Phase)
                if ~isempty(findstr(patterntype,'Gain')); patterntype = 'Gain';
                elseif ~isempty(findstr(patterntype,'Phase')); patterntype = 'Phase'; end
                %save previouse folder and write plots into 'folder'
                prev_fol = cd;
                cd(folder);
                if ~exist('plots','file');     mkdir('plots'); end
                cd('plots');
                hgsave(hPlot, sprintf('%s_cuts_%s_Element%d_-_%gGHz.fig',patterntype,pol,iAnt,f/1e9));
                print(hPlot, '-dpng', sprintf('%s_cuts_%s_Element%d_-_%gGHz.png',patterntype,pol,iAnt,f/1e9));
                cd(prev_fol);
            end
        end
    end
end
    

% % Create 2d individual cuts
function plotcuts_individual(E_Pattern,patterntype,Theta0_axis,folder,filenames,save_flag)
[NAnt NPol Ncuts] = size(E_Pattern);

for iAnt=1:NAnt
    for iPol = 1:NPol
        pol = E_Pattern{iAnt,iPol,1}.polarization;
        for icuts = 1:Ncuts
            f = E_Pattern{iAnt,iPol,icuts}.frequency;
            hPlot   = figure('Name', sprintf('%s diagram - %s - freq %gGHz', patterntype, pol, f/1e9));
            %plot the cut
            
            plot(Theta0_axis,unwrap(E_Pattern{iAnt,iPol,icuts}.pattern));
            title(sprintf('%s-%s-%gGHz', patterntype, pol, f/1e9),'FontName','Times','FontSize',13);
            axis tight;  xlabel('\theta (degrees)','FontName','Times','FontSize',12) ; grid on;
            ylabel(patterntype,'FontName','Times','FontSize',12);
            
            %make the window size bigger
             h = get(gcf,'Position');
             h(3) = 800;
             h(4) = 300; set(gcf,'Position',h);
            if save_flag
                %Just change the name from 'Gain (dB)' to 'Gain' (or Phase)
                if ~isempty(findstr(patterntype,'Gain')); patterntype_2 = 'Gain';
                elseif ~isempty(findstr(patterntype,'Phase')); patterntype_2 = 'Phase'; end
                %save previouse folder and write plots into 'folder'
                prev_fol = cd;
                cd(folder);
                if ~exist('plots','file');     mkdir('plots'); end
                cd('plots');
                hgsave(hPlot, sprintf('%s%s_%s_%gGHz.fig',filenames{icuts},patterntype_2,pol,f/1e9));
                print(hPlot, '-dpng', sprintf('%s%s_%s_%gGHz.png',filenames{icuts},patterntype_2,pol,f/1e9));
                cd(prev_fol);
                close(hPlot);
            end
        end
    end
end

%%Create 3D Gain Pattern Graph
function plot3D(E_Gain,Theta_grid,Phi_grid,folder,save_flag)
%bias all the patterns to be fully positive

[t,f] = ndgrid(0:180,0:360); %Grid made for interpolation - 3D plot every 1 degree
[NAnt NPol Nfreq] = size(E_Gain);

for iAnt =  1:NAnt
    for  iPol = 1:NPol
        min_Gain= 0;
        for ifreq = 1:Nfreq
            min_Gain = min(min_Gain,min(min(db2mag(E_Gain{iAnt,iPol,ifreq}.pattern)))); %take the min for each element
            iPattern = db2mag(E_Gain{iAnt,iPol,ifreq}.pattern) - min_Gain;
            %     Create grid interpolation for 3Dplotting
            a=griddata(Theta_grid,Phi_grid,iPattern,t,f,'linear');
            x=a.*sin(deg2rad(t)).*cos(deg2rad(f));
            y=a.*sin(deg2rad(t)).*sin(deg2rad(f));
            z=a.*cos(deg2rad(t));
            hPlot   = figure('Name', sprintf('3D Gain Pattern, %s, element %d, %g GHz', ...
                E_Gain{iAnt,iPol,ifreq}.polarization,iAnt,E_Gain{iAnt,iPol,ifreq}.frequency/1e9));
            surf(x,y,z,a); title(sprintf('3D Gain Pattern, %s, element %d, %g GHz', ...
                E_Gain{iAnt,iPol,ifreq}.polarization,iAnt,E_Gain{iAnt,iPol,ifreq}.frequency/1e9));
            xlabel('x'); ylabel('y'); axis equal; axis vis3d;
            campos([5 5 5]); colorbar
            
            %------------------------Plot 3d axis arrows------------------------------%
            xmax = xlim; xmax = xmax(2)*1.3;
            ymax = ylim; ymax = ymax(2)*1.3;
            zmax = zlim; zmax = zmax(2)*1.3;
            %define the width of the arrow
            linewidth = 0.01;
            tiplong   = 0.1;
            % create the arrow cylinder
            [xc,yc,zc] = cylinder(linewidth);
            % make the cylinder a little bit shorter
            zc = (1-tiplong)*zc;
            %make the tip of the arrow
            [xt,yt,zt] = cylinder(linewidth*3 - 0:0.5:1 *3*linewidth);
            % make the arroy tip even shorter than the cylinder
            zt = tiplong*zt;
            % unite the 2 parts
            xa = [xc; xt];
            ya = [yc; yt];
            za = [zc; zt + (1-tiplong)];
            
            hold on;
            
            %Plot arrow x
            hArrow = surf(za*xmax,ya,xa);
            set(hArrow, 'facecolor', [1 0 0] , 'edgecolor', 'none', ...
                'diffuseStrength', 0.5, 'AmbientStrength',0.5, ...
                'SpecularStrength', 1,...
                'meshstyle', 'row')
            %Plot arrow y
            hArrow = surf(ya,za*ymax,xa);
            set(hArrow, 'facecolor', [0 1 0] , 'edgecolor', 'none', ...
                'diffuseStrength', 0.5, 'AmbientStrength',0.5, ...
                'SpecularStrength', 1,...
                'meshstyle', 'row')
            %Plot arrow z
            hArrow = surf(xa,ya,za*zmax);
            set(hArrow, 'facecolor', [0 0 1], 'edgecolor', 'none', ...
                'diffuseStrength', 0.5, 'AmbientStrength',0.5, ...
                'SpecularStrength', 1,...
                'meshstyle', 'row')
            %-------------------------------------------------------------------------%
            if save_flag
                prev_fol = cd;
                cd(folder);
                if ~exist('plots','file');     mkdir('plots'); end
                cd('plots');
                hgsave(hPlot, sprintf('3D_Gain_%s_element%d_%gGHz.fig', ...
                E_Gain{iAnt,iPol,ifreq}.polarization,iAnt,E_Gain{iAnt,iPol,ifreq}.frequency/1e9));
                print(hPlot, '-dpng', sprintf('3D_Gain_%s_element%d_%gGHz.png', ...
                E_Gain{iAnt,iPol,ifreq}.polarization,iAnt,E_Gain{iAnt,iPol,ifreq}.frequency/1e9));
                cd(prev_fol);
            end
        end
    end
end

% Create Gain ColorPlot
function plot2DGain(E_Gain,Theta_grid,Phi_grid,folder,save_flag)
[NAnt,NPol,Nfreq] = size(E_Gain);
plot_order  = [3 4 1 2];
NTheta = size(Theta_grid,1);
for iPol= 1:NPol
    for ifreq = 1:Nfreq
        f = E_Gain{1,iPol,ifreq}.frequency;
        pol = E_Gain{1,iPol,ifreq}.polarization;
        hPlot   = figure('Name', sprintf('Gain Patterns, polarization %s, frequency %g GHz',...
            pol,f/1e9));
        vCaxis  = [-20, 0];
        for iAnt = 1:NAnt
            subplot(2,2,plot_order(iAnt))
            colorBarText = '';
            titleText    = sprintf('element %d', iAnt);
            flagPlotColorBar = true;
            makeContourPlot(Theta_grid(1:ceil(NTheta/2), :), Phi_grid(1:ceil(NTheta/2), :), ...
            E_Gain{iAnt,iPol,ifreq}.pattern(1:ceil(NTheta/2), :), ...
            flagPlotColorBar, colorBarText, titleText, vCaxis );
        end
        
        if save_flag
            prev_fol = cd;
            cd(folder);
            if ~exist('plots','file');     mkdir('plots'); end
            cd('plots');
            hgsave(hPlot, sprintf('Gain_%s_%gGHz.fig',pol,f/1e9));
            print(hPlot, '-dpng', sprintf('Gain_%s_%gGHz.png',pol,f/1e9));
            cd(prev_fol);
        end
    end
end



%% Create Phase Plot
function plot2DPhase(E_Phase,Theta_grid,Phi_grid,folder,save_flag)
[NAnt,NPol,Nfreq] = size(E_Phase);
plot_order  = [3 4 1 2];
NTheta = size(Theta_grid,1);
for iPol= 1:NPol
    for ifreq = 1:Nfreq
        f = E_Phase{1,iPol,ifreq}.frequency;
        pol = E_Phase{1,iPol,ifreq}.polarization;
        hPlot   = figure('Name', sprintf('Phase Patterns, polarization %s, frequency % GHz',...
            pol,f));
        
        for iAnt = 1:NAnt
            subplot(2,2,plot_order(iAnt))
            colorBarText = '';
            titleText    = sprintf('element %d', iAnt);
            flagPlotColorBar = true;
            makeContourPlot(Theta_grid(1:ceil(NTheta/2), :), Phi_grid(1:ceil(NTheta/2), :), ...
                rad2deg(E_Phase{iAnt,iPol,ifreq}.pattern(1:ceil(NTheta/2), :)), flagPlotColorBar, colorBarText, titleText);
        end
        if save_flag
            prev_fol = cd;
            cd(folder);
            if ~exist('plots','file');     mkdir('plots'); end
            cd('plots');
            hgsave(hPlot,  sprintf('Phase_%s_%gGHz.fig',pol,f/1e9));
            print(hPlot, '-dpng', sprintf('Phase_%s_%gGHz.png',pol,f/1e9));
            cd(prev_fol);
        end
    end
end

% % Normalize Gain Patterns
function E_Pattern = normalize(E_Pattern)
max_Gain_dB = -60;
[NAnt NPol Nfreq] = size(E_Pattern);
for iAnt = 1 : NAnt
    for iPol = 1:NPol
        for ifreq = 1:Nfreq
    max_Gain_dB = max(max_Gain_dB,max(max(E_Pattern{iAnt,iPol,ifreq}.pattern))); %take the max between all the Antennas
        end
    end
end
% perform normalisation:
for iAnt = 1 : NAnt
    for iPol =1:NPol
        for ifreq = 1:Nfreq
    E_Pattern{iAnt,iPol,ifreq}.pattern = E_Pattern{iAnt,iPol,ifreq}.pattern - max_Gain_dB;
        end
    end
end


% % Correct Phase Pattern
function E_Phase = correctPhase(E_Phase,d_elements,Theta_grid,Phi_grid,pos_Phase_ref,phasetrend_flag)
[NAnt NPol Nfreq] = size(E_Phase);
%% Create Phase Patterns
%Create the phase reference point in the middle of the structure.
% pos_Phase_ref = 0.5* [d_elements d_elements];
    c = 299792458;        % speed of light [m/s]
%The position of each Antenna element
pos = {[-0.5 -0.5]*d_elements, [0.5 -0.5]*d_elements, [-0.5 0.5]*d_elements, [0.5 0.5]*d_elements};

%% Array Factor Correction
% remove the phase factor due to phase reference lying not
% in the center of the element
%the phase shift regarding the position should be substracted
for iAnt = 1:NAnt
    dx  = pos{iAnt}(1) - pos_Phase_ref(1);
    dy  = pos{iAnt}(2) - pos_Phase_ref(2);    
    
    for ifreq = 1:Nfreq
                    lambda=c/E_Phase{iAnt,1,ifreq}.frequency;
        for iPol = 1:NPol
            E_Phase{iAnt,iPol,ifreq}.pattern = E_Phase{iAnt,iPol,ifreq}.pattern - ...
                (2*pi/lambda).* ...
                ( dx*cos(deg2rad(Phi_grid)) + dy*sin(deg2rad(Phi_grid) ) ).* ...
                sin(deg2rad(Theta_grid));
        end
    end
    
end
[NTheta,NPhi]=size(Theta_grid);
%% Phase Unwrapping
% 
for iAnt = 1:NAnt
    for iPol = 1:NPol
        for ifreq = 1:Nfreq
            %     Algorithm cunwrap is not working in versions of matlab previous to
            %     R2009a. So we use the 1D approach
            % remove pi-jumps
            for iTheta = 1 : NTheta
                E_Phase{iAnt,iPol,ifreq}.pattern(iTheta, :) = ...
                    unwrap( E_Phase{iAnt,iPol,ifreq}.pattern(iTheta, :));
            end
            
            for iPhi = 1 : NPhi
                E_Phase{iAnt,iPol,ifreq}.pattern(:, iPhi) = ...
                    unwrap( E_Phase{iAnt,iPol,ifreq}.pattern(:, iPhi) );
            end
            
            for iTheta = 1 : NTheta
                E_Phase{iAnt,iPol,ifreq}.pattern(iTheta, :) = ...
                    unwrap( E_Phase{iAnt,iPol,ifreq}.pattern(iTheta, :) );
            end
            
            for iPhi = 1 : NPhi
                E_Phase{iAnt,iPol,ifreq}.pattern(:, iPhi) = ...
                    unwrap( E_Phase{iAnt,iPol,ifreq}.pattern(:, iPhi) );
            end
        end
    end
end
%% Phase Trend correction
%It depends of the kind of polarization
if phasetrend_flag ==1
for iPol = 1:NPol
    %Just thefirst element will be compared, that means the structures
    % preserve the polarization along dimension iPol
    if strcmp(E_Phase{1,iPol,1}.polarization,'RHCP')
        for iAnt=1:NAnt
            for ifreq=1:Nfreq
                E_Phase{iAnt,iPol,ifreq}.pattern = E_Phase{iAnt,iPol,ifreq}.pattern +  deg2rad(Phi_grid);
            end
        end
    elseif strcmp(E_Phase{1,iPol,1}.polarization,'LHCP')
        for iAnt=1:NAnt
            for ifreq=1:Nfreq
                E_Phase{iAnt,iPol,ifreq}.pattern = E_Phase{iAnt,iPol,ifreq}.pattern -  deg2rad(Phi_grid);
            end
        end
    end
end
end
%% Phase Measurement method correction
%intends to correct the measurements made along Phi, in cases in which the
%hemisphere was measured from Theta =-180 to Theta0=180. It means that in
%Phi=0ï¿½ and Phi =180ï¿½ there are Phase discontinuities because of the
%measuring antenna orientation.

% Since the halfs are already shifted by +-pi, it does not make a difference
% to shift it by  + or -pi to correct it. Here we just mind the wrapping.
for iAnt = 1:NAnt
    for iPol = 1:NPol
        for ifreq = 1:Nfreq
            if abs(mean(E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2)) - ...
                    E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2)-1))) > 0.8*pi; %tolerance
                
                if norm(E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2))+ pi - ...
                        E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2)-1)) > ...
                        norm(E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2))- pi -...
                        E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2)-1));
                    
                    E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2):NPhi) = ...
                        E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2):NPhi) - pi ;
                else
                    E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2):NPhi) = ...
                        E_Phase{iAnt,iPol,ifreq}.pattern(:,ceil(NPhi/2):NPhi) + pi ;
                end
            end
        end
    end    
end

%% Phase reference elements to the phase in the broadside of element 1
for iAnt = 1 : NAnt
    for iPol = 1:NPol
        for ifreq = 1:Nfreq
            E_Phase{iAnt,iPol,ifreq}.pattern = ...
                E_Phase{iAnt,iPol,ifreq}.pattern - E_Phase{1,iPol,ifreq}.pattern(1,1);
        end
    end
end




%% Convert coordinates from Theta0, Phi0 to Theta, Phi
function [E_Pattern,Theta_axis,Phi_axis]=coord_converter(E_Pattern0,Theta0_axis,Phi0_axis)
    
[NAnt NPol Nfreq] = size(E_Pattern0);
NTheta0 = length(Theta0_axis);
Theta0_start= Theta0_axis(1);    
Theta0_end  = Theta0_axis(NTheta0);
NPhi0 = length(Phi0_axis);
Phi0_start  = Phi0_axis(1);    
Phi0_end    = Phi0_axis(NPhi0);

%We make this transformation for every Pattern in the cell array
%along the Theta dimension
if Theta0_start ~= 0
    index_Thetastart = find(Theta0_axis==0,1);
    if index_Thetastart == ceil(NTheta0/2) && abs(Phi0_start-Phi0_end)==180      
        for iAnt = 1:NAnt
            for iPol = 1:NPol
                for ifreq = 1:Nfreq
                    m1 = E_Pattern0{iAnt,iPol,ifreq}.pattern(       1         : ceil(NTheta0/2)  , 1  : NPhi0  );
                    m2 = E_Pattern0{iAnt,iPol,ifreq}.pattern( ceil(NTheta0/2) : NTheta0          , 1  : NPhi0-1);                    
                    E_Pattern0{iAnt,iPol,ifreq}.pattern =[m2,flipud(m1)];
                end
            end
        end
        m2 = Theta0_axis(index_Thetastart:NTheta0);
        Theta_axis = m2;
        Phi_axis = [Phi0_axis 180+Phi0_axis(2:NPhi0)];
    else
        errordlg('Transformation of Pattern coordinates arrangement did not find a useful conversion method.','Error');
        error('Transformation of Pattern coordinates arrangement did not find a useful conversion method.');
    end
    
    %Along the Phi dimension (e.g. for the Fraunhoffer case)
elseif Phi0_start ~=0
    index_Phistart = find(Phi0_axis==0,1);
    %this is the case when Phi begins for example at -180 and ends at +180
    %degrees
    if abs(Phi0_start-Phi0_end) ==360
        for iAnt = 1:NAnt
            for iPol = 1:NPol
                for ifreq = 1:Nfreq
                    m1 = E_Pattern0{iAnt,iPol,ifreq}.pattern( : , 1  : index_Phistart);
                    m2 = E_Pattern0{iAnt,iPol,ifreq}.pattern( : , index_Phistart :NPhi0-1);                    
                    E_Pattern0{iAnt,iPol,ifreq}.pattern =[m2,m1];
                end
            end
        end
        m1 = Phi0_axis(1:index_Phistart);
        m2 = Phi0_axis(index_Phistart:NPhi0-1);
        Phi_axis = [m2,360+m1];
        Theta_axis =Theta0_axis;
    else
        for iAnt = 1:NAnt
            for iPol = 1:NPol
                for ifreq = 1:Nfreq
                    m1 = E_Pattern0{iAnt,iPol,ifreq}.pattern( : , 1  : index_Phistart);
                    m2 = E_Pattern0{iAnt,iPol,ifreq}.pattern( : , index_Phistart :NPhi0);
                    E_Pattern0{iAnt,iPol,ifreq}.pattern =[m2,m1];
                end
            end
        end
        m1 = Phi0_axis(1:index_Phistart);
        m2 = Phi0_axis(index_Phistart:NPhi0);
        Phi_axis = [m2,180+m1];
        Theta_axis =Theta0_axis;
    end
else Phi_axis = Phi0_axis;     
     Theta_axis=Theta0_axis;

end   
E_Pattern = E_Pattern0;
%Number of points created in the new coordinate system
NTheta = length(Theta_axis);
NPhi = length(Phi_axis);



%OBSOLETE!!!!!!!
%make the inverse operation of the previous function. See details of the
%conversion on the previous function coord_converter
% function [E_Pattern0,NPhi0,NTheta0]=coord_converter_inv(E_Pattern,NAnt,NPhi,NTheta)
%     E_Pattern0 = cell(1,4);
%     
%     for iAnt = 1:NAnt
%     m2 = E_Pattern{iAnt}( 1 : NTheta  ,       1      : ceil(NPhi/2)   );
%     m1 = E_Pattern{iAnt}( 2 : NTheta  , ceil(NPhi/2) :    NPhi        );
%     
%     E_Pattern0{iAnt} =[flipud(m1);m2];
%     end
% 
% %Number of points created in the new coordinate system
% NTheta0 = (2*NTheta)-1;
% NPhi0   = ceil(NPhi/2);
% 
% if (NTheta0 ~= size(E_Pattern0{1},1) || NPhi0 ~= size(E_Pattern0{1},2))
%     err = MException('SizeChk:Incongruent','Size of the calculated Matrices are not consisting');
%     throw(err);
%     return %#ok<*UNRCH>
% end


%%%%%%%%%%%%%%%%%%%%%%ANDEREN CODE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% phaseFrontFit  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Andriy Konovaltsev%%%%%%%%

function [coeff, residuals] = phaseFrontFit(phase, theta, phi)
% Find least squares fit of a spheric phase front 
% to a set of phase data by solving the following 
% overdetermined system of normal equations,
% 
% A*cos(phi)*sin(theta) + B*cos(phi)*sin(theta) + C*cos(theta) + D = Phase(theta, phi)
%
% The least squares coordinates of the antenna phase center are
% [x, y, z] = [A/k, B/k, C/k], 
%              where k is the wavenumber, k = 2*pi/lambda
% D = ph0 is the initial carrier phase of the signal
%
% USAGE:
%    [coeff, residuals] = phaseFrontFit(phase, theta, phi)
%
% INPUTS:
%   phase   = vector of phase data points (samples of the antenna phase pattern), [radian] 
%   theta   = vector of values of the elevation angle which correspond to 
%             the phase data points above, the elevation angles is counted
%             from Z-axis, [radian]
%   phi     = vector of values of azimuth angle corresponding to phase
%             data, [radian]
%               
% OUTPUTS:
%   coeff       = LMS-resolved coefficients of phase front equation
%   residuals   = LMS residuals, a quality metric of the obtained fit

% A. Konovaltsev, DLR
% 05 Apr 2007

error( nargchk(3, 3, nargin) );     % check input arguments
error( nargchk(2, 2, nargout) );     % check input arguments

if ( ~isequal( length(phase), ...
               length(theta), ...
               length(phi)) )      % same length ?
    error('Input vectors must be same length');
end

% force column vectors  
phase   = phase(:);
theta   = theta(:);
phi     = phi(:);


% solve linear system of normal equations
A = [ -cos(phi).*sin(theta), ...
      -sin(phi).*sin(theta), ...
      -cos(theta), ...
      ones(size(theta)) ];
b = phase;
%a = A \ b;
a = pinv(A)*b;

% return center coordinates and sphere radius
coeff       = a;
residuals   = sqrt( sum( (A*a - b).^2 ) );
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% DeleteEmptyExcelSheets  %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Torsten Jacobsen%%%%%%%%%%
% DeleteEmptyExcelSheets: deletes all empty sheets in an xls-file
%
%==========================================================================
% Version : 1.0
% Author : hnagel
% Date : 27/04/2007
% Tested : 02/05/2007 (DR)
%==========================================================================
%
% This function looped through all sheets and deletes those sheets that are
% empty. Can be used to clean a newly created xls-file after all results
% have been saved in it.
%
% References: Torsten Jacobsen, "delete standard excel sheet"
%---------------------------------------------------------------------
%
% Input:
%
% fileName: name of xls file
%
%---------------------------------------------------------------------
%
% Output:
%
% none
%
%---------------------------------------------------------------------
%
% See also XLSWRITE
%---------------------------------------------------------------------
% Changes
%---------------------------------------------------------------------
%
% Name :
% Date :
% Description:
% Indicated :
function DeleteEmptyExcelSheets(fileName)
% Check whether the file exists
if ~exist(fileName,'file')
error([fileName ' does not exist !']);
else
% Check whether it is an Excel file
typ = xlsfinfo(fileName);
if ~strcmp(typ,'Microsoft Excel Spreadsheet')
error([fileName ' not an Excel sheet !']);
end
end

% If fileName does not contain a "\" the name of the current path is added
% to fileName. The reason for this is that the full path is required for
% the command "excelObj.workbooks.Open(fileName)" to work properly.
if isempty(strfind(fileName,'\'))
fileName = [cd '\' fileName];
end

excelObj = actxserver('Excel.Application');
excelWorkbook = excelObj.workbooks.Open(fileName);
worksheets = excelObj.sheets;
sheetIdx = 1;
sheetIdx2 = 1;
numSheets = worksheets.Count;
% Prevent beeps from sounding if we try to delete a non-empty worksheet.
excelObj.EnableSound = false;

% Loop over all sheets
while sheetIdx2 <= numSheets
% Saves the current number of sheets in the workbook
temp = worksheets.count;
% Check whether the current worksheet is the last one. As there always
% need to be at least one worksheet in an xls-file the last sheet must
% not be deleted.
if or(sheetIdx>1,numSheets-sheetIdx2>0)
% worksheets.Item(sheetIdx).UsedRange.Count is the number of used cells.
% This will be 1 for an empty sheet. It may also be one for certain other
% cases but in those cases, it will beep and not actually delete the sheet.
if worksheets.Item(sheetIdx).UsedRange.Count == 1
worksheets.Item(sheetIdx).Delete;
end
end
% Check whether the number of sheets has changed. If this is not the
% case the counter "sheetIdx" is increased by one.
if temp == worksheets.count;
sheetIdx = sheetIdx + 1;
end
sheetIdx2 = sheetIdx2 + 1; % prevent endless loop...
end
excelObj.EnableSound = true;
excelWorkbook.Save;
excelWorkbook.Close(false);
excelObj.Quit;
delete(excelObj);
return;     
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%MAKECONTOURPLOT ALGORITHM%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Andriy Konovaltsev%%%%%%%%%%%
function makeContourPlot( THETA, PHI, Z, flagDoColorBar, colorBarText, titleText, vCaxis )
% Plotting an antenna radiation/reception pattern on a 
% contour plot
%
% Inputs:
%       THETA   = grazing angle data 
%                   (i.e. elevation counted from the broadside or z-axis) 
%                   [degree]
%       PHI     = azimuth angle data [degree]
%       Z       = amplitude/gain corresponding to THETA&PHI
%                   THETA, PHI, Z shall be of [nTheta, nPhi] size
%                   Only the upper hemisphere is to be plotted, so 
%                   0<= theta <= 90
%                   0<= phi <= 360
%       flagDoColorBar = flag {true, false} indicating whether 
%                           the colorbar is required
%       colorBarText, titleText = corresponding text fields
%       vCaxis  = 2-element vector of [minValue, maxValue] to be used
%                   with caxis command to format the colorbar
%
% A. Konovaltsev, DLR
% Last modified 19-Aug-2009

deg2rad = pi/180;
if (~exist('flagDoColorBar', 'var'))
    flagDoColorBar = false;
end

%--- Make countour plot of antenna gain -----------------------------------
R       = THETA / 90;
PHI     = PHI * deg2rad;
[X, Y]  = pol2cart(PHI, R);
pcolor(X, Y, Z);
axis equal
axis off
shading interp;
if flagDoColorBar
    hClrBar = colorbar;
end
if ( exist('titleText', 'var') )
    title( titleText )
end
if ( exist('vCaxis', 'var') )
    caxis(vCaxis);
end

hold on

%--- plotting axis lines ----------------------------------------------
theta0  = [0, 30, 60] * pi/180;
phi0    = (0: 1: 360) * pi/180;
for k = 1:length(theta0)
    r   = (pi/2 - theta0(k))/(pi/2);
    plot(r*cos(phi0), r*sin(phi0), 'k');
end

r   = 1/3;
text( 0, r, ...
      ' 60\circ', ...
      'FontSize', 10, ...
      'VerticalAlignment', 'Baseline', ...
      'HorizontalAlignment', 'Left' )

r   = 2/3;
text( 0, r, ...
      ' 30\circ', ...
      'FontSize', 10, ...
      'VerticalAlignment', 'Baseline', ...
      'HorizontalAlignment', 'Left' )
  
phi0 = [0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330] * pi/180;
theta0 = (0: 20: 180) * pi/180;
for k=1:length(phi0)
    r = (pi/2 - theta0)/(pi/2);
    plot(r*cos(phi0(k)), r*sin(phi0(k)), 'k');
end

phi0    = 0;
text( cos(phi0), sin(phi0), ...
     [' ', num2str(phi0), '\circ'], 'FontSize', 10 )
 
phi0    = 30;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [' ', num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Baseline' )

phi0    = 60;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [' ', num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Baseline' )

phi0    = 120;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Baseline', ...
     'HorizontalAlignment', 'Right' )

phi0    = 150;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Baseline', ...
     'HorizontalAlignment', 'Right' )

phi0    = 180;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ '], 'FontSize', 10, ...
     'VerticalAlignment', 'Middle', ...
     'HorizontalAlignment', 'Right' )

phi0    = 210;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Top', ...
     'HorizontalAlignment', 'Right' )

phi0    = 240;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Top', ...
     'HorizontalAlignment', 'Right' )
 
phi0    = 270;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Top', ...
     'HorizontalAlignment', 'Center' )
 
phi0    = 300;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Top', ...
     'HorizontalAlignment', 'Left' )
 
phi0    = 330;
text( cos(phi0*deg2rad), sin(phi0*deg2rad), ...
     [num2str(phi0), '\circ'], 'FontSize', 10, ...
     'VerticalAlignment', 'Top', ...
     'HorizontalAlignment', 'Left' )

if ( flagDoColorBar && exist('colorBarText', 'var') )
    if ( ~isempty(colorBarText) )
        YTicks = get(hClrBar, 'YTick');
        YTickLabels     = cell(1, length(YTicks));  
        for iTick = 1 : length(YTicks)
            YTickLabels{iTick} = num2str(YTicks(iTick));
        end
        YTickLabels{iTick} = [YTickLabels{iTick}, ' ', colorBarText];
        set(hClrBar, 'YTickLabel', YTickLabels)
    end
end
hold off

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                     888                    
%                                                     888                    
%                                                     888                    
%  .d8888b .d88b.  88888b.  888  888  .d88b.  888d888 888888 .d88b.  888d888 
% d88P"   d88""88b 888 "88b 888  888 d8P  Y8b 888P"   888   d8P  Y8b 888P"   
% 888     888  888 888  888 Y88  88P 88888888 888     888   88888888 888     
% Y88b.   Y88..88P 888  888  Y8bd8P  Y8b.     888     Y88b. Y8b.     888     
%  "Y8888P "Y88P"  888  888   Y88P    "Y8888  888      "Y888 "Y8888  888    
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

% --- Executes on button press in ch1_flag.
function ch1_flag_Callback(hObject, eventdata, handles)
% hObject    handle to ch1_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch1_flag


% --- Executes on button press in ch2_flag.
function ch2_flag_Callback(hObject, eventdata, handles)
% hObject    handle to ch2_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ch2_flag


% --- Executes on selection change in ch1_pol.
function ch1_pol_Callback(hObject, eventdata, handles)
% hObject    handle to ch1_pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ch1_pol contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch1_pol


% --- Executes during object creation, after setting all properties.
function ch1_pol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch1_pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ch2_pol.
function ch2_pol_Callback(hObject, eventdata, handles)
% hObject    handle to ch2_pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ch2_pol contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ch2_pol


% --- Executes during object creation, after setting all properties.
function ch2_pol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ch2_pol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in gaincuts_flag.
function gaincuts_flag_Callback(hObject, eventdata, handles)
% hObject    handle to gaincuts_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gaincuts_flag


% --- Executes on button press in xls_flag.
function xls_flag_Callback(hObject, eventdata, handles)
% hObject    handle to xls_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of xls_flag


% --- Executes on button press in dat_flag.
function dat_flag_Callback(hObject, eventdata, handles)
% hObject    handle to dat_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dat_flag


% --- Executes on button press in phasecuts_flag.
function phasecuts_flag_Callback(hObject, eventdata, handles)
% hObject    handle to phasecuts_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of phasecuts_flag



function Theta0_start_Callback(hObject, eventdata, handles)
% hObject    handle to Theta0_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta0_start as text
%        str2double(get(hObject,'String')) returns contents of Theta0_start as a double


% --- Executes during object creation, after setting all properties.
function Theta0_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta0_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta0_end_Callback(hObject, eventdata, handles)
% hObject    handle to Theta0_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta0_end as text
%        str2double(get(hObject,'String')) returns contents of Theta0_end as a double


% --- Executes during object creation, after setting all properties.
function Theta0_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta0_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Theta0_step_Callback(hObject, eventdata, handles)
% hObject    handle to Theta0_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Theta0_step as text
%        str2double(get(hObject,'String')) returns contents of Theta0_step as a double


% --- Executes during object creation, after setting all properties.
function Theta0_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Theta0_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phi0_start_Callback(hObject, eventdata, handles)
% hObject    handle to Phi0_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phi0_start as text
%        str2double(get(hObject,'String')) returns contents of Phi0_start as a double


% --- Executes during object creation, after setting all properties.
function Phi0_start_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phi0_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phi0_end_Callback(hObject, eventdata, handles)
% hObject    handle to Phi0_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phi0_end as text
%        str2double(get(hObject,'String')) returns contents of Phi0_end as a double


% --- Executes during object creation, after setting all properties.
function Phi0_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phi0_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Phi0_step_Callback(hObject, eventdata, handles)
% hObject    handle to Phi0_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Phi0_step as text
%        str2double(get(hObject,'String')) returns contents of Phi0_step as a double


% --- Executes during object creation, after setting all properties.
function Phi0_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phi0_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mat_flag.
function mat_flag_Callback(hObject, eventdata, handles)
% hObject    handle to mat_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mat_flag


% --- Executes on button press in phasecentercorr_flag.
function phasecentercorr_flag_Callback(hObject, eventdata, handles)
% hObject    handle to phasecentercorr_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of phasecentercorr_flag



function coverage_zone_Callback(hObject, eventdata, handles)
% hObject    handle to coverage_zone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coverage_zone as text
%        str2double(get(hObject,'String')) returns contents of coverage_zone as a double


% --- Executes during object creation, after setting all properties.
function coverage_zone_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coverage_zone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_elements_Callback(hObject, eventdata, handles)
% hObject    handle to d_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_elements as text
%        str2double(get(hObject,'String')) returns contents of d_elements as a double


% --- Executes during object creation, after setting all properties.
function d_elements_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_elements (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Phasecenter_frequency_select.
function Phasecenter_frequency_select_Callback(hObject, eventdata, handles)
% hObject    handle to Phasecenter_frequency_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns Phasecenter_frequency_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Phasecenter_frequency_select

contents = get(hObject,'String');
if strcmp(contents,'choose frequency')
    return
end
[NAnt NPol Nfreq] = size(handles.Phasecenter);

pol_freq_index=get(hObject,'Value');

iPol = ceil(pol_freq_index/Nfreq);
ifreq = pol_freq_index-(iPol-1)*Nfreq;

output = cell(5,1);
output{1} = 'Position of phase center (x, y, z) in mm.';
for iAnt = 1:NAnt 
    output{iAnt+1} = sprintf('Element %d: (%7.2f, %7.2f, %7.2f) (MMSE = %7.2f mm)', iAnt,...
                        handles.Phasecenter{iAnt,iPol,ifreq}(1), ...
                        handles.Phasecenter{iAnt,iPol,ifreq}(2), ...
                        handles.Phasecenter{iAnt,iPol,ifreq}(3), ...
                        handles.Phasecenter_mse{iAnt,iPol,ifreq});
end
set(handles.Phasecenter_output,'String',output);
mean_phasecenterbias = mean([handles.Phasecenter{:,iPol,ifreq}],2);
set(handles.correction_x,'String',mean_phasecenterbias(1));
set(handles.correction_y,'String',mean_phasecenterbias(2));
set(handles.correction_z,'String',mean_phasecenterbias(3));
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function Phasecenter_frequency_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phasecenter_frequency_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in element2.
function element2_Callback(hObject, eventdata, handles)
% hObject    handle to element2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element2


% --- Executes during object creation, after setting all properties.
function element2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in element3.
function element3_Callback(hObject, eventdata, handles)
% hObject    handle to element3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element3


% --- Executes during object creation, after setting all properties.
function element3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in element4.
function element4_Callback(hObject, eventdata, handles)
% hObject    handle to element4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element4


% --- Executes during object creation, after setting all properties.
function element4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function OriginPosition_buttongroup_SelectionChangeFcn(hObject, eventdata)
 
%retrieve GUI data, i.e. the handles structure
handles = guidata(hObject); 
 h= get(eventdata.NewValue,'Tag');
switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'origin0'
      %execute this code when origin0 is selected
      handles.OriginPosition = [0 0];
 
    case 'origin1'
      %execute this code when origin1 is selected
      handles.OriginPosition = [-0.5 0.5];
      
    case 'origin2'
      %execute this code when origin2 is selected
      handles.OriginPosition = [0.5 -0.5];
      
    case 'origin3'
      %execute this code when origin3 is selected
      handles.OriginPosition = [-0.5 0.5];
      
    case 'origin4'
      %execute this code when origin4 is selected
      handles.OriginPosition = [0.5 0.5];
    otherwise
       % Code for when there is no match.
 
end
%updates the handles structure
guidata(hObject, handles);


% --- Executes on button press in Preanalyze.
function Preanalyze_Callback(hObject, eventdata, handles)
    %% Variable & Constant Declaration
    NAnt        = 4;                       %No. of Antennas
    c           = 299792458;        % speed of light [m/s]

    %% Importing Variables from GUI
    %Channels:  to know with which channel we should work
    ch1_flag = get(handles.ch1_flag,'Value');
    ch2_flag = get(handles.ch2_flag,'Value');
    %Polarization flags
    copolar_flag = get(handles.copolar_flag,'Value');
    crosspolar_flag = get(handles.crosspolar_flag,'Value');

    %To know the polarization of each channel
    pol1= get(handles.ch1_pol,'String');
    pol1 = pol1{get(handles.ch1_pol,'Value')};
    pol2= get(handles.ch2_pol,'String');
    pol2 = pol2{get(handles.ch2_pol,'Value')};
    
    %check whether there were files selected or not
    if strcmp(get(handles.Folder,'String'),'Choose Directory')
        ed = errordlg('You have to choose a folder!','Error');
        set(ed, 'WindowStyle', 'modal');
        uiwait(ed);
        error('You have to choose a folder!');
    end
    
    %Elements names/order
    if strcmp(handles.Format,'AMA') ||strcmp(handles.Format,'Fraunhofer')
        files = cell(1,NAnt);
        files{1} =   get(handles.element1,'String');
        files{1} =   files{1}{get(handles.element1,'Value')};
        files{2} =   get(handles.element2,'String');
        files{2} =   files{2}{get(handles.element2,'Value')};
        files{3} =   get(handles.element3,'String');
        files{3} =   files{3}{get(handles.element3,'Value')};
        files{4} =   get(handles.element4,'String');
        files{4} =   files{4}{get(handles.element4,'Value')};
    elseif strcmp(handles.Format,'HR') ||strcmp(handles.Format,'HFSS')
        files = cell(NAnt,2);
        files{1,1} =   get(handles.element1,'String');
        files{1,1} =   files{1,1}{get(handles.element1,'Value')};
        files{2,1} =   get(handles.element2,'String');
        files{2,1} =   files{2,1}{get(handles.element2,'Value')};
        files{3,1} =   get(handles.element3,'String');
        files{3,1} =   files{3,1}{get(handles.element3,'Value')};
        files{4,1} =   get(handles.element4,'String');
        files{4,1} =   files{4,1}{get(handles.element4,'Value')};
        files{1,2} =   get(handles.element1_cross,'String');
        files{1,2} =   files{1,2}{get(handles.element1_cross,'Value')};
        files{2,2} =   get(handles.element2_cross,'String');
        files{2,2} =   files{2,2}{get(handles.element2_cross,'Value')};
        files{3,2} =   get(handles.element3_cross,'String');
        files{3,2} =   files{3,2}{get(handles.element3_cross,'Value')};
        files{4,2} =   get(handles.element4_cross,'String');
        files{4,2} =   files{4,2}{get(handles.element4_cross,'Value')};
    end
    
    %Coordinate Points
    Theta0_start = str2double(get(handles.Theta0_start,'String'));
    Theta0_end = str2double(get(handles.Theta0_end,'String'));
    Theta0_step = str2double(get(handles.Theta0_step,'String'));
    NTheta0 = (Theta0_end-Theta0_start)/Theta0_step+1;
    Theta0_axis = linspace(Theta0_start,Theta0_end,NTheta0);

    Phi0_start = str2double(get(handles.Phi0_start,'String'));
    Phi0_end = str2double(get(handles.Phi0_end,'String'));
    Phi0_step = str2double(get(handles.Phi0_step,'String'));
    NPhi0 = (Phi0_end-Phi0_start)/Phi0_step+1;
    Phi0_axis = linspace(Phi0_start,Phi0_end,NPhi0);

    %Antenna structure and coordinates origin 
    d_elements = str2double(get(handles.d_elements,'String')) * 1e-3;
    OriginPosition = handles.OriginPosition*d_elements;
    RegionofInterest  = str2double(get(handles.coverage_zone,'String'));

    %Name of the folder in which is the data
    folder = get(handles.Folder,'String');
    
    %% Data Reading
    
    switch handles.Format
        case 'AMA'
            if ~ch1_flag && ~ch2_flag
                error('You must select at least one channel/polarization');
            end
            [E_Gain,E_Phase] = read_AMA(folder,NAnt,files,...
                Theta0_axis,Phi0_axis,ch1_flag,ch2_flag,pol1,pol2);
            fprintf('AMA Data read.\n');
            phasetrend_flag =1;
        case 'AMA_individual'
            if ~copolar_flag && ~crosspolar_flag
                ed = errordlg('You must select at least one channel/polarization','Error');
                error('You must select at least one channel/polarization');
            end
            [E_Gain,E_Phase,] = read_AMA_individual(folder,files,ch1_flag,ch2_flag,pol1,pol2);
            fprintf('AMA Data read.\n');
            
        case 'Fraunhofer'
            if ~copolar_flag && ~crosspolar_flag
                errordlg('You must select at least one channel/polarization','Error');
                error('You must select at least one channel/polarization');
            end
            [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_Fraunhofer(folder,NAnt,files,copolar_flag,crosspolar_flag);
            fprintf('Fraunhofer Data read.\n');
            phasetrend_flag=1;
        case 'HR'
            if ~copolar_flag && ~crosspolar_flag
                errordlg('You must select at least one channel/polarization','Error');
                error('You must select at least one channel/polarization');
            end
            [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_HR(folder,NAnt,files,copolar_flag,crosspolar_flag);
            fprintf('HR Data read.\n');
            phasetrend_flag=0;
        case 'HFSS'
            if ~copolar_flag && ~crosspolar_flag
                errordlg('You must select at least one channel/polarization','Error');
                error('You must select at least one channel/polarization');
            end
            [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_HFSS(folder,NAnt,files,copolar_flag,crosspolar_flag);
            fprintf('HFSS Data read.\n');
            phasetrend_flag=1;
    end
            
        
    [NAnt NPol Nfreq] = size(E_Phase);
    %% Convert coordinates from Thet0,Phi0 to Theta,Phi

    [E_Gain,Theta_axis,Phi_axis] = coord_converter(E_Gain,Theta0_axis,Phi0_axis); %#ok<NASGU>
    [E_Phase,Theta_axis,Phi_axis] = coord_converter(E_Phase,Theta0_axis,Phi0_axis);
    
    %Create grid for plotting
    [Theta_grid,Phi_grid]= ndgrid(Theta_axis,Phi_axis);
    %% Correct Phase measurements
    E_Phase = correctPhase(E_Phase,d_elements,Theta_grid,Phi_grid,OriginPosition,phasetrend_flag);

    %% Antenna Phase center
    %Determine the position of the phase center of each antenna element
    %and calculate the mean center, for a certain region of interest
    [center,mse] = phasecenter_find(E_Phase,Theta_axis,Phi_axis,RegionofInterest,'nofile',1);
    
    pol_freq_list = cell(NPol*Nfreq,1);
    for iPol =1:NPol
        for ifreq=1:Nfreq
            pol_freq_list{(iPol-1)*Nfreq+ifreq} = sprintf('%s - %gGHz',...
                E_Gain{1,iPol,ifreq}.polarization,E_Gain{1,iPol,ifreq}.frequency/1e9);
        end
    end
    handles.Phasecenter=center;
    handles.Phasecenter_mse =mse;
    set(handles.Phasecenter_frequency_select,'String',pol_freq_list);  
    set(handles.Phasecenter_frequency_select,'Value',1);
guidata(hObject, handles);
        
        



function correction_x_Callback(hObject, eventdata, handles)
% hObject    handle to correction_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of correction_x as text
%        str2double(get(hObject,'String')) returns contents of correction_x as a double


% --- Executes during object creation, after setting all properties.
function correction_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correction_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function correction_y_Callback(hObject, eventdata, handles)
% hObject    handle to correction_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of correction_y as text
%        str2double(get(hObject,'String')) returns contents of correction_y as a double


% --- Executes during object creation, after setting all properties.
function correction_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correction_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function correction_z_Callback(hObject, eventdata, handles)
% hObject    handle to correction_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of correction_z as text
%        str2double(get(hObject,'String')) returns contents of correction_z as a double


% --- Executes during object creation, after setting all properties.
function correction_z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to correction_z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Format_type_buttongroup_SelectionChangeFcn(hObject, eventdata)
 
%retrieve GUI data, i.e. the handles structure
handles = guidata(hObject); 
thick =1.5;

switch get(eventdata.NewValue,'Tag')   % Get Tag of selected object
    case 'AMA_button'
      %execute this code when fontsize08_radiobutton is selected
      handles.Format = 'AMA';
      pos = get(handles.Files_Panel,'Position');% Position: [x y width height]
      hoch = 7-pos(4);
      pos(2) = pos(2)-hoch;
      pos(4) = 7; 
      set(handles.Files_Panel,'Position',pos);
      
      pos = get(handles.element1,'Position'); pos(3)=50;
      pos(2) = pos(2)+hoch/2; set(handles.element1,'Position',pos);
      pos = get(handles.element2,'Position');
      pos(2) = pos(2)+hoch/2; set(handles.element2,'Position',pos);
      pos = get(handles.element3,'Position');
      pos(2) = pos(2)+hoch; set(handles.element3,'Position',pos);
      pos = get(handles.element4,'Position');
      pos(2) = pos(2)+hoch; set(handles.element4,'Position',pos);
      
      pos = get(handles.instruction_text2,'Position');
      pos(2) = pos(2)+hoch; set(handles.instruction_text2,'Position',pos);
      
      %Set visibility of the crosspolarization file component - only needed
      %for hr
      set(handles.element1,'Visible','on');
      set(handles.element2,'Visible','on');
      set(handles.element3,'Visible','on');
      set(handles.element4,'Visible','on');
      set(handles.element1_cross,'Visible','off');
      set(handles.element2_cross,'Visible','off');
      set(handles.element3_cross,'Visible','off');
      set(handles.element4_cross,'Visible','off');
      
      %Everytime we set back the popup menus of the elements to 'choose file',
      %we have to set the 'Value' back to 1
      set(handles.element1,'Value',1);
      set(handles.element2,'Value',1);
      set(handles.element3,'Value',1);
      set(handles.element4,'Value',1);
      %Set name of the file selection
      set(handles.element1,'String','Choose first file for element 1');
      set(handles.element2,'String','Choose first file for element 2');
      set(handles.element3,'String','Choose first file for element 3');
      set(handles.element4,'String','Choose first file for element 4');     

      %-------------------------------------------------------------------%
      set(handles.Channels_Panel,'Visible','on');
      set(handles.MeasuredPoints_Panel,'Visible','on');
      set(handles.Polarization_Panel,'Visible','off');
      
      set(handles.OriginPosition_buttongroup,'Visible','on');
      set(handles.Pase_Center_Bias_Panel,'Visible','on');
      set(handles.Output_Panel,'Visible','on');
      set(handles.Export_Panel,'Visible','on');
      
    case 'AMA_individual_button'
      handles.Format = 'AMA_individual';
      pos = get(handles.Files_Panel,'Position');   % Position: [x y width height]
      hoch = 7-pos(4);
      pos(2) = pos(2)-hoch;
      pos(4) = 7; 
      set(handles.Files_Panel,'Position',pos);
      
      pos = get(handles.element1,'Position');pos(3) = 100;
      pos(2) = pos(2)+hoch/2; set(handles.element1,'Position',pos);
      pos = get(handles.element2,'Position');
      pos(2) = pos(2)+hoch/2; set(handles.element2,'Position',pos);
      pos = get(handles.element3,'Position');
      pos(2) = pos(2)+hoch; set(handles.element3,'Position',pos);
      pos = get(handles.element4,'Position');
      pos(2) = pos(2)+hoch; set(handles.element4,'Position',pos);
      
      pos = get(handles.instruction_text2,'Position');
      pos(2) = pos(2)+hoch; set(handles.instruction_text2,'Position',pos);
      
      %Set visibility of the crosspolarization file component - only needed
      %for hr
      set(handles.element1_cross,'Visible','off');
      set(handles.element2_cross,'Visible','off');
      set(handles.element3_cross,'Visible','off');
      set(handles.element4_cross,'Visible','off');
      set(handles.element2,'Visible','off');
      set(handles.element3,'Visible','off');
      set(handles.element4,'Visible','off');
      
      %Everytime we set back the popup menus of the elements to 'choose file',
      %we have to set the 'Value' back to 1
      set(handles.element1,'Value',1);
      %Set name of the file selection
      set(handles.element1,'String','Choose first file for the file group');
      
      %-------------------------------------------------------------------%
      set(handles.Channels_Panel,'Visible','off');
      set(handles.Polarization_Panel,'Visible','on');      
      
      set(handles.MeasuredPoints_Panel,'Visible','off'); 
      set(handles.OriginPosition_buttongroup,'Visible','off');
      set(handles.Pase_Center_Bias_Panel,'Visible','off');
      set(handles.Output_Panel,'Visible','off');
      set(handles.Export_Panel,'Visible','off');
    
    case 'Fraunhofer_button'
      handles.Format = 'Fraunhofer';
      pos = get(handles.Files_Panel,'Position');% Position: [x y width height]
      hoch = 7-pos(4);
      pos(2) = pos(2)-hoch;
      pos(4) = 7; 
      set(handles.Files_Panel,'Position',pos);
     
      pos = get(handles.element1,'Position'); pos(3)=50;
      pos(2) = pos(2)+hoch/2; set(handles.element1,'Position',pos);
      pos = get(handles.element2,'Position');
      pos(2) = pos(2)+hoch/2; set(handles.element2,'Position',pos);
      pos = get(handles.element3,'Position');
      pos(2) = pos(2)+hoch; set(handles.element3,'Position',pos);
      pos = get(handles.element4,'Position');
      pos(2) = pos(2)+hoch; set(handles.element4,'Position',pos);

      pos = get(handles.instruction_text2,'Position');
      pos(2) = pos(2)+hoch; set(handles.instruction_text2,'Position',pos);
      
      set(handles.element1,'Visible','on');
      set(handles.element2,'Visible','on');
      set(handles.element3,'Visible','on');
      set(handles.element4,'Visible','on');
      set(handles.element1_cross,'Visible','off');
      set(handles.element2_cross,'Visible','off');
      set(handles.element3_cross,'Visible','off');
      set(handles.element4_cross,'Visible','off');
      
      %Everytime we set back the popup menus of the elements to 'choose file',
      %we have to set the 'Value' back to 1
      set(handles.element1,'Value',1);
      set(handles.element2,'Value',1);
      set(handles.element3,'Value',1);
      set(handles.element4,'Value',1);
      %Set name of the file selection
      set(handles.element1,'String','Choose first file for element 1');
      set(handles.element2,'String','Choose first file for element 2');
      set(handles.element3,'String','Choose first file for element 3');
      set(handles.element4,'String','Choose first file for element 4');     

      
      set(handles.Channels_Panel,'Visible','off');
      set(handles.MeasuredPoints_Panel,'Visible','off');
      set(handles.Polarization_Panel,'Visible','on');
      set(handles.copolar_flag,'String','RHCP');
      set(handles.crosspolar_flag,'String','LHCP');
      
      set(handles.OriginPosition_buttongroup,'Visible','on');
      set(handles.Pase_Center_Bias_Panel,'Visible','on');
      set(handles.Output_Panel,'Visible','on');
      set(handles.Export_Panel,'Visible','on');
      
    case 'HR_button'
      %execute this code when fontsize16_radiobutton is selected  
      handles.Format = 'HR';
      pos = get(handles.Files_Panel,'Position');% Position: [x y width height]
      hoch = 11-pos(4);
      pos(2) = pos(2)-hoch;
      pos(4) = 11; 
      set(handles.Files_Panel,'Position',pos);
      
      
      set(handles.element1,'Visible','on');
      set(handles.element2,'Visible','on');
      set(handles.element3,'Visible','on');
      set(handles.element4,'Visible','on');
      
      pos = get(handles.element1,'Position'); pos(3)=50;
      pos(2) = pos(2)+hoch/2; set(handles.element1,'Position',pos);
      set(handles.element1_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element1_cross,'Visible','on');
      pos = get(handles.element2,'Position');
      pos(2) = pos(2)+hoch/2; set(handles.element2,'Position',pos);
      set(handles.element2_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element2_cross,'Visible','on');
      pos = get(handles.element3,'Position');
      pos(2) = pos(2)+hoch; set(handles.element3,'Position',pos);
      set(handles.element3_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element3_cross,'Visible','on');
      pos = get(handles.element4,'Position');
      pos(2) = pos(2)+hoch; set(handles.element4,'Position',pos);
      set(handles.element4_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element4_cross,'Visible','on');
      
 
      pos = get(handles.instruction_text2,'Position');
      pos(2) = pos(2)+hoch; set(handles.instruction_text2,'Position',pos);
      
      %Everytime we set back the popup menus of the elements to 'choose file',
      %we have to set the 'Value' back to 1
      set(handles.element1,'Value',1);
      set(handles.element2,'Value',1);
      set(handles.element3,'Value',1);
      set(handles.element4,'Value',1);
      set(handles.element1_cross,'Value',1);
      set(handles.element2_cross,'Value',1);
      set(handles.element3_cross,'Value',1);
      set(handles.element4_cross,'Value',1);
      %Set name of the file selection
      set(handles.element1,'String','Choose file for element 1 - copolar');     
      set(handles.element2,'String','Choose file for element 2 - copolar');     
      set(handles.element3,'String','Choose file for element 3 - copolar');     
      set(handles.element4,'String','Choose file for element 4 - copolar');     
      set(handles.element1_cross,'String','Choose file for element 1 - crosspolar');
      set(handles.element2_cross,'String','Choose file for element 2 - crosspolar');
      set(handles.element3_cross,'String','Choose file for element 3 - crosspolar');
      set(handles.element4_cross,'String','Choose file for element 4 - crosspolar');
      
      set(handles.Channels_Panel,'Visible','off');
      set(handles.MeasuredPoints_Panel,'Visible','off');
      set(handles.Polarization_Panel,'Visible','on');
      set(handles.copolar_flag,'String','Copolar');
      set(handles.crosspolar_flag,'String','Crosspolar');
      
      set(handles.OriginPosition_buttongroup,'Visible','on');
      set(handles.Pase_Center_Bias_Panel,'Visible','on');
      set(handles.Output_Panel,'Visible','on');
      set(handles.Export_Panel,'Visible','on');
      
    case 'HFSS_button'
      %execute this code when fontsize16_radiobutton is selected
      handles.Format = 'HFSS';
      pos = get(handles.Files_Panel,'Position');% Position: [x y width height]
      hoch = 11-pos(4);
      pos(2) = pos(2)-hoch;
      pos(4) = 11; 
      set(handles.Files_Panel,'Position',pos);
      
      set(handles.element1,'Visible','on');
      set(handles.element2,'Visible','on');
      set(handles.element3,'Visible','on');
      set(handles.element4,'Visible','on');
      pos = get(handles.element1,'Position'); pos(3)=50;
      pos(2) = pos(2)+hoch/2; set(handles.element1,'Position',pos);
      set(handles.element1_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element1_cross,'Visible','on');
      pos = get(handles.element2,'Position');
      pos(2) = pos(2)+hoch/2; set(handles.element2,'Position',pos);
      set(handles.element2_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element2_cross,'Visible','on');
      pos = get(handles.element3,'Position');
      pos(2) = pos(2)+hoch; set(handles.element3,'Position',pos);
      set(handles.element3_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element3_cross,'Visible','on');
      pos = get(handles.element4,'Position');
      pos(2) = pos(2)+hoch; set(handles.element4,'Position',pos);
      set(handles.element4_cross,'Position',pos - [0 thick 0 0]);
      set(handles.element4_cross,'Visible','on');
      
      pos = get(handles.instruction_text2,'Position');
      pos(2) = pos(2)+hoch; set(handles.instruction_text2,'Position',pos);
      set(handles.copolar_flag,'String','RHCP');
      set(handles.crosspolar_flag,'String','LHCP');
      
      %Everytime we set back the popup menus of the elements to 'choose file',
      %we have to set the 'Value' back to 1
      set(handles.element1,'Value',1);
      set(handles.element2,'Value',1);
      set(handles.element3,'Value',1);
      set(handles.element4,'Value',1);
      set(handles.element1_cross,'Value',1);
      set(handles.element2_cross,'Value',1);
      set(handles.element3_cross,'Value',1);
      set(handles.element4_cross,'Value',1);
      %Set name of the file selection
      set(handles.element1,'String','Choose file for element 1 - Theta component');
      set(handles.element2,'String','Choose file for element 2 - Theta component');
      set(handles.element3,'String','Choose file for element 3 - Theta component');
      set(handles.element4,'String','Choose file for element 4 - Theta component');
      %Set name of the file selection
      set(handles.element1_cross,'String','Choose file for element 1 - Phi component');
      set(handles.element2_cross,'String','Choose file for element 2 - Phi component');
      set(handles.element3_cross,'String','Choose file for element 3 - Phi component');
      set(handles.element4_cross,'String','Choose file for element 4 - Phi component');
      
      %Hide Channels Panel of AMA reading
      set(handles.Channels_Panel,'Visible','off');
      set(handles.Polarization_Panel,'Visible','on');
      set(handles.MeasuredPoints_Panel,'Visible','off');
      
      set(handles.OriginPosition_buttongroup,'Visible','on');
      set(handles.Pase_Center_Bias_Panel,'Visible','on');
      set(handles.Output_Panel,'Visible','on');
      set(handles.Export_Panel,'Visible','on');
      
    otherwise
       % Code for when there is no match.
 
end
%updates the handles structure
guidata(hObject, handles);


% --- Executes on selection change in element4_cross.
function element4_cross_Callback(hObject, eventdata, handles)
% hObject    handle to element4_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element4_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element4_cross


% --- Executes during object creation, after setting all properties.
function element4_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element4_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in element3_cross.
function element3_cross_Callback(hObject, eventdata, handles)
% hObject    handle to element3_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element3_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element3_cross


% --- Executes during object creation, after setting all properties.
function element3_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element3_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in element2_cross.
function element2_cross_Callback(hObject, eventdata, handles)
% hObject    handle to element2_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element2_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element2_cross


% --- Executes during object creation, after setting all properties.
function element2_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element2_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in element1_cross.
function element1_cross_Callback(hObject, eventdata, handles)
% hObject    handle to element1_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns element1_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from element1_cross


% --- Executes during object creation, after setting all properties.
function element1_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to element1_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Read Fraunhofer Format Data
function [E_Gain,E_Phase,Theta0_axis,Phi0_axis]=read_Fraunhofer(folder,NAnt,files,copolar_flag,crosspolar_flag)
    %open the folder continaining the fraunhofer data
prev_fol = cd;
cd(folder);

%The files are divided by element
for iAnt = 1:NAnt
    % Read the first 50 lines looking for header information
    header_text = textread(files{iAnt}, '%s', 50, 'delimiter', '\n');
    index_found = strncmp(header_text, '%Phi',4);
    index_found = find(index_found==1);
    if ~isempty(index_found)
        data_read = textscan(header_text{index_found+2},'%*s %s %*s %f %s %*s %f %s %*s %f');
        Phi0_start = data_read{2};
        Phi0_end = data_read{4};
        Phi0_step = data_read{6};
        NPhi0 = (Phi0_end - Phi0_start) / Phi0_step + 1;
    end
    index_found = strncmp(header_text, '%Theta',6);
    index_found = find(index_found==1);
    if ~isempty(index_found)
        data_read = textscan(header_text{index_found+2},'%*s %s %*s %f %s %*s %f %s %*s %f');
        Theta0_start = data_read{2};
        Theta0_end = data_read{4};
        Theta0_step = data_read{6};
        NTheta0 = (Theta0_end - Theta0_start) / Theta0_step + 1;
    end
       
    %Make Theta and Phi vectors and grids
    Theta0_axis = linspace(Theta0_start,Theta0_end,NTheta0);
    Phi0_axis = linspace(Phi0_start,Phi0_end,NPhi0);
    
    %Read Polarization
    index_found = strncmp(header_text, '%FF sense',8);
    [data_read]=textscan(header_text{index_found},'%*s %f',1,'Delimiter',':');
    if data_read{1} == -1  
        data_read{1} ==0;
        polarization = {'RHCP' 'LHCP'};
        if ~copolar_flag polarization(1) = []; end;
        if ~crosspolar_flag polarization(2) = []; end;
    elseif data_read{1} == 1
        polarization = {'LHCP' 'RHCP'};    
        if ~copolar_flag polarization(2) = []; end;
        if ~crosspolar_flag polarization(1) = []; end;
    elseif data_read{1} == 0
        errordlg('Type of polarization not recognized','Read Fraunhofer Data');
        cd(prev_fol); error('Type of polarization not recognized');
%         polarization = {'Linear(H)' 'Linear(V)'};    
    end
     NPol = length(polarization);
    %Create the reading structure string to be read on the data file. The
    %idea here is to ignore to read the  unnecesary fields (%*f) because
    %reading from these files is very time-consuming
    
    %we use logic operators to give our output and supress or allow these
    %structures:
    %  ~left*[%*f %*f] + left*[%f %f] + right*[%f %f] + ~right*[%*f %*f];
    left = ~(   (~copolar_flag && crosspolar_flag && data_read{1})  ||...
                (copolar_flag && ~crosspolar_flag && ~data_read{1}) );
    right= ~(   (~copolar_flag && crosspolar_flag && ~data_read{1})  ||...
                (copolar_flag && ~crosspolar_flag && data_read{1}) );
            
    read_structure = ['%f %*u %*u'  ...
        repmat('%*f',1,2*~left) repmat('%f',1,2*left) repmat('%f',1,2*right)  repmat('%*f',1,2*~right) ];
    
    %Read unit type
    index_found = strncmp(header_text, '%Units:',7);
    [data_read]=textscan(header_text{index_found},'%*s %s %s %s',1);
    %Order of magnitude of frequency
    if strfind(data_read{1}{1},'GHz')     ; freq_order = 1e9;
    elseif strfind(data_read{1}{1},'MHz') ; freq_order = 1e6; 
    end
    %angle units
    if strfind(data_read{2}{1},'deg')
        angle_unit = 'degrees';
    elseif strfind(data_read{2}{1},'rad')
        angle_unit = 'radians';
    end
    %Gain units
    if strfind(data_read{3}{1},'dB');    gain_unit = 'dB';    end %#ok<NASGU>
    
    %Find beginning of the data matrix
    index_found = strncmp(header_text, '%Frequency',10);
    index_found = find(index_found==1);
    fields = textscan(header_text{index_found},'%s');
    if      length(fields{1})~=11
        errordlg('Number of column fields not recognizable','Read Fraunhofer Data');
        cd(prev_fol); error('Number of column fields not recognizable');
    end
    
    % Reading Data
    file = fopen(files{iAnt}); 
    fprintf('Reading file %s ...\n',files{iAnt});
    %MADE FOR IMPROVING READING SPEED
    [data_read]=textscan(file,read_structure,'Headerlines',index_found+1);
    fclose(file);
    
    %number of frequencies
    Nfreq = length(data_read{1}) / (NPhi0 * NTheta0);
    if rem(Nfreq,1)~=0
        errordlg('Sizes of data vectors do not match. The file is not complete or not every value was readed.','Read Fraunhofer Data');
        cd(prev_fol); error('Sizes of data vectors do not match. The file is not complete or not every value was readed.');
    end
    
    %If we are reading the first element, we declare the struct cell array
    if iAnt ==1 
        freq = cell(1,Nfreq);
        E_Gain  = cell(NAnt,NPol,Nfreq);
        E_Phase = cell(NAnt,NPol,Nfreq);
    end
        
    %Organizing the data into the array cell form 
    for ifreq = 1:Nfreq
        freq{ifreq} = data_read{1}((ifreq-1)*NTheta0*NPhi0+1)*freq_order;
        for iPol = 1:NPol
            E_Gain{iAnt,iPol,ifreq} = struct('type',{'Gain (dB)'},'element',{iAnt},...
                'polarization',{polarization{iPol}},'frequency',freq(ifreq),... %%FIXME (iPol)
                'pattern',zeros(NTheta0,NPhi0));
            E_Phase{iAnt,iPol,ifreq} = struct('type',{'Phase (rad)'},'element',{iAnt},...
                'polarization',{polarization{iPol}},'frequency',freq(ifreq),...
                'pattern',zeros(NTheta0,NPhi0));
            
            for iTheta = 1:NTheta0
                iRowFirstElement = (ifreq-1)*NTheta0*NPhi0+(iTheta-1)*NPhi0 + 1 ;
                iRowLastElement  = (ifreq-1)*NTheta0*NPhi0+(iTheta  )*NPhi0     ;
                E_Gain{iAnt,iPol,ifreq}.pattern(iTheta,:) = data_read{2*iPol}(iRowFirstElement:iRowLastElement);
                E_Phase{iAnt,iPol,ifreq}.pattern(iTheta,:) = data_read{1+2*iPol}(iRowFirstElement:iRowLastElement);
                
                if ~isempty(strfind(angle_unit,'deg'))
                    E_Phase{iAnt,iPol,ifreq}.pattern(iTheta,:) = deg2rad(E_Phase{iAnt,iPol,ifreq}.pattern(iTheta,:));
                end
                
            end
        end
    end
end
cd(prev_fol);

%% Read HR Data function
function [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_HR(folder,NAnt,files,copolar_flag,crosspolar_flag)
%open the folder continaining the Hochfrequenztechnick und Radarsysteme
%measurement data
prev_fol = cd;
cd(folder);
%The files are divided by element and polarization
if ~copolar_flag
    files(:,1) = [];
end
if ~crosspolar_flag
    files(:,2) = [];
end
NPol=size(files,2);
for iAnt = 1:NAnt    
    %% Pol iteration
    for iPol = 1:NPol
        fprintf('Reading file %s ...\n',files{iAnt,iPol});
        
        % Read the first 50 lines looking for header information
        header_text = textread(files{iAnt,iPol}, '%s', 50, 'delimiter', '\n');
        
        
        %Look for the polarization type
        data_read = textscan(header_text{3},'%s%s','Delimiter',',');
        if strfind(data_read{1}{1},'LHC')
            polarization = 'LHCP';
        elseif strfind(data_read{1}{1},'RHC')
            polarization = 'RHCP';
        elseif strfind(data_read{1}{1},'inear')
        else
            errordlg('Polarization type read in file is not recognized','HR Data read');
            cd(prev_fol); error('Polarization type read in file is not recognized');
        end
        
        %Look for the Phi points
        index_found = strncmp(header_text, '"Phi",',5);
        index_found = find(index_found==1);
        if index_found
            data_read = textscan(header_text{index_found},'%s%s%s%s%s%s','Delimiter',',');
            Phi0_start = str2double(data_read{2}{1});
            Phi0_end = str2double(data_read{3}{1});
            NPhi0 = str2double(data_read{5}{1});
        end
        %Look for the Theta points
        index_found = strncmp(header_text, '"Theta',6);
        index_found = find(index_found==1);
        if ~isempty(index_found)
            data_read = textscan(header_text{index_found},'%s%s%s%s%s%s','Delimiter',',');
            Theta0_start = str2double(data_read{2}{1});
            Theta0_end = str2double(data_read{3}{1});
            NTheta0 = str2double(data_read{5}{1});
        end
        index_found = strncmp(header_text, '"FREQUENCY',10);
        index_found = find(index_found==1);
        if ~isempty(index_found)
            data_read = textscan(header_text{index_found},'%s%s%s%s%s%s','Delimiter',',');
    
            f_start = str2double(data_read{2}{1});
            f_end   = str2double(data_read{3}{1});
            Nfreq  = str2double(data_read{5}{1});
            %OBS: Here we asumed that the Theta, Phi and frequency value are
            %equidistantly separated
            if     strcmpi(data_read{4}{1},'"Hz"');  freq_order = 1;
            elseif strcmpi(data_read{4}{1},'"MHz"'); freq_order = 1e6;
            elseif strcmpi(data_read{4}{1},'"GHz"'); freq_order = 1e9;
            elseif strcmpi(data_read{4}{1},'"kHz"'); freq_order = 1e3;
            else
                errordlg('Frequency information was not found in file','Read HR Data');
                cd(prev_fol); error('Frequency information was not found in file');
            end
            freq = linspace(f_start,f_end,Nfreq) * freq_order;
        else   cd(prev_fol); error('Frequency information was not found in file');
        end
        
        index_found = strfind(header_text,'"Phase (');
        index_found = ~cellfun('isempty',index_found);
        index_found = find(index_found==1);
        if ~isempty(index_found)
            data_read = textscan(header_text{index_found},'%s%s%s%s%s','Delimiter',',');
            Gain_label = data_read{3}{1};
            Phase_label  = data_read{4}{1};
            
        else
            errordlg('Gain and Phase labels were not found','Read HR Data');
            cd(prev_fol); error('Gain and Phase labels were not found');
        end
        
        
        %% We look for the first value of Phi and read the matrix
        index_found = strncmp(header_text, num2str(Phi0_start),1);
        index_found = find(index_found,1);
        if isempty(index_found); cd(prev_fol); error('The data could not be readed'); end
        
        file = fopen(files{iAnt,iPol}); %"files" the input list, while "file" is the acual file pointer
        [data_read]=textscan(file , repmat('%f',1,2+2*Nfreq) ,...
            'Delimiter',',','Headerlines', index_found);
        fclose(file);
        
        %% Assign the Values 
        if iAnt ==1 && iPol ==1
            E_Gain = cell(NAnt,NPol,Nfreq);
            E_Phase = cell(NAnt,NPol,Nfreq);
        end
        
        for ifreq = 1:Nfreq
            E_Gain{iAnt,iPol,ifreq} = struct('type',{'Gain (dBi)'},'element',{iAnt},...
                'polarization',{polarization},'frequency',{freq(ifreq)},...
                'pattern',zeros(NTheta0,NPhi0));
            E_Phase{iAnt,iPol,ifreq} = struct('type',{'Phase (deg)'},'element',{iAnt},...
                'polarization',{polarization},'frequency',{freq(ifreq)},...
                'pattern',zeros(NTheta0,NPhi0));
            
            for iPhi = 1:NPhi0
                E_Gain{iAnt,iPol,ifreq}.pattern(:,iPhi) = ...
                    data_read{ 1 + 2*(ifreq) }( (iPhi-1)*NTheta0+1 : iPhi*NTheta0 );
                E_Phase{iAnt,iPol,ifreq}.pattern(:,iPhi) = ...
                    data_read{ 2 + 2*(ifreq) }( (iPhi-1)*NTheta0+1 : iPhi*NTheta0 );
                if ~isempty(strfind(Phase_label,'deg'))
                    E_Phase{iAnt,iPol,ifreq}.pattern(:,iPhi) = deg2rad(E_Phase{iAnt,iPol,ifreq}.pattern(:,iPhi));
                end
                if ~isempty(strfind(Gain_label,'mag'))
                    E_Gain{iAnt,iPol,ifreq}.pattern(:,iPhi) = mag2db(E_Gain{iAnt,iPol,ifreq}.pattern(:,iPhi));
                end
            end
        end

    end
end

Theta0_axis = linspace(Theta0_start,Theta0_end,NTheta0);
Phi0_axis = linspace(Phi0_start,Phi0_end,NPhi0);
cd(prev_fol);

%% REad HFSS Data function 
function [E_Gain,E_Phase,Theta0_axis,Phi0_axis] = read_HFSS(folder,NAnt,files,copolar_flag,crosspolar_flag)
NPol=2;
prev_fol = cd;
cd(folder);
%The files are divided by element and polarization
for iAnt = 1:NAnt
    for iPol = 1:NPol
        fprintf('Reading file %s ...\n',files{iAnt,iPol});
        
        header_text = textread(files{iAnt,iPol}, '%s', 1, 'delimiter', '\n','bufsize',16383);
        header_text = textscan(header_text{1}, '%q');
        header_text = header_text{1};
        
        %this was in case Theta measurements were columnwise and Phi,
        %Rowwise
        %            if ~isempty(strfind(header_text{1},'Theta'))
        %                coord1='Theta'; coord2 = 'Phi';
        %            elseif ~isempty(strfind(header_text{1},'Phi'))
        %                coord1 ='Phi'; coord2 = 'Theta';
        %            end
        
        %look for the frequency unit:
        freq_order = regexp(header_text{2},'(?<=Freq=''\d.\w*)[a-zA-Z]*','match');
        if strcmp(freq_order,'GHz')
            freq_order = 1e9;
        elseif strcmp(freq_order,'MHz')
            freq_order =1e6;
        elseif  strcmp(freq_order,'Hz')
            freq_order=1;
        end
        
        %eliminate the firs element of the read header
        header_text(1) =[];
        
        %Identify The Frequency and Phi components
        freq = regexp(header_text,'(?<=Freq=''\d*)[0-9.]*','match');
        freq = cellfun(@str2double,freq);
        freq = unique(freq)*freq_order;
        Nfreq = length(freq);
        
        Phi0_axis = regexp(header_text,'(?<=Phi=''\d*)[0-9.]*','match');
        Phi0_axis = cellfun(@str2double,Phi0_axis);
        
        %now, we assume that the phi components were repeated for every
        %frequency contained in freq
        
        NPhi0 = length(Phi0_axis)/Nfreq;
        if rem(NPhi0,1)~=0
            
            errordlg('Number of Phi measurements are not regular along frequency','Read HFSS Data');
            cd(prev_fol); error('Number of Phi measurements are not regular along frequency');
        end
        Phi0_axis =Phi0_axis(1:NPhi0)';
        
        %% Read data
        %declare de Arrays
        if iAnt ==1 && iPol ==1
            E_Pattern = cell(NAnt,NPol,Nfreq);
            E_Gain= cell(NAnt,NPol,Nfreq);
            E_Phase = cell(NAnt,NPol,Nfreq);
        end
        
        %create textformat to read:
        textformat      = ['%f', repmat('%f',1,NPhi0*Nfreq)];
        %open file
        file = fopen(files{iAnt,iPol});
        if (file == -1)
            errordlg('Cannot open input file','Read HFSS Data');
            cd(prev_fol); error('Cannot open input file');
        end
        [data_read, pos] = textscan(file,textformat,'Headerlines',1);
        Theta0_axis = [data_read{1}]';
        
        for ifreq=1:Nfreq
            E_Pattern{iAnt,iPol,ifreq} = ...
                [data_read{(Nfreq-1)*NPhi0+2 : Nfreq*NPhi0+1}];
        end
    end
    %we had to read the two polarization first
    
    for ifreq = 1:Nfreq        
        %RHCP
        aux_Pattern = E_Pattern{iAnt,1,ifreq} + 1i* E_Pattern{iAnt,2,ifreq};
        E_Gain{iAnt,1,ifreq} = struct('type',{'Gain (dBi)'},'element',{iAnt},...
            'polarization','RHCP','frequency',{freq(ifreq)},...
            'pattern',mag2db(abs(aux_Pattern)));
        E_Phase{iAnt,1,ifreq} = struct('type',{'Phase (deg)'},'element',{iAnt},...
            'polarization','RHCP','frequency',{freq(ifreq)},...
            'pattern',angle(aux_Pattern));
        %LHCP
        aux_Pattern = E_Pattern{iAnt,1,ifreq} - 1i* E_Pattern{iAnt,2,ifreq};        
        E_Gain{iAnt,2,ifreq} = struct('type',{'Gain (dBi)'},'element',{iAnt},...
            'polarization','LHCP','frequency',{freq(ifreq)},...
            'pattern',mag2db(abs(aux_Pattern)));
        E_Phase{iAnt,2,ifreq} = struct('type',{'Phase (deg)'},'element',{iAnt},...
            'polarization','LHCP','frequency',{freq(ifreq)},...
            'pattern',angle(aux_Pattern));
    end
end
%we interprete copolar_flag as a RHCP_flag and crosspolar_flag  as
%LHCP_flag
if ~copolar_flag
    E_Gain(:,1,:) = [];
    E_Phase(:,1,:)= [];
end
if ~crosspolar_flag
    E_Gain(:,2,:) = [];
    E_Phase(:,2,:)= [];
end
cd(prev_fol);



% --- Executes during object creation, after setting all properties.
function Format_type_buttongroup_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Format_type_buttongroup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.Format ='AMA';
guidata(hObject, handles);


% --- Executes on button press in copolar_flag.
function copolar_flag_Callback(hObject, eventdata, handles)
% hObject    handle to copolar_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of copolar_flag


% --- Executes on button press in crosspolar_flag.
function crosspolar_flag_Callback(hObject, eventdata, handles)
% hObject    handle to crosspolar_flag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of crosspolar_flag
