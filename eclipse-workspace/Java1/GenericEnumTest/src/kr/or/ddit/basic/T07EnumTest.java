package kr.or.ddit.basic;

public class T07EnumTest {

	// 상수 단점을 해결하기 위해 enum !

	/*
	 * 열거형 => 상수값들을 선언하는 방법
	 * 
	 * static final int A = 0; static final int B = 1; static final int C = 2;
	 * static final int D = 3;
	 * 
	 * enum Data {A,B,C,D};
	 * 
	 * 열거형 선언방법 enum 열거형 이름 {상수값1, 상수값2, 상수값3, ..., 상수값n};
	 * 
	 * 
	 */

	// City 열거형 정의(기본값을 이용하는 열거형)

	public enum City { // city타입의 상수들
		서울(), 부산, 대구, 광주, 대전}; // ()에 내용이 없으니 생략.
	
	public enum HomeTown{서울, 광주, 제주, 대구, 대전, 춘천};

	// 데이터값을 임의로 지정한 열거형 객체 선언
	// 데이터값을 정해줄 경우에는 생성자를 만들어서 괄호속의 값이 변수에 저장되도록 해야 한다.

	public enum Season { // season 타입의 열거형 상수를 정의
		봄("3월부터 5월까지"), 여름("6월부터 8월까지"), 가을("9월부터 11월까지"), 겨울("12월부터 2월까지"); // 이거를 만들 때 생성자가 필요함!

		// 괄호 속의 값이 저장될 변수 선언
		private String str;

		// 생성자 만들기(열거형의 생성자는 제어자가 묵시적으로 'private'이다.)
		private Season(String data) { // 생성자가 private다. -> 외부가 객체생성하는 것을 막는다. 내부적으로는 season 객체 4개가 만들어짐(값이다른)
			this.str = data;

		}

		// 값을 반환하는 메서드 작성
		public String getStr() {
			return str;
		}
	}

		public static void main(String[] args) {

		/*
		  *	열거형에서 사용되는 메서드
		  *	
		  * 1. name() => 열거형 상수의 이름을 문자열로 반환한다.
		  * 2. ordinal() => 열거형 상수가 정의된 순서값을 반환한다. (기본적으로 0부터 시작함)
		  * 3. valueOf("열거형상수이름"); => 지정된 열거형에서 '열거형상수이름'과 일치하는 열거형 상수를 반환한다. 
		  *  
		*/
			
			City myCity1; // 열거형 객체변수 선언
			City myCity2;
			
			// 열거형 객체변수에 값 저장하기
			
			myCity1 = City.서울; // 열거형 상수객체 서울
			myCity2 = City.valueOf("서울"); // '서울'은 객체인데 문자열로 바꾼다. 
			
			System.out.println("myCity1 : " + myCity1.name()); // 스트링 이름
			System.out.println("myCity1의 ordinal  : " + myCity1.ordinal()); //순서
			System.out.println();
			
			System.out.println("myCity2 : " + myCity2.name());
			System.out.println("myCity2의 ordinal  : " + myCity2.ordinal());
			System.out.println("=========================================================");
			
			Season ss = Season.valueOf("여름");
			System.out.println("name => " + ss.name());
			System.out.println("ordinal => " + ss.ordinal());
			System.out.println("get 메서드 => " + ss.getStr());
			
			
			//열거형이름.values() 사용하기.
			Season[] enumArr = Season.values();
			for(int i = 0; i < enumArr.length; i++) {
				System.out.println(enumArr[i].name() + enumArr[i].getStr());
			}
			
			for(City city : City.values()) {
				System.out.println(city + " : " + city.ordinal());
			}
			
			City city = City.대구;
		
			System.out.println(city == City.valueOf("대전"));
			System.out.println(city == City.대구);
			
			System.out.println("대구 => " + city.compareTo(city.대구));
			System.out.println("서울 => " + city.compareTo(city.서울));
			System.out.println("대전 => " + city.compareTo(city.대전));
		}

	
}
