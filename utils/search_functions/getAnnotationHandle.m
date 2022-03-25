function antnHandle = getAnnotationHandle(systemName,annotationWord)
% Helps to get the Handle of the given annotation word.

antn = find_system(systemName,'FindAll','on','type','annotation');
for ii = 1:numel(antn)
    antnText = get_param(antn(ii),'Text');
    if strfind(antnText,annotationWord)
        antnHandle = antn(ii);
    end
end

end