package khie;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;


public class EMP extends JFrame {

	// 오라클 데이터베이스와 연결하는 객체.
	Connection con = null;
	
	// SQL문을 데이터베이스에 전송하는 객체.
	PreparedStatement pstmt = null;
	
	// SQL문을 실행한 후에 결과값을 가지고 있는 객체.
	ResultSet rs = null;
	
	// SQL문을 저장할 문자열 변수
	String sql = null;
	
	DefaultTableModel model;
	JTable table;
	JTextField jtf1, jtf2, jtf3, jtf4;
	JComboBox<String> jcb1, jcb2, jcb3;
	
	public EMP() {
	
		setTitle("사원 관리 화면");
		
		// 컨테이너를 세 개를 만들자.
		JPanel container1 = new JPanel();  // 상단-1 컨테이너
		JPanel container2 = new JPanel();  // 상단-2 컨테이너
		JPanel container3 = new JPanel();  // 하단 컨테이너
		
		// 1. 컴포넌트들을 만들어 보자.
		// 1-1. 상단-1 컨테이너에 올려질 컴포넌트들을 만들자.
		JLabel jl1 = new JLabel("사 번 : ");
		jtf1 = new JTextField(4);
		
		JLabel jl2 = new JLabel("이 름 : ");
		jtf2 = new JTextField(10);
		
		JLabel jl3 = new JLabel("담당업무 : ");
		jcb1 = new JComboBox<String>();
		
		// 1-2. 상단-2 컨테이너에 올려질 컴포넌트들을 만들자.
		JLabel jl4 = new JLabel("관리자No. : ");
		jcb2 = new JComboBox<String>();
		
		JLabel jl5 = new JLabel("급 여 : ");
		jtf3 = new JTextField(5);
		
		JLabel jl6 = new JLabel("보너스 : ");
		jtf4 = new JTextField(5);
		
		JLabel jl7 = new JLabel("부서No. : ");
		jcb3 = new JComboBox<String>();
		
		// 1-3. 중앙에 위치할 컴포넌트들을 만들어 보자.
		String[] header = 
			{"사 번", "이 름", "담당업무", "관리자No.",
			 "급 여", "보너스", "부서번호", "입사일"};
		
		model = new DefaultTableModel(header, 0);
		
		table = new JTable(model);
		
		JScrollPane jsp = new JScrollPane(
				table, 
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED, 
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);

		// 1-4. 하단 컨테이너에 올려질 컴포넌트들을 만들자.
		JButton btn1 = new JButton("사원 목록");
		JButton btn2 = new JButton("사원 등록");
		JButton btn3 = new JButton("사원 수정");
		JButton btn4 = new JButton("사원 삭제");
		
		
		// 2. 컴포넌트들을 컨테이너에 올려 주어야 한다.
		// 2-1. 상단-1 컨테이너에 1-1 컴포넌트들을 올리자.
		container1.add(jl1); container1.add(jtf1);
		container1.add(jl2); container1.add(jtf2);
		container1.add(jl3); container1.add(jcb1);
		
		// 2-2. 상단-2 컨테이너에 1-2 컴포넌트들을 올리자.
		container2.add(jl4); container2.add(jcb2);
		container2.add(jl5); container2.add(jtf3);
		container2.add(jl6); container2.add(jtf4);
		container2.add(jl7); container2.add(jcb3);
		
		// 2-3. 하단 컨테이너에 1-4 컴포넌트들을 올리자.
		container3.add(btn1); container3.add(btn2);
		container3.add(btn3); container3.add(btn4);
		
		// 새로운 컨테이너를 하나 만들어서 기존의 컨테이너를 올리자.
		JPanel group = new JPanel(new BorderLayout());
		
		group.add(container2, BorderLayout.NORTH);
		group.add(jsp, BorderLayout.CENTER);
		group.add(container3, BorderLayout.SOUTH);
		
		// 컨테이너를 프레임에 올려 주어야 한다.
		add(container1, BorderLayout.NORTH);
		add(group, BorderLayout.CENTER);
		
		setBounds(100, 100, 650, 350);
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		setVisible(true);
		
		// 5. 이벤트 처리
		// 사원목록(btn1) 버튼을 클릭 시 EMP 테이블에 있는
		// 전체 사원의 목록을 JTable에 띄워주면 됨.
		
		btn1.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				// 오라클 드라이버 로딩 및 오라클 데이터베이스 연결 진행.
				connect();
				
				model.setRowCount(0);  // 지워주라는 의미.
				
				select();  // EMP 테이블 목록 조회하는 메서드.
				
			}
		});
		
		
		
	}  // 기본 생성자
	
	// 데이터베이스 연동 메서드
	void connect() {
		String driver = 
				"oracle.jdbc.driver.OracleDriver";
		
		String url =
				"jdbc:oracle:thin:@localhost:1521:xe";
		
		String user = "web";
		
		String password = "1234";
		
		try {
			// 오라클 드라이버 로딩
			Class.forName(driver);
			
			// 오라클 데이터베이스와 연동 진행.
			con = DriverManager.getConnection
							(url, user, password);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}  // connect() 메서드 end
	
	
	// EMP 테이블의 전체 사원 목록을 조회하는 메서드.
	void select() {
		
		try {
			// 1. 데이터베이스로 전송할 SQL문 작성.
			sql = "select * from emp "
					+ " order by hiredate desc";
			
			pstmt = con.prepareStatement(sql);
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int empno = rs.getInt("empno");
				String ename = rs.getString("ename");
				String job = rs.getString("job");
				int mgr = rs.getInt("mgr");
				int sal = rs.getInt("sal");
				int comm = rs.getInt("comm");
				int deptno = rs.getInt("deptno");
				String hiredate = 
					rs.getString("hiredate").substring(0, 10);
				
				Object[] record = 
					{empno, ename, job, mgr, sal, comm, deptno, hiredate};
				
				model.addRow(record);
			}
			
			// 3. 데이터베이스에 연결된 자원 종료하기
			rs.close(); pstmt.close(); con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}  // select() 메서드 end
	
	public static void main(String[] args) {
		
		new EMP();
	}
}
