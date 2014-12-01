package com.checkroom.plugin.actionpanel;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

public class ActionPanelPlugin extends CordovaPlugin {
	private final String pluginName = "ActionPanel";

	private CallbackContext callbackContext;
	private ActionPanelDialog mActionPanelDialog;

	@Override
	public boolean execute(final String action, final JSONArray data,
			final CallbackContext callbackContext) {
		Log.d(pluginName, pluginName + " called with options: " + data);
		boolean result = false;

		this.show(data, callbackContext);

		this.callbackContext = callbackContext;

		result = true;

		return result;
	}

	public synchronized void show(final JSONArray data,
			final CallbackContext callbackContext) {
		readParametersFromData(data);

		createConfig();

		showCameraAttachmentDialog();
	}

	private void readParametersFromData(JSONArray data) {
		try {
			JSONObject obj = data.getJSONObject(0);

		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	private void createConfig() {

	}

	private void showCameraAttachmentDialog() {
		this.cordova.getActivity().runOnUiThread(new Runnable() {
			public void run() {
				mActionPanelDialog = new ActionPanelDialog(cordova
						.getActivity());
				mActionPanelDialog.show();
			}
		});
	}
	/*
	 * String message = "{'status': 'cancelled'}";
	 * callbackContext.success(message);
	 */
}
