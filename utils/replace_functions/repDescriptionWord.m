function  repDescriptionWord(systemName,wordToRep,suggestion)
% Helps replace the word in the description.

blocks = find_system(systemName,'LookUnderMasks','on','FollowLinks','on');
for ii = 2:numel(blocks)
    descriptionText = get_param(blocks{ii},'Description');
    if strfind(descriptionText,wordToRep)
        descriptionText = strrep(descriptionText,wordToRep,suggestion);
        set_param(blocks{ii},'Description',descriptionText);
    end
end

end