package chapter09;

public class CheckBox01Example {
	public static void main(String[] args) {
		CheckBox01 checkBox = new CheckBox01();
		checkBox.setOnSelectListener(
				public void OnSelect() {
					System.out.println("배경을 변경합니다.")
				});
	}
}
