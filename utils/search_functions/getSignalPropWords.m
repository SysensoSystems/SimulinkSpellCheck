function signalPropWords = getSignalPropWords(systemName)
% Helps to get all the words in the signal properties of the given system.

signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
signalPropWords = {};
for ii = 1:numel(signals)
    srcPortH = get_param(signals(ii),'srcPortHandle');
    descriptionText = get(srcPortH,'Description');
    UserSpecifiedLogNameText = get(signals(ii),'UserSpecifiedLogName');
    signalPropWords = [signalPropWords descriptionText];
    signalPropWords = [signalPropWords UserSpecifiedLogNameText];
end

end