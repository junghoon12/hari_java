package exam;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client_Test {

	public static void main(String[] args) {
		
		String serverIp = "127.0.0.1";
		int serverPort = 8888;
		Socket socket = null;
		
		byte[] bytes = null;
		String message = null;
		
		try {
			socket = new Socket(serverIp, serverPort);
			
			InputStream in = socket.getInputStream();
			
			OutputStream out = socket.getOutputStream();
			
			bytes = new byte[100];
			
			// 서버에서 넘어온 첫번째 데이터 받기
			int readByteCount = in.read(bytes);
			
			message = new String(bytes, 0, readByteCount, "UTF-8");
			
			System.out.println(message);
			
			// 서버에서 넘어온 두번째 데이터 받기
			readByteCount = in.read(bytes);
			
			message = new String(bytes, 0, readByteCount, "UTF-8");
			
			System.out.println(message);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				socket.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
