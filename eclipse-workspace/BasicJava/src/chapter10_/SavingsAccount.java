package chapter10_;

public class SavingsAccount extends BankAccount {
	private double interstRate;

	public SavingsAccount(int balance, double interstRate) {
		super(balance);
		this.interstRate = interstRate; // 이자율
	}

	public void updateBalance(int period) {
		balance = (int)(balance * interstRate * period + balance);
	}

	
	public String getAccountType() {
		return "저축예금";
	}
}
