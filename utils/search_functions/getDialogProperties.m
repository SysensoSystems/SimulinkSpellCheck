function [dialPropsWords,paramInfoDetails] = getDialogProperties(systemName)
% Helps to get all the words in the dialog parameters of the given system.

dialPropsWords = '';
paramInfoDetails = '';
for ii = ['A':'Z','a':'z']
    paramInfo = Simulink.findVars(systemName,'Regexp','on','Name',['^' ii '.*']);
    paramInfoDetails = [paramInfoDetails; paramInfo];
    if ~isempty(paramInfo)
        paramName = paramInfo.Name;
        paramName = regexp(paramName,'[^\s]*','match');
        dialPropsWords = [dialPropsWords paramName];
    end
end

end