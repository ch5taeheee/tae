package chapter07_;

public class BankAccount {
	protected int balance;
	
	protected BankAccount(int balance) {
		this.balance = balance;
	}
	public int getBalance() {//잔액
		return balance;
	}
	public void deposit(int amount) {//입금
		balance = balance + amount;
	}
	public boolean withdraw(int amount) { //출금
		if(balance >= amount) {
			balance = balance - amount;
			return true;
		} else {
			return false;
		}
	}
	public boolean transfer(int amount, BankAccount otherAccount) {
		if(withdraw(amount)==true) {
			otherAccount.deposit(amount);
			return true;
		} else {
			return false;
		}
	}
	public String toString() {
		return String.format("%,d", balance );
	}
}
