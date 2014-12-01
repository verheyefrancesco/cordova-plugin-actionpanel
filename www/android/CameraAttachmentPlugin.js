
/**
 * Constructor
 */
function CameraAttachmentPlugin() {
  //this._callback;
}

/**
 * show - true to show the ad, false to hide the ad
 */
CameraAttachmentPlugin.prototype.show = function(options, cb) {
  
	var defaults = {
        uploadUrl : 'your_upload_url',
        cancelButtonText : 'Cancel',
        usePhotoButtonText : 'Use Photo',
        retakeButtonText : 'Retake',
        photoSizeWidth: -1,
        photoSizeHeight: -1
    };

	for (var key in defaults) {
		if (typeof options[key] !== "undefined") {
			defaults[key] = options[key];
		}
	}

	//this._callback = cb;

	var callback = function(message) {
		cb(message);
		/*
		var status = '' + status;
		var result = '' + data;

		if(status == 'cancelled'){
			cb('{\'status\': \'cancelled\'}');
		}

		if(isNaN(code) == true){
			var returnMessage = '{\'status\': \'' + status + '\', \'data\': \'' + data + '\'}';
			cb(returnMessage);
		} else{
			var returnMessage = '{\'status\': \'' + status + '\', \'data\': \'' + data + '\', \'code\': \'' + code + '\'}';
			cb(returnMessage);
		}
		*/
	}
  
	cordova.exec(callback, 
		null, 
		"CameraAttachmentPlugin", 
		defaults.uploadUrl,
		[defaults]
	);
};

var cameraAttachment = new CameraAttachmentPlugin();
module.exports = cameraAttachment;

// Make plugin work under window.plugins
if (!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.cameraAttachment) {
    window.plugins.cameraAttachment = cameraAttachment;
}