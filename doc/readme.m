%% Simulink Spell Checking Utility
% Helps to check the spelling within the Simulink model using Microsoft
% ActiveX control.
%
%%
% Developed by: <http://www.sysenso.com Sysenso Systems>
% Contact: contactus@sysenso.com
%% Version Log
% 1.0 - Initial Version.

%% How to launch it:
% Please add the entire folder into MATLAB path than launch Simulink.
% If the Simulink is already launched then after adding this utility to MATLAB path,
% type ">> sl_refresh_customizations" in the MATLAB command window.
%
% Within the Simulink model window, the tool("SpellCheck") can be invoked by right-clicking context menu
% or from the "File" menu.
%

%% Usage instructions
%
% <<doc/ToolUsage.png>>
%
% # Select the constructs to be spell checked within the current Simulink model.
% # Search button will collect all the words and initiate the Microsoft
% ActiveX control. Using that it will populate the words that have to be
% corrected.
% # List of words that have to be corrected.
% # For a selected word, the list of suggestions that are found.
% # For a selected word, the locations where it appears in a Simulink model
% are listed.
% # We can use "Highlight" option to locate the model path.
% # Instead of using one of the suggestions, user can add a custom spelling.
% # User can use either of Modification method. The "Modify All" will
% modify all the instances of the selected word with its suggestion.
% The "Modify one by one" will prompt the user before modifying every
% instance/location.
% # Apply button to initiate the modification.
% # Close button to close the spell checking utility.


%% Future Work
% Selected spelling suggestion have to be recorded/remembered.