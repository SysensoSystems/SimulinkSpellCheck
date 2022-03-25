function [wordParent,varargout] = getParent(systemName,matchType,wordToRep,varargin)
% Helps to get the parent of the given Word.

wordParent  = '';
switch matchType
    case 'Annotation'
        % get the parent of the annotation Words.
        antn = find_system(systemName,'FindAll','on','type','annotation');
        for ii = 1:numel(antn)
            antnText = get_param(antn(ii),'Text');
            if strfind(antnText,wordToRep)
                wordParent = get_param(antn(ii),'Parent');
            end
        end
    case 'Description'
        % get the parent of the Description Words.
        blocks = find_system(systemName,'LookUnderMasks','on','FollowLinks','on');
        for ii = 2:numel(blocks)
            descriptionText = get_param(blocks{ii},'Description');
            if strfind(descriptionText,wordToRep)
                wordParent = blocks{ii};
            end
        end
    case 'BlockNames'
        % get the parent of the Block name Words.
        blocks = find_system(systemName,'LookUnderMasks','on','FollowLinks','on');
        for ii = 2:numel(blocks)
            blockName = get_param(blocks{ii},'Name');
            if strfind(blockName,wordToRep)
                wordParent = blocks{ii};
            end
        end
    case 'DialogParameters'
        % get the parent of the Dialog Parameter Words.
        paramInfoDetails = varargin(1);
        for ii = numel(paramInfoDetails)
            %paramInfo = Simulink.findVars(systemName,'Regexp','on','Name',['^' ii '.*']);
            %usedBlocks = paramInfo.UsedByBlocks;
            paramInfo = paramInfoDetails{ii};
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
                                wordParent = blk;
                            end
                        end
                    end
                end
            end
        end
    case 'SignalNames'
        % get the parent of the signal name Words.
        signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
        for ii = 1:numel(signals)
            signalName = get_param(signals(ii),'Name');
            if strfind(signalName,wordToRep)
                wordParent = get_param(signals(ii),'Parent');
                srcHandle = get_param(signals(ii),'SrcBlockHandle');
                srcBlk = get_param(srcHandle,'Name');
                varargout{1} = srcBlk;
                dstHandle = get_param(signals(ii),'DstBlockHandle');
                dstBlk = get_param(dstHandle,'Name');
                varargout{2} = dstBlk;
                varargout{3} = signals(ii);
            end
        end
        % get the parent of the signal property Words.
    case 'SignalProperties'
        signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
        for ii = 1:numel(signals)
            srcPortH = get_param(signals(ii),'srcPortHandle');
            descriptionText = get(srcPortH,'Description');
            UserSpecifiedLogNameText = get(signals(ii),'UserSpecifiedLogName');
            if strfind(descriptionText,wordToRep)
               wordParent = get(signals(ii),'Parent');
            end
            if strfind(UserSpecifiedLogNameText,wordToRep)
                wordParent = get(signals(ii),'Parent');
            end            
        end
end

end