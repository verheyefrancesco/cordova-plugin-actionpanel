package com.checkroom.plugin.actionpanel;

import android.app.Dialog;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.res.Resources;
import android.graphics.Color;
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
	private ActionPanelDialogCallback mCallback;
	private ActionPanelConfig mConfig;

	public ActionPanelDialog(Context context, ActionPanelConfig config,
			ActionPanelDialogCallback callback) {
		super(context);
		mContext = context;
		mCallback = callback;
		mConfig = config;
		setCancelable(false);
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
			addButtonWithTagAndText(action.getId(), action.getText());
		}

		addButtonWithTagAndText("cancel", mConfig.getCancelButtonText());
	}

	private void addButtonWithTagAndText(String tag, String text) {
		Button button = new Button(mContext);
		button.setText(text);
		button.setTag(tag);

		LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
				LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT);
		lp.setMargins(0, 10, 0, 10);
		button.setLayoutParams(lp);
		
		button.setOnClickListener(this);
		button.setTextColor(Color.WHITE);
		button.setPadding(0, 10, 0, 10);
		button.setBackgroundResource(getIdFromProjectsRFile(
				RESOURCE_TYPE_DRAWABLE, "btn_blue"));

		mContainerLayout.addView(button);
	}

	/*
	 * R.java util
	 */
	private static final String RESOURCE_TYPE_LAYOUT = "layout";
	private static final String RESOURCE_TYPE_ID = "id";
	private static final String RESOURCE_TYPE_DRAWABLE = "drawable";

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
		String tag = (String) v.getTag();
		if (mCallback != null) {
			mCallback.onActionSelected(tag);
		}
	}

	public interface ActionPanelDialogCallback {
		public void onActionSelected(String actionId);
	}

}
