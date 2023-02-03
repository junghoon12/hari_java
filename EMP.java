package khie;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.sql.*;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;

import model.EmpDTO;

public class EMP extends JFrame {

	Connection con = null;           // DB와 연동하는 객체.
	PreparedStatement pstmt = null;  // SQL문을 DB에 전송하는 객체.
	ResultSet rs = null;             // SQL문 실행 결과를 가지고 있는 객체.
	String sql = null;               // SQL문을 저장하는 문자열 변수.

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
		
		JLabel jl7 = new JLabel("부서번호. : ");
		jcb3 = new JComboBox<String>();
		
		jcb1.addItem("선택"); 
		jcb2.addItem("선택"); jcb3.addItem("선택");
		
		// 1-3. 중앙에 위치할 컴포넌트들을 만들어 보자.
		String[] header = 
			{"사 번", "이 름", "담당업무", "관리자No.", "급 여", "보너스", "부서번호", "입사일"};
		
		model = new DefaultTableModel(header, 0);
		
		table = new JTable(model);
		
		JScrollPane jsp = new JScrollPane(
				table, 
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED, 
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
		
		// 1-4. 하단 컨테이너에 들어갈 컴포넌트들을 만들자.
		JButton btn1 = new JButton("사원 목록");
		JButton btn2 = new JButton("사원 등록");
		JButton btn3 = new JButton("사원 수정");
		JButton btn4 = new JButton("사원 삭제");
		
		
		// 2. 컴포넌트들을 컨테이너에 올려 주어야 한다.
		// 2-1. 상단-1 컨테이너에 1-1 컴포턴트들을 올리자.
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
		
		
		// 새로운 컨테이너를 하나 만들어서 기존의 컨테이너들을 올려 주자.
		JPanel group = new JPanel(new BorderLayout());
		
		group.add(container2, BorderLayout.NORTH);
		group.add(jsp, BorderLayout.CENTER);
		group.add(container3, BorderLayout.SOUTH);
		
		
		// 3. 컨테이너를 프레임에 올려야 한다.
		add(container1, BorderLayout.NORTH);
		add(group, BorderLayout.CENTER);
		
		setBounds(100, 100, 650, 350);
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		setVisible(true);
		
		// 부서번호를 메인 화면에 띄어보도록 하자.
		connect();
		
		comboJob();
		
		comboMgr();
		
		// DEPT 테이블의 전체 리스트를 조회하는 메서드 호출.
		comboDept(); 
		
		
		// 5. 이벤트 처리
		// 사원목록(btn1) 버튼을 클릭 시 EMP 테이블에
		// 있는 전체 사원의 목록을 JTable에 띄워주면 됨.
		btn1.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				connect();
				model.setRowCount(0);
				select();
				
			}
		});
		
		// 사원등록(btn2) 버튼을 클릭 시 각각의 텍스트필드에
		// 입력된 데이터를 EMP 테이블에 추가해 주고, 
		// JTable에는 추가로 등록된 사원까지 나타나면 됨.
		btn2.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				connect();
				
				EmpDTO dto = new EmpDTO();
				dto.setEmpno
					(Integer.parseInt(jtf1.getText()));
				dto.setEname(jtf2.getText());
				dto.setJob
					(jcb1.getSelectedItem().toString());
				dto.setMgr
					(Integer.parseInt(jcb2.getSelectedItem().toString().substring(0, 4)));
				dto.setSal(Integer.parseInt(jtf3.getText()));
				dto.setComm(Integer.parseInt(jtf4.getText()));
				dto.setDeptno
					(Integer.parseInt(jcb3.getSelectedItem().toString().substring(0, 2)));
				
				// EMP 테이블에 사원을 등록하는 메서드 호출.
				insert(dto);
				
				// 입력하는 영역 초기화 작업
				jtf1.setText(""); jtf2.setText("");
				jtf3.setText(""); jtf4.setText("");
				
				jcb1.setSelectedIndex(0);
				jcb2.setSelectedIndex(0);
				jcb3.setSelectedItem("선택");
				
				jtf1.requestFocus();
				
				model.setRowCount(0);
				
				// DB에 사원 등록 반영된 전체리스트 메서드 호출.
				select();
				
			}
		});
		
		
		// 사원수정(btn3) 버튼 클릭 시 각각의 텍스트필드에
		// 수정하여 입력된 데이터를 EMP 테이블에서 수정하고,
		// JTable에 수정된 정보가 나타나게 하면 됨.
		btn3.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				connect();
				
				EmpDTO dto = new EmpDTO();
				
				dto.setEmpno
					(Integer.parseInt(jtf1.getText()));
				
				dto.setJob
					(jcb1.getSelectedItem().toString());
				dto.setMgr
					(Integer.parseInt(jcb2.getSelectedItem().toString().substring(0, 4)));
				dto.setSal(Integer.parseInt(jtf3.getText()));
				dto.setComm(Integer.parseInt(jtf4.getText()));
				dto.setDeptno
					(Integer.parseInt(jcb3.getSelectedItem().toString().substring(0, 2)));
				
				update(dto);
				
				// 입력하는 영역 초기화 작업
				jtf1.setText(""); jtf2.setText("");
				jtf3.setText(""); jtf4.setText("");
				
				jcb1.setSelectedIndex(0);
				jcb2.setSelectedIndex(0);
				jcb3.setSelectedItem("선택");
				
				jtf1.requestFocus();
				
				model.setRowCount(0);
				
				// DB에 사원 수정 반영된 전체리스트 메서드 호출.
				select();
				
			}
		});
		
		
		// 사원삭제(btn4) 버튼 클릭 시 JTable의 특정 
		// 행을 EMP 테이블에서 삭제하는 작업을 진행.
		btn4.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				int result = JOptionPane.showConfirmDialog(null, "장말로 삭제하시겠습니까?", 
						"확인", JOptionPane.YES_NO_OPTION);
				
				if(result == JOptionPane.CLOSED_OPTION) {
					JOptionPane.showMessageDialog(null, "창 닫기를 클릭하셨습니다.");
				}else if(result == JOptionPane.NO_OPTION) {
					JOptionPane.showMessageDialog(null, "취소 버튼을 클릭하셨습니다.");
				}else {
					connect();
					
					// 테이블의 특정 행을 클릭했을 때 해당 테이블의
					// 행의 값(int)을 가져오는 메서드.
					int row = table.getSelectedRow();
					
					// 해당 행의 값을 가져올 때 해당 행의 0번째
					// 열의 값(사번)을 가져오는 메서드.
					int empno = (int)model.getValueAt(row, 0);
					
					
					delete(empno);
					
					// 실제로 테이블 상의 클릭한 한 행을 삭제.
					model.removeRow(row);
					
					// 입력하는 영역 초기화 작업
					jtf1.setText(""); jtf2.setText("");
					jtf3.setText(""); jtf4.setText("");
					
					jcb1.setSelectedIndex(0);
					jcb2.setSelectedIndex(0);
					jcb3.setSelectedItem("선택");
					
					jtf1.requestFocus();
				}
			}
		});
		
		table.addMouseListener(new MouseAdapter() {
		
			@Override
			public void mouseClicked(MouseEvent e) {
				
				int row = table.getSelectedRow();
				
				jtf1.setText(model.getValueAt(row, 0).toString());
				jtf2.setText(model.getValueAt(row, 1).toString());
				jcb1.setSelectedItem(model.getValueAt(row, 2).toString());
			
				int empno = (int)model.getValueAt(row, 3);
				
				connect();
				
				if(empno == 0) {
					jcb2.setSelectedIndex(0);
				}else {
					// 사원번호에 해당하는 사원명을 검색하는 메서드 호출.
					String searchName = findEname(empno);
					jcb2.setSelectedItem(empno + "[" + searchName + "]");
				}
				
				jtf3.setText(model.getValueAt(row, 4).toString());
				jtf4.setText(model.getValueAt(row, 5).toString());
			
				int deptno = (int)model.getValueAt(row, 6);
				
				// 부서번호에 해당하는 부서명을 찾는 메서드 호출
				String dName = findDname(deptno);
			
				jcb3.setSelectedItem(deptno+"["+dName+"]");	
			}
			
		});
		
		
		
	}  // 기본 생성자
	
	// 데이터베이스를 연동하는 메서드
	void connect() {
		String driver =
				"oracle.jdbc.driver.OracleDriver";
				
		String url = 
			"jdbc:oracle:thin:@localhost:1521:xe";
		
		String user = "web";
		
		String password = "dlagkfl1205";
		
		try {
			// 1단계 : 오라클 드라이버를 로딩
			// ==> 동적으로 로딩 : 프로그램을 실행 시에 오라클
			//                 드라이버를 로딩한다는 의미.
			Class.forName(driver);
			
			// 2단계 : 오라클 데이터베이스와 연결 시도
			con = DriverManager.getConnection(url, user, password);
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}  // connection() 메서드 end
	
	
	// 데이터베이스 사용 자원 종료하는 메서드
	void connClose(ResultSet rs, 
			PreparedStatement pstmt) {
		
		
			try {
				if(rs != null) {
					rs.close();
				}
				
				if(pstmt != null) {
					pstmt.close();
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
	
	void connClose(ResultSet rs, 
		PreparedStatement pstmt, Connection con) {
		
			try {
				if(rs != null) {
					rs.close();
				}
				
				if(pstmt != null) {
					pstmt.close();
				}
				
				if(con != null) {
					con.close();
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}


	
	// EMP 테이블에서 담당업무를 조회하는 메서드.
	void comboJob() {
		
		try {
			// 1. 데이터베이스에 전송할 SQL문 작성
			sql = "select distinct(job) from emp "
					+ " order by job";
			
			pstmt = con.prepareStatement(sql);
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행.
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				String job = rs.getString("job");
				
				jcb1.addItem(job);
			}
			
			// 3. 데이터베이스에 연결되어 있던 자원 종료.
			rs.close(); pstmt.close(); // con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	// EMP 테이블의 관리자 사원들을 조회하는 메서드.
	void comboMgr() {
		
		try {
			// 1. 데이터베이스에 전송할 SQL문 작성.
			sql = "select empno, ename "
					+ " from emp "
					+ " where empno in("
					+ "select distinct(mgr) from emp)";
			
			pstmt = con.prepareStatement(sql);
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행.
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int empno = rs.getInt("empno");
				String ename = rs.getString("ename");
				
				jcb2.addItem(empno + "[" + ename + "]");
			}
			
			// 3. 데이터베이스에 연결되어 있던 자원 종료.
			rs.close(); pstmt.close(); // con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}  // comboMgr() 메서드 end
	
	// DEPT 테이블의 전체 리스트를 조회하는 메서드.
	void comboDept() {
		
		try {
			// 1. 데이터베이스에 전송할 SQL문 작성.
			sql = "select * from dept "
						+ "	order by deptno";
			
			pstmt = con.prepareStatement(sql);
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행.
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int deptno = rs.getInt("deptno");
				String dname = rs.getString("dname");
				
				jcb3.addItem(deptno + "[" + dname + "]");
			}
			
			// 3. 데이터베이스에 연결되어 있던 자원 종료
			rs.close(); pstmt.close(); con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}  // comboDept() 메서드 end
	
	
	// EMP 테이블의 전체 사원 목록을 조회하는 메서드.
	void select() {
		
		try {
			// 1. 데이터베이스로 전송할 SQL문 작성.
			sql = "select * from emp "
					+ " order by hiredate desc";
			
			pstmt = con.prepareStatement(sql);
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행.
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
				
				Object[] data = 
					{empno, ename, job, mgr, sal, comm, deptno, hiredate};
				
				// 저장된 한개의 레코드(데이터)를 model에 추가해 주면 됨.
				model.addRow(data);
			}
			
			// 3. 데이터베이스에 연결되어 있던 자원 종료
			rs.close(); pstmt.close(); con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}  // select() 메서드 end
	
	
	// EMP 테이블에 사원을 등록하는 메서드.
	void insert(EmpDTO dto) {
		
		try {
			// 1. 데이터베이스에 전송할 SQL문 작성.
			sql = "insert into emp "
					+ " values(?, ?, ?, ?, sysdate, ?, ?, ?)";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getEmpno());
			pstmt.setString(2, dto.getEname());
			pstmt.setString(3, dto.getJob());
			pstmt.setInt(4, dto.getMgr());
			pstmt.setInt(5, dto.getSal());
			pstmt.setInt(6, dto.getComm());
			pstmt.setInt(7, dto.getDeptno());
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행.
			int res = pstmt.executeUpdate();
			
			if(res > 0) {
				JOptionPane.showMessageDialog(null, "사원 등록 성공!!!");
			}else {
				JOptionPane.showMessageDialog(null, "사원 등록 실패~~~");
			}
			
			// 3. 데이터베이스에 연결된 자원 종료
			pstmt.close(); // con.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}  // insert() 메서드 end
	
	
	// EMP 테이블의 사원의 정보를 수정하는 메서드.
	void update(EmpDTO dto) {
		
		try {
			// 1. 데이터베이스에 전송할 SQL문 작성.
			sql = "update emp set job = ?, mgr = ?, "
					+ " sal = ?, comm = ?, deptno = ? "
					+ " where empno = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, dto.getJob());
			pstmt.setInt(2, dto.getMgr());
			pstmt.setInt(3, dto.getSal());
			pstmt.setInt(4, dto.getComm());
			pstmt.setInt(5, dto.getDeptno());
			pstmt.setInt(6, dto.getEmpno());
			
			// 2. 데이터베이스에 SQL문 전송 및 SQL문 실행.
			int res = pstmt.executeUpdate();
			
			if(res > 0) {
				JOptionPane.showMessageDialog(null, "사원 정보 수정 성공!!!");
			}else {
				JOptionPane.showMessageDialog(null, "사원 정보 수정 실패~~~");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			connClose(rs, pstmt);
		}
		
	}  // update() 메서드 end
	
	// JTable에서 특정 행을 클릭 시 EMP 테이블에서
	// 해당 행을 삭제하는 메서드.
	void delete(int empno) {
		
		try {
			// 1. 데이터베이스로 전송할 SQL문 작성.
			sql = "delete from emp where "
					+ " empno = ?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, empno);
			
			// 2. 데이터베이스로 SQL문 전송 및 SQL문 실행.
			int res = pstmt.executeUpdate();
			
			if(res > 0) {
				JOptionPane.showMessageDialog(null, "사원 삭제 성공!!!");
			}else {
				JOptionPane.showMessageDialog(null, "사원 삭제 실패~~~");
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			connClose(rs, pstmt, con);
		}
	
	}  // delete() 메서드 end
	
	// 인자로 넘어온 사원번호로 사원명을 검색하는 메서드
	String findEname(int num) {
		
		String findName = null;
		
		try {
			sql = "select ename from emp "
					+ " where empno = ?";
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				findName = rs.getString("ename");
			}
			
			rs.close(); pstmt.close(); // con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return findName;
	}  // findEname() 메서드 end
	
	// 인자로 넘어온 부서번호에 해당하는 부서명을 찾는 메서드.
	String findDname(int no) {
		
		String findDname = null;
		
		try {
			sql = "select dname from dept "
					+ " where deptno = ?";
		
			pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				findDname = rs.getString("dname");
			}
			
			rs.close(); pstmt.close(); // con.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return findDname;
		
	}  // findDname() 메서드 end
	
	
	public static void main(String[] args) {
	
		new EMP();

	}

}
