package report;

public class Horse implements Comparable<Horse> {
	String name;
	int rank;

	public Horse(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	@Override
	public String toString() {
		return name + " : " + rank + "등";
	}

	@Override
	public int compareTo(Horse o) {
		if(this.rank > o.rank) {
			return 1;
		} else if(this.rank == o.rank) {
			return 0;
		} else {
			return -1;
		}
	}
	
	
}
