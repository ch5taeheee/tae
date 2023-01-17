package chapter08_;

public class Novel extends Book {
	public Novel(String title, String author) {
		super(title,author);
	}
	public int getLateFee(int lateDays) {
		return lateDays* 300;
	}
}
