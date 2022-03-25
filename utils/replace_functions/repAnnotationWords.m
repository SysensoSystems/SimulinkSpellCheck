function  repAnnotationWords(systemName,wordToRep,suggestion)
% Helps to replace the word in annotations for the given system.

antn = find_system(systemName,'FindAll','on','type','annotation');
for ii = 1:numel(antn)
    antnText = get_param(antn(ii),'Text');
    if strfind(antnText,wordToRep)
        antnText = strrep(antnText,wordToRep,suggestion);
        set_param(antn(ii),'Text',char(antnText));
    end
end

end