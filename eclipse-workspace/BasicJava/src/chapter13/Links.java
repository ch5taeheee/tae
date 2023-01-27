package chapter13;

public class Links {
	private String linkinto;
	private String linkname;
	private String linkclass;
	public Links(String linkinto, String linkname, String linkclass) {
		super();
		this.linkinto = linkinto;
		this.linkname = linkname;
		this.linkclass = linkclass;
	}
	public String getLinkinto() {
		return linkinto;
	}
	public void setLinkinto(String linkinto) {
		this.linkinto = linkinto;
	}
	public String getLinkname() {
		return linkname;
	}
	public void setLinkname(String linkname) {
		this.linkname = linkname;
	}
	public String getLinkclass() {
		return linkclass;
	}
	public void setLinkclass(String linkclass) {
		this.linkclass = linkclass;
	}
	@Override
	public String toString() {
		return "Links [linkinto=" + linkinto + ", linkname=" + linkname + ", linkclass=" + linkclass + "]";
	}
	
	
}
