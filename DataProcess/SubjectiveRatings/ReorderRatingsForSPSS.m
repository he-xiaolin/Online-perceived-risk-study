% This function is to re-order subjective ratings by clips for SPSS
% analysis, which means the clip number is the largest category. 
% Variables XX_Ratings_Clip (1x5 or 1x6 cell array) will be generated. 
% One has to copy and paste each cell element to SPSS for the analysis. 
%% load data
clear;clc;close all
dir='../../Data/SubjectiveRatings.mat';
load(dir);
%% Extract LC
LC_Ratings_Clip_Cell=cell(1,6);
for i=1:6
LC_Ratings_Clip_Cell{i}=cell(1,24);
end
len0=0;
for i=1:24
    event=LC_PR(i).event_ratings;
    temp=sum(event,2);
    idx=find(temp);
    if isempty(idx)
        continue;
    else
    len=length(idx);
    ClipRating=[];
    if len>len0
        len0=len;
    end
        for j=1:len
            ClipRating(end+1,1:6)=event(idx(j),:)';
        end
        for k=1:6 %clip number
    LC_Ratings_Clip_Cell{k}{i}=ClipRating(:,k);
        end
    end
end
LC_Ratings_Clip=cell(1,6);
for i=1:6
    for j=1:24
    clip_rating_temp=LC_Ratings_Clip_Cell{1,i}{1,j};
    clip_rating_temp(end+1:len0)=NaN;
    LC_Ratings_Clip{1,i}(:,end+1)=clip_rating_temp;
    end
end

    LC = [LC_Ratings_Clip{1,1},LC_Ratings_Clip{1,2},LC_Ratings_Clip{1,3},...
        LC_Ratings_Clip{1,4},LC_Ratings_Clip{1,5},LC_Ratings_Clip{1,6}];
    

%% Extract SVM
SVM_Ratings_Clip_Cell=cell(1,5);
for i=1:5
SVM_Ratings_Clip_Cell{i}=cell(1,27);
end
len0=0;
for i=1:27
    event=SVM_PR(i).event_ratings;
    temp=sum(event,2);
    idx=find(temp);
    if isempty(idx)
        continue;
    else
    len=length(idx);
    ClipRating=[];
    if len>len0
        len0=len;
    end
        for j=1:len
            ClipRating(end+1,1:5)=event(idx(j),:)';
        end
        for k=1:5 %clip number
    SVM_Ratings_Clip_Cell{k}{i}=ClipRating(:,k);
        end
    end
end
SVM_Ratings_Clip=cell(1,5);
for i=1:5
    for j=1:27
    clip_rating_temp=SVM_Ratings_Clip_Cell{1,i}{1,j};
    clip_rating_temp(end+1:len0)=NaN;
    SVM_Ratings_Clip{1,i}(:,end+1)=clip_rating_temp;
    end
end

    SVM = [SVM_Ratings_Clip{1,1},SVM_Ratings_Clip{1,2},SVM_Ratings_Clip{1,3},...
        SVM_Ratings_Clip{1,4},SVM_Ratings_Clip{1,5}];

%% Extract HB
HB_Ratings_Clip_Cell=cell(1,5);
for i=1:5
HB_Ratings_Clip_Cell{i}=cell(1,27);
end
len0=0;
for i=1:27
    event=HB_PR(i).event_ratings;
    temp=sum(event,2);
    idx=find(temp);
    if isempty(idx)
        continue;
    else
    len=length(idx);
    ClipRating=[];
    if len>len0
        len0=len;
    end
        for j=1:len
            ClipRating(end+1,1:5)=event(idx(j),:)';
        end
        for k=1:5 %clip number
    HB_Ratings_Clip_Cell{k}{i}=ClipRating(:,k);
        end
    end
end
HB_Ratings_Clip=cell(1,5);
for i=1:5
    for j=1:27
    clip_rating_temp=HB_Ratings_Clip_Cell{1,i}{1,j};
    clip_rating_temp(end+1:len0)=NaN;
    HB_Ratings_Clip{1,i}(:,end+1)=clip_rating_temp;
    end
end

    HB = [HB_Ratings_Clip{1,1},HB_Ratings_Clip{1,2},HB_Ratings_Clip{1,3},...
        HB_Ratings_Clip{1,4},HB_Ratings_Clip{1,5}];
%% Extract MB
MB_Ratings_Clip_Cell=cell(1,5);
for i=1:5
MB_Ratings_Clip_Cell{i}=cell(1,27);
end
len0=0;
for i=1:27
    event=MB_PR(i).event_ratings;
    temp=sum(event,2);
    idx=find(temp);
    if isempty(idx)
        continue;
    else
    len=length(idx);
    ClipRating=[];
    if len>len0
        len0=len;
    end
        for j=1:len
            ClipRating(end+1,1:5)=event(idx(j),:)';
        end
        for k=1:5 %clip number
    MB_Ratings_Clip_Cell{k}{i}=ClipRating(:,k);
        end
    end
end
MB_Ratings_Clip=cell(1,5);
for i=1:5
    for j=1:27
    clip_rating_temp=MB_Ratings_Clip_Cell{1,i}{1,j};
    clip_rating_temp(end+1:len0)=NaN;
    MB_Ratings_Clip{1,i}(:,end+1)=clip_rating_temp;
    end
end

    MB = [MB_Ratings_Clip{1,1},MB_Ratings_Clip{1,2},MB_Ratings_Clip{1,3},...
        MB_Ratings_Clip{1,4},MB_Ratings_Clip{1,5}];

