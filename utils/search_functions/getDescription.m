function descriptionWords = getDescription(systemName)
% Helps to get all the words in the description of the given system.

blocks = find_system(systemName,'LookUnderMasks','on','FollowLinks','on');
descriptionWords = '';
for ii = 2:numel(blocks)
    descriptionText = get_param(blocks{ii},'Description');
    descriptionText = regexp(descriptionText,'[^\s]*','match');
    descriptionWords = [descriptionWords descriptionText];
end

end