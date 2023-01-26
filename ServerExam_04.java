package khie;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetSocketAddress;
import java.net.ServerSocket;
import java.net.Socket;



public class ServerExam_04 {

	public static void main(String[] args) {
		
		ServerSocket serverSocket = null;
		
		
		try {
			serverSocket = new ServerSocket();
			serverSocket.bind
				(new InetSocketAddress("localhost", 5002));
			
			while(true) {
				
				System.out.println("[연결을 기다림].....");
				
				// accept() : 클라이언트의 연결 수락하는 메서드
				// 클라이언트의 연결 요청이 들어오면 수락을 하고
				// 데이터를 주고 받을 통신용 소켓을 하나 만들게 됨.
				Socket socket = serverSocket.accept();
				
				InetSocketAddress isa =
						(InetSocketAddress)socket.getRemoteSocketAddress();

				// 클라이언트의 컴퓨터 이름을 가져올 수 있음.
				System.out.println
					("[연결을 수락함]....." + isa.getHostName());
			
				
				// 클라이언트 데이터를 서버에서 받기.
				byte[] bytes = null;
				String message = null;
				
				InputStream is = socket.getInputStream();
				
				bytes = new byte[100];
				
				// 클라이언트가 문자를 보내기 전까지는 서버는
				// 대기상태가 됨.
				// 클라이언트에서 데이터를 보내면 보낸 데이터는
				// bytes 배열에 저장이 되고 읽은 바이트 수는
				// readByteCount 변수에 저장이 됨.
				int readByteCount = is.read(bytes);
				
				message = 
					new String(bytes, 0, readByteCount, "UTF-8");
				
				System.out.println("[데이터 받기 성공] >>> " + message);

				// 클라이언트로 데이터를 보내 보자.
				OutputStream os = 
							socket.getOutputStream();
				
				message = "Hello Client!!!";
				
				bytes = message.getBytes("UTF-8");
				
				os.write(bytes);
				
				System.out.println("[클라이언트로 데이터 보내기 성공].....");
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		

	}

}
