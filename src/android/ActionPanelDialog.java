package com.checkroom.plugin.actionpanel;

import android.app.Dialog;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Resources;
import android.hardware.Camera;
import android.hardware.Camera.PreviewCallback;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;

public class ActionPanelDialog extends Dialog implements PreviewCallback,
		android.view.View.OnClickListener {

	private LinearLayout mContainerLayout;

	private Context mContext;

	private ActionPanelConfig mConfig;

	public ActionPanelDialog(Context context) {
		super(context);
		mContext = context;
		setCancelable(false);
	}

	public void setConfig(ActionPanelConfig config) {
		mConfig = config;
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(getIdFromProjectsRFile(RESOURCE_TYPE_LAYOUT,
				"action_panel_dialog"));
		setTitle(mConfig.getTitle());
		setWidgets();
	}

	private void setWidgets() {
		mContainerLayout = (LinearLayout) findViewById(getIdFromProjectsRFile(
				RESOURCE_TYPE_ID, "llActionPanelDialogContainer"));

		for (Action action : mConfig.getActions()) {
			addButtonWithTextAndTag(action.getId(), action.getText());
		}

		addButtonWithTextAndTag("cancel", mConfig.getCancelButtonText());
	}

	private void addButtonWithTextAndTag(String id, String text) {
		Button button = new Button(mContext);
		button.setText(text);
		button.setTag(id);

		LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
				LinearLayout.LayoutParams.WRAP_CONTENT,
				LinearLayout.LayoutParams.WRAP_CONTENT);
		lp.setMargins(0, 10, 0, 10);
		lp.width = LayoutParams.MATCH_PARENT;
		button.setLayoutParams(lp);

		mContainerLayout.addView(button);
	}

	/*
	 * R.java util
	 */
	private static final String RESOURCE_TYPE_LAYOUT = "layout";
	private static final String RESOURCE_TYPE_ID = "id";
	private String packageName;

	private int getIdFromProjectsRFile(String resourceType, String resourceId) {
		if (packageName == null) {
			try {
				PackageManager pm = mContext.getPackageManager();
				PackageInfo packageInfo = pm.getPackageInfo(
						mContext.getPackageName(), 0);
				packageName = packageInfo.packageName;
			} catch (NameNotFoundException e) {
			}
		}
		Resources resources = mContext.getApplicationContext().getResources();
		return resources.getIdentifier(resourceId, resourceType, packageName);
	}

	@Override
	public void onPreviewFrame(byte[] data, Camera camera) {
	}

	@Override
	public void onClick(View v) {
		if (v.getId() == getIdFromProjectsRFile(RESOURCE_TYPE_ID,
				"btnActionPanelPluginCancel")) {
		}
	}
}
