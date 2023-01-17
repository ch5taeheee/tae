package chapter07;

public class Child01Example {
	public static void main(String[] args) {
	Child01 child = new Child01();
	
	Parent01 parent = child;
	parent.method1();
	parent.method2();
	//parent.method3();
	}
}
