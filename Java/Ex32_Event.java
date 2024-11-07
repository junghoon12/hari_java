package basic;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.ScrollPaneConstants;

public class Ex32_Event extends JFrame {

	public Ex32_Event() {
	
		setTitle("간단한 계산기");
		
		// 1. 컨테이너를 3개를 만들자.
		JPanel container1 = new JPanel();
		JPanel container2 = new JPanel();
		JPanel container3 = new JPanel();
		
		
		// 2. 컴포넌트를 만들자.
		// 2-1. 상단에 들어갈 컴포넌트를 만들자.
		JLabel jl1 = new JLabel("수 1 : ");
		JTextField jtf1 = new JTextField(5);
		
		JLabel jl2 = new JLabel("수 2 : ");
		JTextField jtf2 = new JTextField(5);
		
		JLabel jl3 = new JLabel("연산자 : ");
		JTextField jtf3 = new JTextField(1);
		
		// 2-2. 중앙에 들어갈 컴포넌트를 만들자.
		JTextArea jTextArea = new JTextArea(5, 20);
		
		JScrollPane jsp = new JScrollPane(
				jTextArea, 
				ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED, 
				ScrollPaneConstants.HORIZONTAL_SCROLLBAR_NEVER);
				
		// 2-3. 하단에 들어갈 컴포넌트를 만둘자.
		JButton button1 = new JButton("계 산");
		JButton button2 = new JButton("종 료");
		JButton button3 = new JButton("취 소");
		
		// 3. 컴포넌트를 컨테이너에 올려주어야 한다.
		// 3-1. 상단 컨테이너에 들어갈 컴포넌트들을 올려 주자.
		container1.add(jl1); container1.add(jtf1);
		container1.add(jl2); container1.add(jtf2);
		container1.add(jl3); container1.add(jtf3);
		
		// 3-2. 중앙 컨테이너에 들어갈 컴포넌트들을 올려 주자.
		container2.add(jsp);
		
		// 3-3. 하단 컨테이너에 들어갈 컨포넌트들을 올려 주자.
		container3.add(button1);
		container3.add(button2); container3.add(button3);
		
		// 4. 컨테이너를 프레임에 올려 주어야 한다.
		// 컨테이너를 올릴 때 배치를 하여 올려주면 됨.
		
		add(container1, BorderLayout.NORTH);
		add(container2, BorderLayout.CENTER);
		add(container3, BorderLayout.SOUTH);
		
		setBounds(100, 100, 100, 300);
		
		// pack() : 프레임의 크기를 조절해 주는 메서드.
		pack();
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		setVisible(true);
		
		
		
		// 5. 이벤트 처리 작업
		// 5-1. 계산(button1) 버튼을 클릭했을 때 이벤트 발생.
		button1.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				int su1 = Integer.parseInt(jtf1.getText());
				
				int su2 = Integer.parseInt(jtf2.getText());
				
				String str = jtf3.getText();
				
				String result = "";
				
				switch(str) {
					case "+" :
						result = "결과 : "+su1+" + "+su2+" = "+(su1+su2);
						break;
					case "-" :
						result = "결과 : "+su1+" - "+su2+" = "+(su1-su2);
						break;
					case "*" :
						result = "결과 : "+su1+" * "+su2+" = "+(su1*su2);
						break;	
					case "/" :
						result = "결과 : "+su1+" / "+su2+" = "+(su1/su2);
						break;
				}  // switch ~ case 문 end
				
				jTextArea.append(result + "\n");
				
				jtf1.setText(""); jtf2.setText("");
				jtf3.setText(null);
				
				jtf1.requestFocus();
				
			}
		});
		
		// 5-2. 종료(button2) 버튼을 클릭했을 때 이벤트 발생.
		button2.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				System.exit(0);
				
			}
		});
		
		// 5-3. 취소(button3) 버튼을 클릭했을 때 이벤트 발생.
		button3.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				
				// 전체 컴포넌트의 값을 clear 시키는 작업
				jtf1.setText(""); jtf2.setText("");
				jtf3.setText(null); jTextArea.setText("");
				
				jtf1.requestFocus();
				
				
			}
		});
		
		
		
	}
	
	public static void main(String[] args) {
		
		new Ex32_Event();

	}

}
