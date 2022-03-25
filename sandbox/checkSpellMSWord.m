function suggestion = checkSpellMSWord(word)

h = actxserver('word.application');
h.Document.Add;
suggestion = h.CheckSpelling(word);
h.Quit;

end