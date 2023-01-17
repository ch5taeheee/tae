package chapter10;

public class RuntimeExceptionExample {
	public static void main(String[] args) {
		try {
			String data1 = args[0];
			String data2 = args[1];
			int value1 = Integer.parseInt(data1);
			int value2 = Integer.parseInt(data2);
			int result = value1 + value2;
			System.out.println(value1 + " + " + value2 + " = " + result);
		} catch (ArrayIndexOutOfBoundsException e) { //catch (NumberFormatException |ArrayIndexOutOfBoundsException e) syso가 같을 경우 이렇게 쓸 수도 있음. 
			System.out.println("실행 매개값의 수가 부족합니다.");
		} catch (NumberFormatException e) { 
			System.out.println("숫자로 변환할 수 없습니다.");
		} catch (Exception e) { // 먼저 나오게 되면 다른  catch 들이 의미가 없기 때문에 무소용, 낮은 순위가 먼저 위에 있어야 함.
			System.out.println("알 수 없는 에러가 발생하였습니다.");
		} finally {
			System.out.println("다시 실행하세요.");
		}

	} 
}
