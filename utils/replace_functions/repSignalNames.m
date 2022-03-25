function  repSignalNames(systemName,wordToRep,suggestion)
% Helps to replace the words in the signal names.

signals = find_system(systemName,'findAll','on','LookUnderMasks','on','type','line');
for ii = 1:numel(signals)
    signalName = get_param(signals(ii),'Name');
    if strfind(signalName,wordToRep)
        signalName = strrep(signalName,wordToRep,suggestion);
        set(signals(ii),'Name',char(signalName));
    end
end

end