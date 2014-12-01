package com.checkroom.plugin.actionpanel;

import java.util.List;

public class ActionPanelConfig {

	private String title = "Actions";
	private List<Action> actionsList;
	private String cancelButtonText = "Cancel";

	public ActionPanelConfig(String title, List<Action> actionsList,
			String cancelButtonText) {
		this.title = title;
		this.actionsList = actionsList;
		this.cancelButtonText = cancelButtonText;
	}

	public String getTitle() {
		return title;
	}

	public List<Action> getActions() {
		return actionsList;
	}

	public String getCancelButtonText() {
		return cancelButtonText;
	}
}
