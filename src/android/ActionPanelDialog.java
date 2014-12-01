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

public class ActionPanelDialog extends Dialog implements PreviewCallback,
		android.view.View.OnClickListener {

	private Context mContext;

	public ActionPanelDialog(Context context) {
		super(context);
		mContext = context;
		setCancelable(false);
	}

	public void setConfig() {

	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(getIdFromProjectsRFile(RESOURCE_TYPE_LAYOUT,
				"action_panel_dialog"));
		setWidgets();
	}

	private void setWidgets() {

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
