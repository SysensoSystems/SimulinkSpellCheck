function sl_customization(cm)
% Menu item for Simulink Spell Check under Tools menu and also in context
% menu.

%% Register custom Contextmenu function
cm.addCustomMenuFcn('Simulink:ToolsMenu', @getMyMenuItems);
cm.addCustomMenuFcn('Simulink:PreContextMenu', @getMyContextMenuItems);

end

%% Define the custom menu function.
function schemaFcns = getMyMenuItems(callbackInfo)  %#ok<*INUSD>
% Define the Item in Menu
schemaFcns = {@getMenu};
end
%% Define the custom context menu function.
function schemaFcns = getMyContextMenuItems(callbackInfo)  %#ok<*INUSD>
% Define the Item in Menu
schemaFcns = {@getContextMenu};
end

function schema = getMenu(callbackInfo)
schema = sl_action_schema;
schema.label = 'SpellCheck';
schema.callback = @menu_Callback;
end

function schema = getContextMenu(callbackInfo)
schema = sl_action_schema;
schema.label = 'SpellCheck';
schema.callback = @contextMenu_Callback;
end

function menu_Callback(callbackInfo)
spellCheckGUI;
end

function contextMenu_Callback(callbackInfo)
spellCheckGUI;
end