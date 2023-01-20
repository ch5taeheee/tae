package chapter11;

import java.util.Objects;

public class Key {
	public int number;

	public Key(int number) {
		this.number = number;
	}

	@Override
	public int hashCode() {
		return Objects.hash(number);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (!(obj instanceof Key)) {
			return false;
		}
		Key other = (Key) obj;
		return number == other.number;
	}

}
