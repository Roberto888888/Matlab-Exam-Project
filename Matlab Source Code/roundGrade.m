%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The program inputs the vector and automatically rounds the grades       %
% towards the closets actual grade. If a grade is in between two grades   %                                                                 %
% it will be round upwards.                                               %
%                                                                         %
% Input:  Vector or scalar with grade(s)                                  %
% Output: Vector or scalar with rounded grade(s)                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function gradesRounded = roundGrade(grades)
% Defines the scale
scale = [12, 10, 7, 4, 02, 00, -3];

% Findes which number the the scale is closest to the grade and rounds
% towards that. If a grade is right between two grades it will round up.
gradesRounded = interp1(scale, scale, grades, 'nearest', 'extrap');