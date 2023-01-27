package chapter13;

import java.util.Objects;

public class User {
	private int userid;
	private String firstName;
	private String lastName;
	private String phoneNumber;
	private String emailAddres;
	private String homepage;

	/**
	 * @return the userid
	 */
	public int getUserid() {
		return userid;
	}

	/**
	 * @param userid the userid to set
	 */
	public void setUserid(int userid) {
		this.userid = userid;
	}

	/**
	 * @return the firstName
	 */
	public String getFirstName() {
		return firstName;
	}

	/**
	 * @param firstName the firstName to set
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	/**
	 * @return the lastName
	 */
	public String getLastName() {
		return lastName;
	}

	/**
	 * @param lastName the lastName to set
	 */
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	/**
	 * @return the phoneNumber
	 */
	public String getPhoneNumber() {
		return phoneNumber;
	}

	/**
	 * @param phoneNumber the phoneNumber to set
	 */
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	/**
	 * @return the emailAddres
	 */
	public String getEmailAddres() {
		return emailAddres;
	}

	/**
	 * @param emailAddres the emailAddres to set
	 */
	public void setEmailAddres(String emailAddres) {
		this.emailAddres = emailAddres;
	}

	/**
	 * @return the homepage
	 */
	public String getHomepage() {
		return homepage;
	}

	/**
	 * @param homepage the homepage to set
	 */
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}

	@Override
	public String toString() {
		return "User [userid=" + userid + ", firstName=" + firstName + ", lastName=" + lastName + ", phoneNumber="
				+ phoneNumber + ", emailAddres=" + emailAddres + ", homepage=" + homepage + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(emailAddres, firstName, homepage, lastName, phoneNumber, userid);
	}

}
