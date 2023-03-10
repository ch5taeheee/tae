package work;

import work.BankAccount;

public abstract class BankAccount01 {
	protected int balance;

	public abstract String getAccountType();

	protected BankAccount01(int balance) {
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

	public String toString() {
		return String.format("%,d", balance);
	}

	public boolean transfer(int amount, BankAccount otherAccount) throws Exception {
		if (otherAccount == null) {
			throw new NullPointerException();
		}
		else if (withdraw(amount) == true) {
			otherAccount.deposit(amount);
			return true;
		} else if (amount < 0 || amount > balance) {
			throw new IllegalArgumentException();

		}
		return false;
	


	}
}


