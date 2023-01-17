package chapter06;

public class ShopService {
	private static ShopService instance = new ShopService(); //필드는 private

	private ShopService() {
	}
	public static ShopService getInstance() { //필드를 private 해놓고 메소드로 접근. 만약 필드가 public 하면 이건 필요x
		return instance;
	}
}
