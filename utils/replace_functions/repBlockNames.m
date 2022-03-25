function repBlockNames(systemName,wordToRep,suggestion)
% Helps to replace the word in blocknames.

blocks = find_system(systemName,'LookUnderMasks','on','FollowLinks','on');
for ii = 2:numel(blocks)
    try
        blockName = get_param(blocks{ii},'Name');
    catch ME
        if (strcmp(ME.identifier,'Simulink:Commands:InvSimulinkObjectName'))
            continue;
        end
    end
    if strfind(blockName,wordToRep)
        blockName = strrep(blockName,wordToRep,suggestion);
        set_param(blocks{ii},'Name',char(blockName));
    end
end
end