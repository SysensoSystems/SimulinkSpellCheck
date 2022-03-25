function varargout = spellCheckGUI(varargin)
% SPELLCHECKGUI MATLAB code for spellCheckGUI.fig
%      SPELLCHECKGUI, by itself, creates a new SPELLCHECKGUI or raises the existing
%      singleton*.
%
%      H = SPELLCHECKGUI returns the handle to a new SPELLCHECKGUI or the handle to
%      the existing singleton*.
%
%      SPELLCHECKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPELLCHECKGUI.M with the given input arguments.
%
%      SPELLCHECKGUI('Property','Value',...) creates a new SPELLCHECKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before spellCheckGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to spellCheckGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help spellCheckGUI

% Last Modified by GUIDE v2.5 03-Jul-2018 17:15:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @spellCheckGUI_OpeningFcn, ...
    'gui_OutputFcn',  @spellCheckGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before spellCheckGUI is made visible.
function spellCheckGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to spellCheckGUI (see VARARGIN)

% Choose default command line output for spellCheckGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes spellCheckGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% get the activeXcontrol of the MS Word.
wordHandle = actxserver('word.application');
wordHandle.Document.Add;
setappdata(handles.search_button,'wordHandle',wordHandle);
set(handles.customSpelling_edit,'Enable','off');
systemName = gcs;
setappdata(handles.applyButton,'systemName',systemName);
set(handles.gcs_edit,'String',systemName);


% --- Outputs from this function are returned to the command line.
function varargout = spellCheckGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in suggestions_listbox.
function suggestions_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to suggestions_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns suggestions_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from suggestions_listbox


% --- Executes during object creation, after setting all properties.
function suggestions_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to suggestions_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in customSpelling_checkbox.
function customSpelling_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to customSpelling_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of customSpelling_checkbox
if ~get(hObject,'Value')
    set(handles.customSpelling_edit,'Enable','off');
    set(handles.customSpelling_edit,'String','');
end
if get(hObject,'Value')
    set(handles.customSpelling_edit,'Enable','on');
    set(handles.customSpelling_edit,'String','');
end


function customSpelling_edit_Callback(hObject, eventdata, handles)
% hObject    handle to customSpelling_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of customSpelling_edit as text
%        str2double(get(hObject,'String')) returns contents of customSpelling_edit as a double


% --- Executes during object creation, after setting all properties.
function customSpelling_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to customSpelling_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in caseSensitive_checkbox.
function caseSensitive_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to caseSensitive_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of caseSensitive_checkbox


% --- Executes on button press in applyButton.
function applyButton_Callback(hObject, eventdata, handles)
% hObject    handle to applyButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
annotationWords = getappdata(handles.words_table,'annotationWords');
descriptionWords = getappdata(handles.words_table,'descriptionWords');
signalNameWords = getappdata(handles.words_table,'signalNameWords');
dialPropWords = getappdata(handles.words_table,'dialPropWords');
blockNameWords = getappdata(handles.words_table,'blockNameWords');
signalPropWords = getappdata(handles.words_table,'signalPropWords');
paramInfoDetails = getappdata(handles.words_table,'paramInfoDetails');

if get(handles.customSpelling_checkbox,'Value')
    suggestion = get(handles.customSpelling_edit,'String');
else
    suggestionList = get(handles.suggestions_listbox,'String');
    suggestion = suggestionList(get(handles.suggestions_listbox,'Value'));
end
systemName = getappdata(handles.applyButton,'systemName');
presentWord = getappdata(handles.words_table,'presentWord');
if isempty(suggestion) || strcmp(char(suggestion),'no suggestions')
    msgbox('Enter spelling','Enter Spell','modal');
    return;
end
modifyAllFlag = get(handles.modifyAll_radioButton,'Value');
wordNotChangedFlag = false;
% replacing the new spelling in the model.
% Annotations.
if ~isempty(strfind((ismember(annotationWords,presentWord)),1))
    if ~modifyAllFlag
        antnH = getAnnotationHandle(systemName,char(presentWord));
        hilite_system(antnH);
        setappdata(handles.highLight_button,'handleToHighlight',antnH);
        ButtonName = questdlg('Do you want to change spelling for this?','spelling change','Yes', 'No','Yes');
        hilite_system(antnH,'none');
        switch ButtonName
            case 'Yes'
                repAnnotationWords(systemName,presentWord,suggestion);
            case 'No'
                wordNotChangedFlag = true;
        end
    else
        repAnnotationWords(systemName,presentWord,suggestion);
        msgbox('Applied Successfully','Word Changed','modal');
    end
end
% Description.
if ~isempty(strfind((ismember(descriptionWords,presentWord)),1))
    if ~modifyAllFlag
        wordParent = getParent(systemName,'Description',presentWord);
        if ~isempty(wordParent)
            hilite_system(wordParent);
            setappdata(handles.highLight_button,'handleToHighlight',wordParent);
            ButtonName = questdlg('Do you want to change spelling for this?','spelling change','Yes', 'No','Yes');
            hilite_system(wordParent,'none');
            switch ButtonName
                case 'Yes'
                    repDescriptionWord(systemName,presentWord,suggestion);
                case 'No'
                    wordNotChangedFlag = true;
            end
        end
    else
        repDescriptionWord(systemName,presentWord,suggestion);
        msgbox('Applied Successfully','Word Changed','modal');
    end
end
% Signal Names.
if ~isempty(strfind((ismember(signalNameWords,presentWord)),1))
    if ~modifyAllFlag
        signalH = getSignalHandle(systemName,char(presentWord));
        hilite_system(signalH);
        setappdata(handles.highLight_button,'handleToHighlight',signalH);
        ButtonName = questdlg('Do you want to change spelling for this?','spelling change','Yes', 'No','Yes');
        hilite_system(signalH,'none');
        switch ButtonName
            case 'Yes'
                repSignalNames(systemName,presentWord,suggestion);
            case 'No'
                wordNotChangedFlag = true;
        end
    else
        repSignalNames(systemName,presentWord,suggestion);
        msgbox('Applied Successfully','Word Changed','modal');
    end
    
end
% Dialog properties.
if ~isempty(strfind((ismember(dialPropWords,presentWord)),1))
    if ~modifyAllFlag
        wordParent = getParent(systemName,'DialogParameters',presentWord);
        if ~isempty(wordParent)
            hilite_system(wordParent);
            setappdata(handles.highLight_button,'handleToHighlight',wordParent);
            ButtonName = questdlg('Do you want to change spelling for this?','spelling change','Yes', 'No','Yes');
            hilite_system(wordParent,'none');
            switch ButtonName
                case 'Yes'
                    repDialogProperties(presentWord,suggestion,paramInfoDetails);
                case 'No'
                    wordNotChangedFlag = true;
            end
        end
    else
        repDialogProperties(presentWord,suggestion,paramInfoDetails);
        msgbox('Applied Successfully','Word Changed','modal');
    end
end
% Block Names.
if ~isempty(strfind((ismember(blockNameWords,presentWord)),1))
    if ~modifyAllFlag
        wordParent = getParent(systemName,'BlockNames',presentWord);
        if ~isempty(wordParent)
            hilite_system(wordParent);
            setappdata(handles.highLight_button,'handleToHighlight',wordParent);
            ButtonName = questdlg('Do you want to change spelling for this?','spelling change','Yes', 'No','Yes');
            hilite_system(wordParent,'none');
            switch ButtonName
                case 'Yes'
                    repBlockNames(systemName,presentWord,suggestion);
                case 'No'
                    wordNotChangedFlag = true;
            end
        end
    else
        repBlockNames(systemName,presentWord,suggestion);
        msgbox('Applied Successfully','Word Changed','modal');
    end
end
% Signal Properties.
if ~isempty(strfind((ismember(signalPropWords,presentWord)),1))
    if ~modifyAllFlag
        signalH = getSignalHandle(systemName,char(presentWord));
        hilite_system(signalH);
        setappdata(handles.highLight_button,'handleToHighlight',signalH);
        ButtonName = questdlg('Do you want to change spelling for this?','spelling change','Yes', 'No','Yes');
        hilite_system(signalH,'none');
        switch ButtonName
            case 'Yes'
                repSignalPropWords(systemName,presentWord,suggestion);
            case 'No'
                wordNotChangedFlag = true;
        end
    else
        repSignalPropWords(systemName,presentWord,suggestion);
        msgbox('Applied Successfully','Word Changed','modal');
    end
end

% Removes the changed one from the list.
selectedRow = getappdata(handles.words_table,'selectedRow');
tableData = get(handles.words_table,'data');
if ~wordNotChangedFlag
    tableData(selectedRow,:) = [];
end
set(handles.words_table,'data',tableData);
set(handles.suggestions_listbox,'String','','value',1);
set(handles.customSpelling_edit,'Enable','off');
set(handles.customSpelling_edit,'String','');
set(handles.customSpelling_checkbox,'Value',0);
set(handles.display_table,'data',{});
setappdata(handles.words_table,'selectedRow',1);

% Remove the previous highlighting.
handleToHighlight = getappdata(handles.highLight_button,'handleToHighlight');
if ~isempty(handleToHighlight)
    if ishandle(handleToHighlight)
        hilite_system(handleToHighlight,'none');
    end
end

% --- Executes on button press in close_button.
function close_button_Callback(hObject, eventdata, handles)
% hObject    handle to close_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes on button press in annotations_checkbox.
function annotations_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to annotations_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of annotations_checkbox


% --- Executes on button press in description_checkbox.
function description_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to description_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of description_checkbox


% --- Executes on button press in signalNames_checkbox.
function signalNames_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to signalNames_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of signalNames_checkbox


% --- Executes on button press in dialogProperties_checkbox.
function dialogProperties_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to dialogProperties_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dialogProperties_checkbox


% --- Executes on button press in blockNames_checkbox.
function blockNames_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to blockNames_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of blockNames_checkbox


% --- Executes on button press in signalProperties_checkbox.
function signalProperties_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to signalProperties_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of signalProperties_checkbox


% --- Executes on button press in search_button.
function search_button_Callback(hObject, eventdata, handles)
% hObject    handle to search_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

searchingMsgBoxH = msgbox('Search is in progres...');
allWords = '';
systemName = getappdata(handles.applyButton,'systemName');

% Get all the words in Annotations.
if get(handles.annotations_checkbox,'Value')
    annotationWords = getAnnotationWords(systemName);
    setappdata(handles.words_table,'annotationWords',annotationWords);
    allWords = [allWords annotationWords];
end
% Get all the words in Description.
if get(handles.description_checkbox,'Value')
    descriptionWords = getDescription(systemName);
    setappdata(handles.words_table,'descriptionWords',descriptionWords);
    allWords = [allWords descriptionWords];
end
% Get all the words in signal names.
if get(handles.signalNames_checkbox,'Value')
    signalNameWords = getSignalNames(systemName);
    setappdata(handles.words_table,'signalNameWords',signalNameWords);
    allWords = [allWords signalNameWords];
end
% Get all the words in Dialog properties.
if get(handles.dialogProperties_checkbox,'Value')
    [dialPropWords,paramInfoDetails] = getDialogProperties(systemName);
    setappdata(handles.words_table,'dialPropWords',dialPropWords);
    setappdata(handles.words_table,'paramInfoDetails',paramInfoDetails);
    allWords = [allWords dialPropWords];
end
% Get all the words in block names.
if get(handles.blockNames_checkbox,'Value')
    blockNameWords = getBlockNames(systemName);
    setappdata(handles.words_table,'blockNameWords',blockNameWords);
    allWords = [allWords blockNameWords];
end
% Get all the words in signal properties.
if get(handles.signalProperties_checkbox,'Value')
    signalPropWords = getSignalPropWords(systemName);
    setappdata(handles.words_table,'signalPropWords',signalPropWords);
    allWords = [allWords signalPropWords];
end
% fetch the unique words.
allWords = unique(allWords);
% sort the word list.
allWords = sort(allWords);
wordHandle = getappdata(handles.search_button,'wordHandle');
wordCount = numel(allWords);
finalWords = '';
for ii = 1:wordCount
    word = char(allWords(ii));
    % Check the word is spelled correct or not using MS Word activeXcontrol.
    suggestion = wordHandle.CheckSpelling(word);
    if ~suggestion
        % save the mistaken words.
        finalWords = [finalWords; allWords(ii)];
    end
end
tableData = {};
if isempty(finalWords)
    msgbox('All words are correct','All correct','modal');
    set(handles.words_table,'data',[]);
    set(handles.suggestions_listbox,'String','');
    set(handles.display_table,'data',[]);
else
    for ii = 1:numel(finalWords)
        tableData{ii,1} = finalWords{ii};
    end
    % Set the word list in uitable.
    set(handles.words_table,'data',tableData);
end
setappdata(handles.highLight_button,'handleToHighlight',[]);
if ishandle(searchingMsgBoxH)
    delete(searchingMsgBoxH);
end


% --- Executes on button press in search_button.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to search_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in highlight_button.
function highlight_button_Callback(hObject, eventdata, handles)
% hObject    handle to highlight_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in words_table.
function words_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to words_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
systemName = getappdata(handles.applyButton,'systemName');
wordHandle = getappdata(handles.search_button,'wordHandle');
tableData = get(handles.words_table,'data');
try
    if ~isempty(eventdata.Indices)
        selectedRow = eventdata.Indices(1);
    else
        selectedRow = getappdata(handles.words_table,'selectedRow');
    end
    try
        presentWord =char(tableData(selectedRow,1));
        
    catch ME
        if (strcmp(ME.identifier,'MATLAB:badsubscript'))
            set(handles.display_table,'data',{});
            return;
        end
    end
    setappdata(handles.words_table,'selectedRow',selectedRow);
    setappdata(handles.words_table,'presentWord',presentWord);
    if wordHandle.GetSpellingSuggestions(presentWord).count > 0
        count = wordHandle.GetSpellingSuggestions(presentWord).count;
        for ii = 1:count
            % Get all the suggessions of the word using MS Word.
            suggestions{ii} = wordHandle.GetSpellingSuggestions(presentWord).Item(ii).get('name');
        end
    else
        %If incorrect but there are no suggestions.
        suggestions = {'no suggestions'};
    end
    if numel(suggestions) == 1
        set(handles.suggestions_listbox,'String',suggestions,'value',1);
    else
        set(handles.suggestions_listbox,'String',suggestions,'value',1);
    end
    displayTableData = '';%get(handles.display_table,'data');
    % set matching catagory
    annotationWords = getappdata(handles.words_table,'annotationWords');
    descriptionWords = getappdata(handles.words_table,'descriptionWords');
    signalNameWords = getappdata(handles.words_table,'signalNameWords');
    dialPropWords = getappdata(handles.words_table,'dialPropWords');
    blockNameWords = getappdata(handles.words_table,'blockNameWords');
    signalPropWords = getappdata(handles.words_table,'signalPropWords');
    paramInfoDetails = getappdata(handles.words_table,'paramInfoDetails');
    
    % Get the  Parent for the present Word to display.
    % Get parent of the Annotation word.
    if ~isempty(strfind((ismember(annotationWords,presentWord)),1))
        wordParent = getParent(systemName,'Annotation',presentWord);
        if ~isempty(wordParent)
            dispData = {'Annotations' , presentWord ,wordParent,'',''};
            displayTableData = [displayTableData; dispData];
        end
    end
    % Get parent of the description word.
    if ~isempty(strfind((ismember(descriptionWords,presentWord)),1))
        wordParent = getParent(systemName,'Description',presentWord);
        if ~isempty(wordParent)
            dispData = {'Description' , presentWord ,wordParent,'',''};
            displayTableData = [displayTableData; dispData];
        end
    end
    % Get parent of the signal name words.
    if ~isempty(strfind((ismember(signalNameWords,presentWord)),1))
        [wordParent,src,dst] = getParent(systemName,'SignalNames',presentWord);
        if ~isempty(wordParent)
            dstSize = size(dst);
            if dstSize(1)>1
                dst = dst{1};
            end
            dispData = {'Signal Names' , presentWord ,wordParent,src,dst};
            displayTableData = [displayTableData; dispData];
        end
    end
    % Get parent of the dialog property words.
    if ~isempty(strfind((ismember(dialPropWords,presentWord)),1))
        wordParent = getParent(systemName,'DialogParameters',presentWord,paramInfoDetails);
        if ~isempty(wordParent)
            dispData = {'Dialog parameters' , presentWord ,wordParent,'',''};
            displayTableData = [displayTableData; dispData];
        end
    end
    % Get parent of Block Name words.
    if ~isempty(strfind((ismember(blockNameWords,presentWord)),1))
        wordParent = getParent(systemName,'BlockNames',presentWord);
        if ~isempty(wordParent)
            dispData = {'Block Names' , presentWord ,wordParent,'',''};
            displayTableData = [displayTableData; dispData];
        end
    end
    % Get parent of the signal property words.
    if ~isempty(strfind((ismember(signalPropWords,presentWord)),1))
        wordParent = getParent(systemName,'SignalProperties',presentWord);
        if ~isempty(wordParent)
            dispData = {'Signal Properties' , presentWord ,wordParent,'',''};
            displayTableData = [displayTableData; dispData];
        end
    end
    set(handles.display_table,'data',displayTableData);
    handleToHighlight = getappdata(handles.highLight_button,'handleToHighlight');
    if ~isempty(handleToHighlight)
        if ishandle(handleToHighlight)
            hilite_system(handleToHighlight,'none');
        end
    end
    % Error msg for any changes made workspace/variable.
catch ME
    if (strcmp(ME.identifier,'MATLAB:badsubscript'))
        errordlg('Model failed to successfully compile, any cached results may be incomplete.', 'Model not compiled.');
    end
end



% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if  isfield(handles,'wordHandle')
    % Close the MS Word activeXcontrol.
    wordHandle = getappdata(handles.search_button,'wordHandle');
    wordHandle.Quit;
end
delete(hObject);


% --- Executes on button press in modifyAll_radioButton.
function modifyAll_radioButton_Callback(hObject, eventdata, handles)
% hObject    handle to modifyAll_radioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of modifyAll_radioButton


% --- Executes on button press in modifyOneByOne_radioButton.
function modifyOneByOne_radioButton_Callback(hObject, eventdata, handles)
% hObject    handle to modifyOneByOne_radioButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of modifyOneByOne_radioButton


% --- Executes on button press in moidfyOneByOne_button.
function moidfyOneByOne_button_Callback(hObject, eventdata, handles)
% hObject    handle to moidfyOneByOne_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of moidfyOneByOne_button


% --- Executes on button press in highLight_button.
function highLight_button_Callback(hObject, eventdata, handles)
% hObject    handle to highLight_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
displayData = get(handles.display_table,'data');
systemName = getappdata(handles.applyButton,'systemName');
selectedRow = getappdata(handles.display_table,'selectedRow');
handleToHighlight = [];
% Highlight the source of selected data.
if strcmp(char(displayData(selectedRow,1)),'Block Names') || strcmp(char(displayData(selectedRow,1)),'Dialog parameters') || strcmp(char(displayData(selectedRow,1)),'Description')
    hilite_system(char(displayData(selectedRow,3)));
    handleToHighlight = char(displayData(selectedRow,3));
elseif strcmp(char(displayData(selectedRow,1)),'Signal Names') || strcmp(char(displayData(selectedRow,1)),'Signal Properties')
    signalH = getSignalHandle(systemName,char(displayData(selectedRow,2)));
    hilite_system(signalH);
    handleToHighlight = signalH;
elseif strcmp(char(displayData(selectedRow,1)),'Annotations')
    antnH = getAnnotationHandle(systemName,char(displayData(selectedRow,2)));
    hilite_system(antnH);
    handleToHighlight = antnH;
end
setappdata(handles.highLight_button,'handleToHighlight',handleToHighlight);


% --- Executes when selected cell(s) is changed in display_table.
function display_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to display_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
if ~isempty(eventdata.Indices)
    selectedRow = eventdata.Indices(1);
else
    selectedRow = 1;
end
setappdata(handles.display_table,'selectedRow',selectedRow);
handleToHighlight = getappdata(handles.highLight_button,'handleToHighlight');
if ~isempty(handleToHighlight)
    if ishandle(handleToHighlight)
        hilite_system(handleToHighlight,'none');
    end
end


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function display_table_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to display_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes when entered data in editable cell(s) in display_table.
function display_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to display_table (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5



function gcs_edit_Callback(hObject, eventdata, handles)
% hObject    handle to gcs_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gcs_text as text
%        str2double(get(hObject,'String')) returns contents of gcs_text as a double


% --- Executes during object creation, after setting all properties.
function gcs_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gcs_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
