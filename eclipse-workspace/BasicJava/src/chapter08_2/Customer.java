package chapter08_2;


public class Customer {
	private String firstName;
	private String lastName;
	private BankAccount[] accounts;
	int numberOfAccounts; // 고객이 소유한 계좌 수

	public Customer(String firstName, String lastName) {
		this.firstName = firstName;
		this.lastName = lastName;
		accounts = new BankAccount[5];
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public BankAccount getAccount(int index) {
		return accounts[index];
	}

	public void addAccount(BankAccount account) {
		accounts[numberOfAccounts] = account;
		numberOfAccounts++;
	}

	public int getNumberOfAccounts() {
		return numberOfAccounts;
	}

	public String toString() {
		return String.format("고객의 이름: %s %s ", firstName, lastName, numberOfAccounts);
	}

}
