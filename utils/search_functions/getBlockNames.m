function blockNames = getBlockNames(systemName)
% Helps to get all the words in blocknames of the given system.

blockNames ='';
blocks = find_system(systemName,'LookUnderMasks','on','FollowLinks','on');
for ii = 2:numel(blocks)
    blockName = get_param(blocks{ii},'Name');
    blockName = regexp(blockName,'[^\s]*','match');
    blockNames = [blockNames blockName];
end

end