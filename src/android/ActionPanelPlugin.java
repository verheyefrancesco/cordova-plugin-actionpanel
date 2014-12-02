package com.checkroom.plugin.actionpanel;

import java.util.ArrayList;
import java.util.List;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.AlertDialog;
import android.content.DialogInterface;
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

		showAlert();
	}

	private void readParametersFromData(JSONArray data) {
		mActionsList = new ArrayList<Action>();
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

	public void showAlert() {
		AlertDialog.Builder ad = new AlertDialog.Builder(cordova.getActivity());
		ad.setTitle(mTitle);

		List<String> actionTextList = new ArrayList<String>();
		for (Action action : mActionsList) {
			actionTextList.add(action.getText());
		}
		CharSequence[] cs = actionTextList
				.toArray(new CharSequence[actionTextList.size()]);

		ad.setItems(cs, new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int item) {
				jsActionSelected(item);
			}
		});
		ad.setNegativeButton(mCancelButtonText,
				new DialogInterface.OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						jsCancelled();
					}
				});
		ad.show();
	}

	/* JS */
	private void jsActionSelected(int index) {
		Action selectedAction = mActionsList.get(index);
		if (selectedAction != null) {
			String result = "{'status': 'success', 'data': {'id': + '"
					+ selectedAction.getId() + "', 'text': '"
					+ selectedAction.getText() + "'}}";
			callbackContext.success(result);
		}
	}

	private void jsCancelled() {
		String result = "{'status': 'cancelled'}";
		callbackContext.success(result);
	}
}
