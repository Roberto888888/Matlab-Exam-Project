%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The user is asked to input a file, and the program will then find the   %
% errors. A message box then appears asking the user if he/she wants to   %
% remove the rows containing the error.                                   %
%                                                                         %
% Input:  N x m matrix (Student ID, Name and Assignments)                 %
% Output: N x m matrix (Student ID, Name and Assignments)                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Table = errorClear(filename)

%--------------------------------------------------------------------------
%                           Initialisation
%--------------------------------------------------------------------------
% Loads the file
filename = readtable(filename);

% Counts the rows and columns in the file
Rows = height(filename);
Columns = width(filename);

% Splits the numeric and student ID parts of the file in two seperate tables
table = table2array(filename(:,3:Columns));
StudentID = table2cell(filename(:,1))';

% Allocates zeros in a matrix/vectors same size/height as input file
Omat = zeros(size(filename));
Ovec = cellstr(num2str(Omat(:,1)));
Ovec2 = zeros(1,Rows);

% Grades
scale = [12, 10, 7, 4, 02, 00, -3];

%--------------------------------------------------------------------------
%                               Start
%--------------------------------------------------------------------------
    % Searches for identical student ID's and prints an error message. If
    % idential student ID's are present, '1' is put into an empty vector (Ovec2)
    % in the same position as the error occured. If an ID is not already present, 
    % it will be put into another empty vector (Ovec) for comparison, then the
    % loop will keep asking if a student ID is a part of the vector Ovec.
    for i = 1:Rows  
        if ismember(StudentID(i), Ovec)
            fprintf('Error detected: %s`s StudentID in row %0.0f has already parsed \n', char(filename.Name(i)), i)
            Ovec2(i) = 1;
        else
            Ovec(i) = StudentID(i);
        end
    end

    for i = 1:Rows
        for j = 1:Columns-2
            
            % Prints error message with row number and name if grade is not 
            % a part of the scale. If error occurs '1' is put into an empty 
            % vector (Ovec2) in the same position as the error occured
            if ~ismember(table(i,j),scale)
                fprintf('Error detected: %s`s grade is invalid in row %0.0f \n', char(filename.Name(i)),i);
                Ovec2(i) = 1;
            end
        end
    end
        
    % Defines question and title for popup message box
    question = sprintf('Do you wish to remove rows containing errors?');
    title = 'Data clear';

    while true
        % Creates yes/no message box
        button = questdlg(question, title, 'Yes', 'No', 'Yes');
        
        % If yes is selected the rows containing errors (1's in Ovec2) are removed
        if strcmpi(button, 'Yes')
            
            % Inverted loop (7, 6, 5,...) to avoid early rows being removed
            % and causing error for the following rows
                for ii = Rows:-1:1
                    if Ovec2(ii) == 1
                        filename(ii,:) = [];
                    end
                end
                
            % Closes the message box after loop is done
            Table = filename;
            disp(Table)
            break
        else
            
            % Closes the message box if no is selected
            Table = filename;
            break
        end
    end