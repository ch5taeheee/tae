package chapter13;

public class Lalala {
	private String mainlmg;
	private String thumbs;
	private String descriptionH2;
	private String descriptionP;
	private String link;
	
	public Lalala(String mainlmg, String thumbs, String descriptionH2, String descriptionP, String link) {
		super();
		this.mainlmg = mainlmg;
		this.thumbs = thumbs;
		this.descriptionH2 = descriptionH2;
		this.descriptionP = descriptionP;
		this.link = link;
	}

	public String getMainlmg() {
		return mainlmg;
	}

	public void setMainlmg(String mainlmg) {
		this.mainlmg = mainlmg;
	}

	public String getThumbs() {
		return thumbs;
	}

	public void setThumbs(String thumbs) {
		this.thumbs = thumbs;
	}

	public String getDescriptionH2() {
		return descriptionH2;
	}

	public void setDescriptionH2(String descriptionH2) {
		this.descriptionH2 = descriptionH2;
	}

	public String getDescriptionP() {
		return descriptionP;
	}

	public void setDescriptionP(String descriptionP) {
		this.descriptionP = descriptionP;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	@Override
	public String toString() {
		return "Lalala [mainlmg=" + mainlmg + ", thumbs=" + thumbs + ", descriptionH2=" + descriptionH2
				+ ", descriptionP=" + descriptionP + ", link=" + link + "]";
	}
	
	
	
	
	
	
	
}
