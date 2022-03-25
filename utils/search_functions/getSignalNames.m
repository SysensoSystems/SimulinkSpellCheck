function signalNameWords = getSignalNames(systemName)
% Helps to get all the words in the signal names of the given system.

signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
signalNameWords = '';
for ii = 1:numel(signals)
    signalName = get_param(signals(ii),'Name');
    signalName = regexp(signalName,'[^\s]*','match');
    signalNameWords = [signalNameWords signalName];
end

end