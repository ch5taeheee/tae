package chapter11;

import java.util.Objects;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class Member {
	public String id;

	public Member(String id) {
		this.id = id;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}
//reflection 이용
//	@Override
//	public String toString() {
//		return ToStringBuilder.reflectionToString(this,ToStringStyle.JSON_STYLE);
//	}
	//format 이용
//	@Override
//	public String toString() {
//		return String.format("Member [name=%s,age=%s]", name, age);
//	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!(obj instanceof Member)) {
			return false;
		}
		Member other = (Member) obj;
		return Objects.equals(id, other.id);
	}

//	@Override
//	public boolean equals(Object obj) {
//		if (obj instanceof Member) {
//			Member member = (Member) obj;
//			if (id.equals(member.id)) {
//				return true;
//			}
//		}
//		return false;
//	}
}
