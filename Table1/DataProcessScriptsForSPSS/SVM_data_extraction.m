%% Load data
clear;clc;
close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
%% SVM data reorganisation
% Initialize empty arrays to store the reorganized data
participant_ids = [];
event_numbers = [];
clip_numbers = [];
perceived_risk_ratings = [];
speed = [];
braking_intensity = [];
merging_distance = [];

% Create arrays for your continuous parameters (from the second screenshot)
speed_values = [80, 80, 80, 80, 80, 80, 80, 80, 80, 100, 100, 100, 100, 100, 100, 100, 100, 100, 120, 120, 120, 120, 120, 120, 120, 120, 120];
braking_intensity_values = [-2, -2, -2, -5, -5, -5, -8, -8, -8, -2, -2, -2, -5, -5, -5, -8, -8, -8, -2, -2, -2, -5, -5, -5, -8, -8, -8];
merging_distance_values = [5, 15, 25, 5, 15, 25, 5, 15, 25, 5, 15, 25, 5, 15, 25, 5, 15, 25, 5, 15, 25, 5, 15, 25, 5, 15, 25];

% Iterate over the 27 event numbers
for i = 1:27
    % Extract event ratings and participant IDs for this event number
    event_ratings_condition = SVM_PR(i).event_ratings; 
    idx_condition = SVM_PR(i).idx;
    
    % Add data for each of the 5 clips (columns of event_ratings)
    for clip = 1:5
        participant_ids = [participant_ids; idx_condition]; % Participant IDs
        event_numbers = [event_numbers; repmat(i, size(idx_condition))]; % Event number (1 to 27)
        clip_numbers = [clip_numbers; repmat(clip, size(idx_condition))]; % Clip number (1 to 5)
        perceived_risk_ratings = [perceived_risk_ratings; event_ratings_condition(:, clip)]; % Perceived Risk Ratings
        
        % Add corresponding continuous parameter values
        speed = [speed; repmat(speed_values(i), size(idx_condition))];
        braking_intensity = [braking_intensity; repmat(braking_intensity_values(i), size(idx_condition))];
        merging_distance = [merging_distance; repmat(merging_distance_values(i), size(idx_condition))];
    end
end

% Create a table to store the reorganized data
data_table = table(event_numbers, participant_ids, clip_numbers, ...
                   speed, braking_intensity, merging_distance, perceived_risk_ratings, ...
                   'VariableNames', {'EventNumber', 'ParticipantID', 'ClipNumber', ...
                                     'Speed', 'BrakingIntensity', 'MergingDistance', 'PerceivedRiskRating'});

% Save the table as a CSV file for import into SPSS
writetable(data_table, 'reorganized_SVM_data.csv');
