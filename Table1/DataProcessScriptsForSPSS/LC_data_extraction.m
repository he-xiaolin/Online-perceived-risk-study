%% Load data
clear;clc;
close all;
dir='../../Data/SubjectiveRatings.mat';
load(dir);
%% LC data reorganisation
% Initialize empty arrays to store the reorganized data
participant_ids = [];
event_numbers = [];
clip_numbers = [];
perceived_risk_ratings = [];
lateral_categories = {};
acc_categories = {};
merging_distance = [];

% Lateral categories (from your screenshot)
lateral_category_values = {'1m/s', '1m/s', '1m/s', '1m/s', '1m/s', '1m/s', '3m/s', '3m/s', '3m/s', '3m/s', '3m/s', '3m/s', ...
                           'Fragmented (1 m/s)', 'Fragmented (1 m/s)', 'Fragmented (1 m/s)', 'Fragmented (1 m/s)', 'Fragmented (1 m/s)', 'Fragmented (1 m/s)', ...
                           'Abortion (1 m/s)', 'Abortion (1 m/s)', 'Abortion (1 m/s)', 'Abortion (1 m/s)', 'Abortion (1 m/s)', 'Abortion (1 m/s)'};

% ACC categories (from your screenshot)
acc_category_values = {'cautious', 'cautious', 'mild', 'mild', 'aggressive', 'aggressive', 'cautious', 'cautious', 'mild', 'mild', 'aggressive', 'aggressive', ...
                       'cautious', 'cautious', 'mild', 'mild', 'aggressive', 'aggressive', 'cautious', 'cautious', 'mild', 'mild', 'aggressive', 'aggressive'};

% Merging distance (from your screenshot)
merging_distance_values = [5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15, 5, 15];

% Iterate over the 24 event numbers for LC
for i = 1:24
    % Extract event ratings and participant IDs for this event number
    event_ratings_condition = LC_PR(i).event_ratings; 
    idx_condition = LC_PR(i).idx;
    
    % Add data for each of the 6 clips (columns of event_ratings)
    for clip = 1:6
        participant_ids = [participant_ids; idx_condition]; % Participant IDs
        event_numbers = [event_numbers; repmat(i, size(idx_condition))]; % Event number (1 to 24)
        clip_numbers = [clip_numbers; repmat(clip, size(idx_condition))]; % Clip number (1 to 6)
        perceived_risk_ratings = [perceived_risk_ratings; event_ratings_condition(:, clip)]; % Perceived Risk Ratings
        
        % Add corresponding categorical and continuous parameter values
        lateral_categories = [lateral_categories; repmat({lateral_category_values{i}}, size(idx_condition))]; % Cell array for lateral categories
        acc_categories = [acc_categories; repmat({acc_category_values{i}}, size(idx_condition))]; % Cell array for ACC categories
        merging_distance = [merging_distance; repmat(merging_distance_values(i), size(idx_condition))]; % Numeric array for merging distance
    end
end

% Create a table to store the reorganized data
data_table_lc = table(event_numbers, participant_ids, clip_numbers, ...
                   lateral_categories, acc_categories, merging_distance, perceived_risk_ratings, ...
                   'VariableNames', {'EventNumber', 'ParticipantID', 'ClipNumber', ...
                                     'LateralCategories', 'ACCCategories', 'MergingDistance', 'PerceivedRiskRating'});

% Save the table as a CSV file for import into SPSS
writetable(data_table_lc, 'reorganized_LC_data.csv');
