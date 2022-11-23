%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The main script gives the user a set of options. The user then works    %
% his/her way through the interface giving the required input when needed %
%                                                                         %
% Input:  The user's choice of option (and a csv file if first option is  %
%         selected)                                                       %
% Output: None                                                            %
%                                                                         %
% Authors:                                                                %
% Roberto Presigiacomo,     s132275                                       %
% Simeon Asenov Doychinov,  s155476                                       %
% Kevin Farbæk Jensen,      s164028                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define menu items
menuItems = {'Load new data', 'Check for data errors', 'Generate plots', 'Display list of grades', 'Quit'};

% Allocates variable for filename
filename = '';

% Asks the student to input a file of type .csv
prompt = 'Please input a .csv file ';
filename = inputdlg(prompt, 'Input file', [1, 50]);

while true
    % Returns to main if cancel is selected
    if size(char(filename)) == [0,0]
        file = '';
        break
             
    % Creates error message if ok is selected without an input
    elseif size(char(filename)) == [1,0]
        uiwait(msgbox('Error: Empty input                                ', 'Error'))
        filename = inputdlg(prompt, 'Input file', [1, 50]);

    % Creates error message if the input cannot be found in the directory
    elseif exist(char(filename)) == 0
        uiwait(msgbox('Error: File doesn`t exist in the current directory', 'Error'))
        filename = inputdlg(prompt, 'Input file', [1, 50]);
        
    % If no errors occur the file is loaded and displayed
    else
        file = filename{1};
        Table = readtable(file);
        [N,M] = size(Table);
        fprintf('There are %0.0f students in the table\nThere are %0.0f assignments in the table\n', N, (M - 2))
        disp(Table);
        break
    end
end

while true
    % Display menu options and ask user to choose a menu item
    choice = menu('Menu', menuItems);
    
%--------------------------------------------------------------------------   
%                             Load new data    
%--------------------------------------------------------------------------
    if choice == 1
        run main.m
        return
         
%--------------------------------------------------------------------------     
%                         Check for data errors
%--------------------------------------------------------------------------
    
    elseif choice == 2
        
        % Creates error message is no file has been loaded
        if isempty(file)
            uiwait(msgbox('Error: No file loaded'))
            
        % Runs function if file has been loaded
        else
            Table = errorClear(file);
        end
        
%--------------------------------------------------------------------------
%                             Generate plots
%--------------------------------------------------------------------------
        
    elseif choice == 3
        
        % Creates error message is no file has been loaded
        if isempty(file)
            uiwait(msgbox('Error: No file loaded'))
            
        % Runs function if file has been loaded
        else
            grades = Table{:, 3:width(Table)};
            gradesPlot(grades);
        end

%--------------------------------------------------------------------------
%                         Display list of grades
%--------------------------------------------------------------------------
    
    elseif choice == 4
        
        % Creates error message is no file has been loaded
        if isempty(file)
            uiwait(msgbox('Error: No file loaded'))
            
        % Runs function if file has been loaded
        else
            displayListOfGrades(Table);
            disp(displayListOfGrades(Table))
        end
      
%--------------------------------------------------------------------------
%                               Quit
%--------------------------------------------------------------------------

    elseif choice == 5
        % Clears workspace, closes all windows, breaks loop and closes program
        close all
        clear
        break
    end     
end