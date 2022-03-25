function signalH = getSignalHandle(systemName,wordToFind)
% Helps to get the signal Handle of the given word.

signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
for ii = 1:numel(signals)
    curruntSignal = get_param(signals(ii),'Name');
    if strfind(curruntSignal,wordToFind)
        signalH = signals(ii);
    end
    srcPortH = get_param(signals(ii),'srcPortHandle');
    descriptionText = get(srcPortH,'Description');
    if strfind(descriptionText,wordToFind)
        signalH = signals(ii);
    end
    UserSpecifiedLogNameText = get(signals(ii),'UserSpecifiedLogName');
    if strfind(UserSpecifiedLogNameText,wordToFind)
        signalH = signals(ii);
    end
end

end