package kr.or.ddit.basic;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

public class AnnotationTest {
	public static void main(String[] args) {
		
		// Reflection API를 이용한 메서드 정보 가져오기
		// 선언된 메서드 목록 가져오기
		Method[] declaredMethods = Service.class.getDeclaredMethods();
		
		for(Method m : declaredMethods) {
			
			Annotation[] annos = m.getDeclaredAnnotations();
			System.out.println("메서드 명: " + m.getName());
			for(Annotation anno : annos) {
				if(anno.annotationType().getSimpleName().equals("PrintAnnotation")) {
					PrintAnnotation printAnno = (PrintAnnotation) anno;
					
					System.out.println("value값: " + printAnno.value());
					System.out.println("count값 : " + printAnno.count());
					
					for(int i =0; i<printAnno.count();i++) {
						System.out.print(printAnno.value());
					}
					System.out.println();
				}
			}
			System.out.println("====================================================");
		}
	}

}
