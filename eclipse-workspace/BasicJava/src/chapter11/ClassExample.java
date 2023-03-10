package chapter11;

import java.lang.reflect.Constructor;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class ClassExample {
	public static void main(String[] args) {
		//Reflection
		//1.
		Class clazz = ToStringBuilder.class;
		Constructor[] constructors = clazz.getDeclaredConstructors();
		for(Constructor constructor : constructors) {
			constructor.newInstance(args) 
			
			System.out.println(constructor.toString());
		}
		
		
		//2.
//		Class.forName("org.apache.commons.lang3.builder.ToStringBuilder");
//		
//		
		ToStringBuilder builder = new ToStringBuilder(constructors);
		builder.getClass();
		
		//3.
//		Member member = new Member("");
//		member.getClass();
	}
}
