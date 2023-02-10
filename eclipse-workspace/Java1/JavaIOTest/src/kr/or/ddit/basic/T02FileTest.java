package kr.or.ddit.basic;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class T02FileTest {
	public static void main(String[] args) throws IOException {
		
		File f1 = new File("d:/D_Other/sample.txt");
		File f2 = new File("d:/D_Other/test.txt");
		
		if(f1.exists()) {
			System.out.println(f1.getAbsolutePath() + "은 존재합니다.");
		} else {
			System.out.println(f1.getAbsolutePath() + "은 없는 파일입니다.");
		
			if(f1.createNewFile()) {
				System.out.println(f1.getAbsolutePath() + "파일을 새로 만들었습니다.");
			}
		}
		if(f2.exists()) {
			System.out.println(f2.getAbsolutePath() + "은 존재합니다.");
		} else {
			System.out.println(f2.getAbsolutePath() + "은 없는 파일입니다.");
		}
		System.out.println("-------------------------------------------------------");
		
		
		File f3 = new File("d:/D_Other");
		File[] files = f3.listFiles();
		
		for(File f : files) {
			System.out.print(f.getName() + " => ");
			
			if(f.isFile()) {
				System.out.println("파일");
				
			} else if(f.isDirectory()) {
				System.out.println("디렉토리(폴더)");
			}
			
		}
		System.out.println("============================================================");
		
		String[] strFiles = f3.list();
		for(String fileName : strFiles) {
			System.out.println(fileName);
			
		}
		System.out.println("------------------------------------------------------------");
		System.out.println();
		
		displayFileList(new File("d:/D_Other"));
	}
	/**
	 * 지정된 디렉토리(폴더)에 포함된 파일과 디렉토리 목록을 보여주기 위한 메서드
	 * dir 목록 보고싶은 폴더객체 
	 */
	public static void displayFileList(File dir) {
		System.out.println("[" + dir.getAbsolutePath() + "] 디렉토리 내용");
		
		// 디렉토리 안의 모든 파일 목록을 가져온다. 
		File[] files = dir.listFiles();
		
		//하위 디렉토리 정보를 저장할 List 객체 생성(File 배열의 인덱스 저장용)
		List<Integer> subDirList = new ArrayList<>();
		
		//날짜정보를 출력하기 위한 포맷 설정하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a hh:mm");
		
		for(int i = 0; i<files.length;i++) {
			String attr = ""; // 파일의 속성정보(읽기, 쓰기, 히든파일, 디렉토리 구분정보)
			String size = ""; // 파일용량
			
			if(files[i].isDirectory()) {
				attr = "<DIR>";
				subDirList.add(i); // 디렉토리인 경우 인덱스 정보 저장
			} else {
				size = files[i].length() + "";
				attr = files[i].canRead() ? "R" : " "; //읽을 수 있는 권한이 있나?
				attr += files[i].canWrite() ? "W" : " ";
				attr += files[i].isHidden() ? "H" : " ";
			}
			
			System.out.printf("%s %5s %12s %s/n", sdf.format(new Date(files[i].lastModified())),attr,size,files[i].getName());
			System.out.println();
			//"%s %-5s %12s %s/n" // 좌측정렬 default 는 우측정렬
			
			
	} //for
		int dirCount = subDirList.size();
		int fileCount = files.length - dirCount;
		
		System.out.println(fileCount + "개의 파일, " + dirCount + "개의 디렉토리");
		System.out.println();
		
		for(int i = 0; i<subDirList.size(); i++) {
			// 하위폴더의 내용들도 출력하기 위해 현재 메서드를 재귀호출하여 처리한다. 
			displayFileList(files[subDirList.get(i)]);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	

}
