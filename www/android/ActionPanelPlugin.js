
/**
 * Constructor
 */
function ActionPanelPlugin() {
  //this._callback;
}

/**
 * show - true to show the ad, false to hide the ad
 */
ActionPanelPlugin.prototype.show = function(options, cb) {
  
	var defaults = {
        title: 'Actions',
        actions: [],
        cancelButtonText: 'Cancel'
    };

	for (var key in defaults) {
		if (typeof options[key] !== "undefined") {
			defaults[key] = options[key];
		}
	}

	//this._callback = cb;

	var callback = function(message) {
		cb(message);
	}
  
	cordova.exec(callback, 
		null, 
		"ActionPanelPlugin", 
		defaults.title,
		[defaults]
	);
};

var actionPanel = new ActionPanelPlugin();
module.exports = actionPanel;

// Make plugin work under window.plugins
if (!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.actionPanel) {
    window.plugins.actionPanel = actionPanel;
}