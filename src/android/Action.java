package com.checkroom.plugin.actionpanel;

public class Action {
	private String id;
	private String text;

	public Action(String id, String text) {
		this.id = id;
		this.text = text;
	}

	public String getId() {
		return id;
	}

	public String getText() {
		return text;
	}
}
