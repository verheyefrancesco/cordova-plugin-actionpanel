/**
  Phonegap ActionPanel Plugin
  https://github.com/francescobitmunks/cordova-plugin-cameraattachment

  MIT Licensed
*/

var exec = require('cordova/exec');
/**
 * Constructor
 */
function ActionPanelPlugin() {
    this._callback;
}

/**
 * show - true to show the ad, false to hide the ad
 */
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

ActionPanelPlugin.prototype._actionSelected = function(result) {
    var r = '' + result.replace(/&#34;/g, "\'");

    if (this._callback)
        this._callback('{\'status\': \'success\', \'data\': ' + r + '}');
}

ActionPanelPlugin.prototype._actionCancelled = function() {
    if (this._callback)
        this._callback('{\'status\': \'cancelled\'}');
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