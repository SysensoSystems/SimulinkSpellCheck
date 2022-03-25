% Using Python modules.

% === installation
% $ pip install -U textblob
% $ python -m textblob.download_corpora
% ===reference
% 
% https://textblob.readthedocs.io/en/dev/
% https://textblob.readthedocs.io/en/dev/quickstart.html#spelling-correction

inputText = 'SampleWord';
pyObj = py.textblob.TextBlob(inputText);
corrected = pyObj.correct();