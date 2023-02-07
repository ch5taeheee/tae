package kr.or.ddit.reflection;

import java.io.Serializable;

public class SampleVO implements Serializable {
//생성자를 2개를 갖는 smaplevo
	public String id;
	protected String name;
	private int age;

	public SampleVO(String id, String name, int age) {
		super();
		this.id = id;
		this.name = name;
		this.age = age;
	}

	public SampleVO() { // 명시적으로 만든 것
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	@Deprecated
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "SmapleVO [id=" + id + ", name=" + name + ", age=" + age + "]";
	}

}
