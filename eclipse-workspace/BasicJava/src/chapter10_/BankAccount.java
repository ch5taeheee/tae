package chapter10_;

public class BankAccount {
	protected int balance;

	public BankAccount(int balance) {
		this.balance = balance;
	}

	public int getBalance() {// 잔액
		return balance;
	}

	public void deposit(int amount) {// 입금
		balance = balance + amount;
	}

	public boolean withdraw(int amount) { // 출금
		if (balance >= amount) {
			balance = balance - amount;
			return true;
		} else {
			return false;
		}
	}

	public boolean transfer(int amount, BankAccount otherAccount)  {

		if (amount < 0 || amount > balance) {
			throw new IllegalArgumentException();
		}
		else if (otherAccount == null) {
			throw new NullPointerException();
		}
		
		 if (withdraw(amount) == true) {
			otherAccount.deposit(amount);
			return true;

		} else {
			return false;
		}

	}
}
