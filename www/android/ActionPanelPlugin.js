
/**
 * Constructor
 */
function ActionPanelPlugin() {
}

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

	var callback = function(result) {
		var r = result.replace(/&#34;/g, '"');
		cb(JSON.parse(r));
	};
  
	cordova.exec(callback, 
		null, 
		"ActionPanelPlugin", 
		"show",
		[defaults]);
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