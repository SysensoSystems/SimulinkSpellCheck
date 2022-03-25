function repDialogProperties(wordToRep,suggestion,paramInfoDetails)
% Helps to replace words in the dialog parameters.

for ii = 1:numel(paramInfoDetails)
    %paramInfo = Simulink.findVars(systemName,'Regexp','on','Name',['^' ii '.*']);
    %usedBlocks = paramInfo.UsedByBlocks;
    paramInfo = paramInfoDetails(ii);
    if ~isempty(paramInfo)
        paramInfoSize = size(paramInfo);
        for paramIndex = 1:paramInfoSize(1)
            blkCount = numel(paramInfo(paramIndex).UsedByBlocks);
            for jj = 1:blkCount
                blk = paramInfo(paramIndex).UsedByBlocks{jj};
                dialParams = get_param(blk,'DialogParameters');
                dialFields = fieldnames(dialParams);
                for kk = 1:numel(dialFields)
                    if strfind(get_param(blk,dialFields{kk}),wordToRep)
                        dialPropsWords = get_param(blk,dialFields{1});
                        dialPropsWords = strrep(dialPropsWords,wordToRep,suggestion);
                        set_param(blk,dialFields{1},char(dialPropsWords));
                    end
                end
            end
        end
    end
end


end