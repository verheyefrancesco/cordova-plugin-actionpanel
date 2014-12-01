/**
  Phonegap CameraAttachment Plugin
  https://github.com/francescobitmunks/cordova-plugin-cameraattachment

  MIT Licensed
*/

var exec = require('cordova/exec');
/**
 * Constructor
 */
function CameraAttachmentPlugin() {
    this._callback;
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
        if (typeof options[key] !== "undefined")
            defaults[key] = options[key];
    }
    this._callback = cb;

    exec(null, 
      null, 
      "CameraAttachmentPlugin", 
      "show",
      [defaults]
    );
};

CameraAttachmentPlugin.prototype._photoUploaded = function(result) {
    result = result.replace(/&#34;/g, "\'");


    if (this._callback)
        this._callback('{\'status\': \'success\', \'data\': \'' + result + '\'}');
}

CameraAttachmentPlugin.prototype._photoUploadCanceled = function() {
    if (this._callback)
        this._callback('{\'status\': \'cancelled\'}');
}



var cameraAttachmentPlugin = new CameraAttachmentPlugin();
module.exports = cameraAttachmentPlugin;

// Make plugin work under window.plugins
if (!window.plugins) {
    window.plugins = {};
}
if (!window.plugins.cameraAttachmentPlugin) {
    window.plugins.cameraAttachmentPlugin = cameraAttachmentPlugin;
}