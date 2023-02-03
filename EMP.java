package khie;

import java.awt.BorderLayout;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;


public class EMP extends JFrame {

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
				ScrollPaneConstants.VERTICAL_SCROLLBAR_NEVER, 
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
		
		
	}  // 기본 생성자
	
	public static void main(String[] args) {
		
		new EMP();
	}
}
