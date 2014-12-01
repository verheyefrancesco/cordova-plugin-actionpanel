package com.checkroom.plugin.actionpanel;

import java.util.ArrayList;
import java.util.List;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

public class ActionPanelPlugin extends CordovaPlugin {
	private final String pluginName = "ActionPanel";

	private static final String ARG_TITLE = "title";
	private static final String ARG_ACTIONS = "actions";
	private static final String ARG_ACTION_ID = "id";
	private static final String ARG_ACTION_TEXT = "text";
	private static final String ARG_CANCEL_BUTTON_TEXT = "cancelButtonText";

	private String mTitle;
	private List<Action> mActionsList = new ArrayList<Action>();
	private String mCancelButtonText;

	private CallbackContext callbackContext;
	private ActionPanelConfig mConfig;
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
			if (obj.has(ARG_TITLE)) {
				mTitle = obj.getString(ARG_TITLE);
			}
			if (obj.has(ARG_ACTIONS)) {
				JSONArray jActions = obj.getJSONArray(ARG_ACTIONS);
				for (int i = 0; i < jActions.length(); i++) {
					JSONObject jAction = jActions.getJSONObject(i);
					String actionId = null;
					String actionText = null;
					if (jAction.has(ARG_ACTION_ID)) {
						actionId = jAction.getString(ARG_ACTION_ID);
					}
					if (jAction.has(ARG_ACTION_TEXT)) {
						actionText = jAction.getString(ARG_ACTION_TEXT);
					}
					if (actionId != null && actionText != null) {
						mActionsList.add(new Action(actionId, actionText));
					}
				}
			}
			if (obj.has(ARG_CANCEL_BUTTON_TEXT)) {
				mCancelButtonText = obj.getString(ARG_CANCEL_BUTTON_TEXT);
			}
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}

	private void createConfig() {
		mConfig = new ActionPanelConfig(mTitle, mActionsList, mCancelButtonText);
	}

	private void showCameraAttachmentDialog() {
		this.cordova.getActivity().runOnUiThread(new Runnable() {
			public void run() {
				mActionPanelDialog = new ActionPanelDialog(cordova
						.getActivity());
				mActionPanelDialog.setConfig(mConfig);
				mActionPanelDialog.show();
			}
		});
	}
	/*
	 * String message = "{'status': 'cancelled'}";
	 * callbackContext.success(message);
	 */
}
