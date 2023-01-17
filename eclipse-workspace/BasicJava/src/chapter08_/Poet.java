package chapter08_;

public class Poet extends Book{
	public Poet(String title, String author) {
		super(title, author);
	}
	public int getLateFee(int lateDays) {
		return  lateDays * 200;
	}
}
