package chapter09;

public class CheckBox01 {
	OnSelectListener listener;
	
	void setOnSelectListener(OnSelectListener listener) {
		this.listener = listener;
	}
	void select() {
		listener.onSelect();
	}
	static interface OnSelectListener {
		void onSelect();
	}
}
