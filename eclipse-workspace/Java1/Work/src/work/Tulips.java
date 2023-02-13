package work;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class Tulips {
	public static void main(String[] args) throws IOException  {

		File file = new File("d://D_Other//Tulips.jpg");

		File file2 = new File("d://D_Other//복사본_Tulips.jpg");

		FileInputStream input = new FileInputStream(file);

		FileOutputStream output = new FileOutputStream(file2);

		int fileByte = 0;

		while ((fileByte = input.read()) != -1) {
			output.write(fileByte);
		}

		input.close();
		output.close();

		if (file2.isFile()) {
			System.out.println("파일이 생성되었습니다.");
		}

	}

}
