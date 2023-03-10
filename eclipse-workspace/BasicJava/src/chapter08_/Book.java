package chapter08_;

import java.util.Objects;

public abstract class Book {
	private int number; // 관리번호
	private String title; // 책의 제목
	private String author; // 책의 저자
	private static int countOfBooks=1;

	public Book(String title, String author) {
		this.title = title;
		this.author = author;
		
		
		number = countOfBooks;
		countOfBooks++;

	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public abstract int getLateFee(int lateDays);

	@Override
	public int hashCode() {
		return Objects.hash(author, title);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		return Objects.equals(author, other.author) && Objects.equals(title, other.title);
	}
	// public abstract int getLateFee(int lateDays);
	// public boolean equals(Object obj) {
	// if (!(obj instanceof book)) {
	// return false;
	// }
	// Book book = (book)obj;
	// return this.title.equals(book.title) && this.author.equals(book.author);

	public String toString() {
		return String.format("관리번호 : %d번, 제목 : %s, 작가: %s(일주일 연체료 : %d원)", number, title, author, getLateFee(7));
	}

}
