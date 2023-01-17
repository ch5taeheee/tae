package study;

public class JavaArrayPractice03 {
	public static void main(String[] args) {
		int[] arr = {40,50,60,70,80,90,100};
		
		int sum =0;
		
		for(int i =0; i<arr.length;i++) {
			sum = sum + arr[i];
		}
		double average = (double)sum / arr.length;
		
		System.out.println("총합: " + sum);
		System.out.println("평균: " + average);
		
	}
}
