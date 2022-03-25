function repSignalPropWords(systemName,wordToRep,suggestion)
% Helps to replace the words in the signal properties.

signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
for ii = 1:numel(signals)
    srcPortH = get_param(signals(ii),'srcPortHandle');
    descriptionText = get(srcPortH,'Description');
    UserSpecifiedLogNameText = get(signals(ii),'UserSpecifiedLogName');
    if strfind(descriptionText,wordToRep)
        descriptionText = strrep(descriptionText,wordToRep,suggestion);
        set(srcPortH,'Description',char(descriptionText));
    end
    if strfind(UserSpecifiedLogNameText,wordToRep)
        UserSpecifiedLogNameText = strrep(UserSpecifiedLogNameText,wordToRep,suggestion);
        set(signals(ii),'UserSpecifiedLogName',char(UserSpecifiedLogNameText));
    end    
end

end
