package chapter07_;

public class CheckingAccount extends BankAccount {
	private SavingsAccount protectedBy;

	public CheckingAccount(int balance) {
		super(balance);
	}

	public CheckingAccount(int balance, SavingsAccount protectedBy) {
		super(balance);
		this.protectedBy = protectedBy;
	}

	@Override
	public boolean withdraw(int amount) { // 출금
		if (balance < amount) {
			protectedBy.withdraw(balance - amount);
			withdraw(balance);
			return true;

		}
		return false;

	}
}
