function annotationWords = getAnnotationWords(systemName)
% Helps to get all the words in annotations of the given system.

antn = find_system(systemName,'FindAll','on','type','annotation');
annotationWords = '';
for ii = 1:numel(antn)
    antnText = get_param(antn(ii),'Text');
    antnText = regexp(antnText,'[^\s]*','match');
    annotationWords = [annotationWords antnText];
end

end