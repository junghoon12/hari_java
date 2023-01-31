package exam;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Calendar;

public class Server_Test {

	public static void main(String[] args) {
		
		int port = 8888;
		ServerSocket serverSocket = null;
		
		byte[] bytes = null;
		
		try {
			serverSocket = new ServerSocket(port);
			
			Socket clientSocket = serverSocket.accept();
			
			// InputStream is = new InputStream();
			// OutputStream os = new OutputStream();
			
			InputStream in = clientSocket.getInputStream();
			OutputStream out = clientSocket.getOutputStream();
			
			bytes = new byte[100];
			
			// [서버 연결 성공] 메세지를 클라이언트에 보내는 작업.
			String msg = "[서버 연결 성공]";
			
			bytes = msg.getBytes("UTF-8");
			
			out.write(bytes);
			
			Calendar cal = Calendar.getInstance();
			
			int hour = cal.get(Calendar.HOUR_OF_DAY);
			int minute = cal.get(Calendar.MINUTE);
			int second = cal.get(Calendar.SECOND);
			
			// 현재시간 정보를 클라이언트에 보내는 작업.
			String now = "[현재 시간] : "+hour+ ":"+minute+":"+second;
			
			bytes = now.getBytes("UTF-8");
			
			out.write(bytes);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				serverSocket.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
