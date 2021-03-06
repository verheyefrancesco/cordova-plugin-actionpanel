
var exec = require('cordova/exec');
/**
 * Constructor
 */
function ActionPanelPlugin() {
    this._callback;
}

ActionPanelPlugin.prototype.show = function(options, cb) {

    var defaults = {
        title : 'Actions',
        actions : [],
        cancelButtonText : 'Cancel'
    };

    for (var key in defaults) {
        if (typeof options[key] !== "undefined")
            defaults[key] = options[key];
    }
    this._callback = cb;

    exec(null, 
      null, 
      "ActionPanelPlugin", 
      "show",
      [defaults]
    );
};

ActionPanelPlugin.prototype._actionSelected = function(json) {
    json = json.replace(/&#34;/g, '"');
    if (this._callback)
        this._callback({status: 'success', data: JSON.parse(json)});
}

ActionPanelPlugin.prototype._actionCancelled = function() {
    if (this._callback)
        this._callback({status: 'cancelled'});
}


var actionPanelPlugin = new ActionPanelPlugin();
module.exports = actionPanelPlugin;

// Make plugin work under window.plugins
if (!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.actionPanelPlugin) {
    window.plugins.actionPanelPlugin = actionPanelPlugin;
}