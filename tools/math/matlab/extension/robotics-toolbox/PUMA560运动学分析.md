# [PUMA560运动学分析](https://blog.csdn.net/zina_8786/article/details/106992753)
参考教材：《机器人学第三版蔡自兴》


PUMA560建模与仿真matlab代码
matlab工具箱：robotics toolbox
①下载地址 http://petercorke.com/wordpress/toolboxes/robotics-toolbox 下载安装包(.zip)格式的,将解压后的文件夹” rvctools"复制到 matlab安装路径下的 toolbox文件夹中。

②打开 matlab,点击设置路径->>添加并包含子文件夹,然后选择这 个" rvctools"文件夹,最后保存->>关闭

③打开”rvctool"文件夹的 startup_rvc. m运行,此时roboticstoolbox安装完毕。或者在 matlab命令行输入 startup rvc安装。

④matlab命令行输入ver查看是否安装

>>ver
>>MATLAB 版本: 9.5.0.944444 (R2018b)
>>Robotics Toolbox for MATLAB                           版本 10.3.1 
>>1
>>2
>>3
>>程序说明
>>根据教材上的公式推导，能计算出机器人的四组解，再根据腕关节的"翻转"，能得到另外四组解。（共8组解）。在规划过程中只采用了一组解，并未筛选出最优解。（其余的解被我注释掉了，感兴趣的话，可以用其余的解运行尝试一下👏）
>>主程序
>>% 轨迹规划中，首先建立机器人模型，6R机器人模型，名称modified puma560。
>>% 定义机器人 a--连杆长度，d--连杆偏移量
>>a2=0.4318;a3=0.02032;d2=0.14909;d4=0.43307;
>>%			 thetai    di      ai-1        alphai-1
>>    L1 = Link([pi/2    0       0               0], 'modified');
>>    L2 = Link([0       d2      0           -pi/2], 'modified');
>>    L3 = Link([-pi/2   0       a2              0], 'modified');
>>    L4 = Link([0       d4      a3          -pi/2], 'modified');
>>    L5 = Link([0       0  	   0            pi/2], 'modified');
>>    L6 = Link([0       0       0           -pi/2], 'modified');
>>    robot = SerialLink([L1,L2,L3,L4,L5,L6]);
>>    robot.name = 'modified puma560';
>>%   robot.display();
>>%	robot.teach();
>>% 定义轨迹规划中初始关节角度（First_Theta）和终止关节角度（Final_Theta）、步数777。
>>  % First_Theta = [0     pi/2  -pi/2   0       0     0];%就绪状态
>>  % Final_Theta = [0     pi/4    pi    0       pi/4  0];%灵巧状态
>>% 6角度变化
>>     First_Theta = [0     pi/2  -pi/2   0       0     0];
>>     Final_Theta = [pi/6  pi/4    pi    pi/3   pi/4  pi/2];
>>% jtraj函数关节角空间轨迹规划
>>    step = 777;
>>    [q,qd,qdd] = jtraj(First_Theta,Final_Theta,step);

%平面中一共分成2*4=8个子画图区间，一共两行，每行四个
%在第一行第1个子图画位置信息。
    subplot(2,4,1);
    i = 1:6;
    plot(q(:,i)); grid on;
    title('位置');
%在第一行第2个子图画速度信息。
    subplot(2,4,2);
    i = 1:6;
    plot(qd(:,i));grid on;
    title('速度');
%在第二行第1个子图画加速度信息。
    subplot(2,4,5);
    i = 1:6;
    plot(qdd(:,i));grid on;
    title('加速度');

%根据First_Theta和Final_Theta得到起始和终止的位姿矩阵。
    %运用自带函数求解
%     T0 = robot.fkine(First_Theta);       
%     Tf = robot.fkine(Final_Theta);
    %根据改进DH模型的自编函数，kinematics正运动学求解
     T0=kinematics(First_Theta);
     T0=SE3(T0);
     Tf=kinematics(Final_Theta);
     Tf=SE3(Tf);
%利用ctraj在笛卡尔空间规划轨迹。
    Tc = ctraj(T0,Tf,step);         
%在齐次旋转矩阵中提取移动变量，相当于笛卡尔坐标系的点的位置。
    Tjtraj = transl(Tc);            
%在第二行第2个子图画p1到p2直线轨迹。
    subplot(2,4,6);
    plot2(Tjtraj,'r');grid on;
    title('T0到Tf直线轨迹');

%     hold on;
%在第一行三四子图和第二行三四子图，就相当于整个的右半部分画图
    subplot(2,4,[3,4,7,8]);

 for Var = 1:777
     T1=Tc(1,Var);
     T2=T1.T;
 % Inverse_kinematics逆运动学求解
  qq(:,Var) = Inverse_kinematics(T2);
 end
 plot2(Tjtraj,'r');
 robot.plot(qq');
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
kinematics 函数 (正运动学)
function T0_6=kinematics(theta1_6)
    a2=0.4318;a3=0.02032;d2=0.14909;d4=0.43307;
	theta1=theta1_6(1);
	theta2=theta1_6(2);
	theta3=theta1_6(3);
	theta4=theta1_6(4);
	theta5=theta1_6(5);
	theta6=theta1_6(6);
	c1=cos(theta1);s1=sin(theta1);
	c2=cos(theta2);s2=sin(theta2);
	c3=cos(theta3);s3=sin(theta3);
	c4=cos(theta4);s4=sin(theta4);
	c5=cos(theta5);s5=sin(theta5);
	c6=cos(theta6);s6=sin(theta6);
	%6个连杆变换矩阵
    T1=[c1 -s1 0 0;s1 c1 0 0;0 0 1 0;0 0 0 1];
    T2=[c2 -s2 0 0;0 0 1 d2;-s2 -c2 0 0;0 0 0 1];
    T3=[c3 -s3 0 a2;s3 c3 0 0 ;0 0 1 0;0 0 0 1];
    T4=[c4 -s4 0 a3;0 0 1 d4;-s4 -c4 0 0;0 0 0 1];
    T5=[c5 -s5 0 0 ;0 0 -1 0;s5 c5 0 0;0 0 0 1];
    T6=[c6 -s6 0 0 ;0 0 1 0;-s6 -c6 0 0;0 0 0 1];
    %正运动学方程
    T0_6 = T1*T2*T3*T4*T5*T6;
end
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
Inverse_kinematics 函数（逆运动学）
function theta_Med=Inverse_kinematics(T)
% a--连杆长度，d--连杆偏移量
	a2=0.4318;a3=0.02032;d2=0.14909;d4=0.43307;
    
     nx=T(1,1); ny=T(2,1); nz=T(3,1);  
     ox=T(1,2); oy=T(2,2); oz=T(3,2); 
     ax=T(1,3); ay=T(2,3); az=T(3,3); 
     px=T(1,4); py=T(2,4); pz=T(3,4);

% 为方便计算，定义的m系列向量
% 求解关节角1
	theta1_1 = atan2(py,px)-atan2(d2,sqrt(px^2+py^2-d2^2));
	theta1_2 = atan2(py,px)-atan2(d2,-sqrt(px^2+py^2-d2^2));
% 求解关节角3
	m3_1 = (px^2+py^2+pz^2-a2^2-a3^2-d2^2-d4^2)/(2*a2);
	theta3_1 = atan2(a3,d4)-atan2(m3_1,sqrt(a3^2+d4^2-m3_1^2));
	theta3_2 = atan2(a3,d4)-atan2(m3_1,-sqrt(a3^2+d4^2-m3_1^2));
% 求解关节角2
    ms2_1 = -((a3+a2*cos(theta3_1))*pz)+(cos(theta1_1)*px+sin(theta1_1)*py)*...
    (a2*sin(theta3_1)-d4);
    mc2_1 = (-d4+a2*sin(theta3_1))*pz+(cos(theta1_1)*px+sin(theta1_1)*py)*...
    (a2*cos(theta3_1)+a3);
    theta23_1 = atan2(ms2_1,mc2_1);
    theta2_1 = theta23_1 - theta3_1;
    
    ms2_2 = -((a3+a2*cos(theta3_1))*pz)+(cos(theta1_2)*px+sin(theta1_2)*py)*...
    (a2*sin(theta3_1)-d4);
    mc2_2 = (-d4+a2*sin(theta3_1))*pz+(cos(theta1_2)*px+sin(theta1_2)*py)*...
    (a2*cos(theta3_1)+a3);
    theta23_2 = atan2(ms2_2,mc2_2);
    theta2_2 = theta23_2 - theta3_1;
    
    ms2_3 = -((a3+a2*cos(theta3_2))*pz)+(cos(theta1_1)*px+sin(theta1_1)*py)*...
    (a2*sin(theta3_2)-d4);
    mc2_3 = (-d4+a2*sin(theta3_2))*pz+(cos(theta1_1)*px+sin(theta1_1)*py)*...
    (a2*cos(theta3_2)+a3);
    theta23_3 = atan2(ms2_3,mc2_3);
    theta2_3 = theta23_3 - theta3_2;


​    
    ms2_4 = -((a3+a2*cos(theta3_2))*pz)+(cos(theta1_2)*px+sin(theta1_2)*py)*...
    (a2*sin(theta3_2)-d4);
    mc2_4 = (-d4+a2*sin(theta3_2))*pz+(cos(theta1_2)*px+sin(theta1_2)*py)*...
    (a2*cos(theta3_2)+a3);
    theta23_4 = atan2(ms2_4,mc2_4);
    theta2_4 = theta23_4 - theta3_2;    
% 求解关节角4
    ms4_1=-ax*sin(theta1_1)+ay*cos(theta1_1);
    mc4_1=-ax*cos(theta1_1)*cos(theta23_1)-ay*sin(theta1_1)*...
    cos(theta23_1)+az*sin(theta23_1);
	theta4_1=atan2(ms4_1,mc4_1);
	
	ms4_2=-ax*sin(theta1_2)+ay*cos(theta1_2);
	mc4_2=-ax*cos(theta1_2)*cos(theta23_2)-ay*sin(theta1_2)*...
	cos(theta23_2)+az*sin(theta23_2);
	theta4_2=atan2(ms4_2,mc4_2);
	
	ms4_3=-ax*sin(theta1_1)+ay*cos(theta1_1);
	mc4_3=-ax*cos(theta1_1)*cos(theta23_3)-ay*sin(theta1_1)*...
	cos(theta23_3)+az*sin(theta23_3);
	theta4_3=atan2(ms4_3,mc4_3);
	
	ms4_4=-ax*sin(theta1_2)+ay*cos(theta1_2);
	mc4_4=-ax*cos(theta1_2)*cos(theta23_4)-ay*sin(theta1_2)*...
	cos(theta23_4)+az*sin(theta23_4);
	theta4_4=atan2(ms4_4,mc4_4);
% 求解关节角5
	ms5_1=-ax*(cos(theta1_1)*cos(theta23_1)*cos(theta4_1)+...
	sin(theta1_1)*sin(theta4_1))-...
	ay*(sin(theta1_1)*cos(theta23_1)*cos(theta4_1)-cos(theta1_1)*sin(theta4_1))...
    +az*(sin(theta23_1)*cos(theta4_1));
    mc5_1= ax*(-cos(theta1_1)*sin(theta23_1))+ay*(-sin(theta1_1)*sin(theta23_1))...
           +az*(-cos(theta23_1));
    theta5_1=atan2(ms5_1,mc5_1);
    
	ms5_2=-ax*(cos(theta1_2)*cos(theta23_2)*cos(theta4_2)+...
	sin(theta1_2)*sin(theta4_2))-...
	ay*(sin(theta1_2)*cos(theta23_2)*cos(theta4_2)-cos(theta1_2)*sin(theta4_2))...
	+az*(sin(theta23_2)*cos(theta4_2));
	mc5_2= ax*(-cos(theta1_2)*sin(theta23_2))+ay*(-sin(theta1_2)*sin(theta23_2))...
	       +az*(-cos(theta23_2));
	theta5_2=atan2(ms5_2,mc5_2);
	  
	ms5_3=-ax*(cos(theta1_1)*cos(theta23_3)*cos(theta4_3)+...
	sin(theta1_1)*sin(theta4_3))-...
	ay*(sin(theta1_1)*cos(theta23_3)*cos(theta4_3)-cos(theta1_1)*sin(theta4_3))...
	+az*(sin(theta23_3)*cos(theta4_3));
	mc5_3= ax*(-cos(theta1_1)*sin(theta23_3))+ay*(-sin(theta1_1)*sin(theta23_3))...
	       +az*(-cos(theta23_3));
	theta5_3=atan2(ms5_3,mc5_3);
	
	ms5_4=-ax*(cos(theta1_2)*cos(theta23_4)*cos(theta4_4)+...
	sin(theta1_2)*sin(theta4_4))-...
	ay*(sin(theta1_2)*cos(theta23_4)*cos(theta4_4)-cos(theta1_2)*sin(theta4_4))...
	+az*(sin(theta23_4)*cos(theta4_4));
	mc5_4= ax*(-cos(theta1_2)*sin(theta23_4))+ay*(-sin(theta1_2)*sin(theta23_4))...
	       +az*(-cos(theta23_4));
	theta5_4=atan2(ms5_4,mc5_4);
% 求解关节角6
	ms6_1=-nx*(cos(theta1_1)*cos(theta23_1)*...
			sin(theta4_1)-sin(theta1_1)*cos(theta4_1))...
        -ny*(sin(theta1_1)*cos(theta23_1)*...
        	sin(theta4_1)+cos(theta1_1)*cos(theta4_1))...
        +nz*(sin(theta23_1)*sin(theta4_1));
    mc6_1= nx*(cos(theta1_1)*cos(theta23_1)*cos(theta4_1)...
         +sin(theta1_1)*sin(theta4_1))*cos(theta5_1)...
         -nx*cos(theta1_1)*sin(theta23_1)*sin(theta4_1)...
         +ny*(sin(theta1_1)*cos(theta23_1)*cos(theta4_1)...
        +cos(theta1_1)*sin(theta4_1))*cos(theta5_1)...
        -ny*sin(theta1_1)*sin(theta23_1)*sin(theta5_1)...
        -nz*(sin(theta23_1)*cos(theta4_1)*cos(theta5_1)...
        +cos(theta23_1)*sin(theta5_1));
	theta6_1=atan2(ms6_1,mc6_1);
	
	ms6_2=-nx*(cos(theta1_2)*cos(theta23_2)*...
			sin(theta4_2)-sin(theta1_2)*cos(theta4_2))...
	    -ny*(sin(theta1_2)*cos(theta23_2)*...
	    	sin(theta4_2)+cos(theta1_2)*cos(theta4_2))...
	    +nz*(sin(theta23_2)*sin(theta4_2));
	mc6_2= nx*(cos(theta1_2)*cos(theta23_2)*cos(theta4_2)...
	     +sin(theta1_2)*sin(theta4_2))*cos(theta5_2)...
	     -nx*cos(theta1_2)*sin(theta23_2)*sin(theta4_2)...
	     +ny*(sin(theta1_2)*cos(theta23_2)*cos(theta4_2)...
	    +cos(theta1_2)*sin(theta4_2))*cos(theta5_2)...
	    -ny*sin(theta1_2)*sin(theta23_2)*sin(theta5_2)...
	    -nz*(sin(theta23_2)*cos(theta4_2)*cos(theta5_2)...
	    +cos(theta23_2)*sin(theta5_2));
	theta6_2=atan2(ms6_2,mc6_2);
	
	ms6_3=-nx*(cos(theta1_1)*cos(theta23_3)*...
			sin(theta4_3)-sin(theta1_1)*cos(theta4_3))...
	    -ny*(sin(theta1_1)*cos(theta23_3)*...
	    	sin(theta4_3)+cos(theta1_1)*cos(theta4_3))...
	    +nz*(sin(theta23_3)*sin(theta4_3));
	mc6_3= nx*(cos(theta1_1)*cos(theta23_3)*cos(theta4_3)...
	     +sin(theta1_1)*sin(theta4_3))*cos(theta5_3)...
	     -nx*cos(theta1_1)*sin(theta23_3)*sin(theta4_3)...
	     +ny*(sin(theta1_1)*cos(theta23_3)*cos(theta4_3)...
	    +cos(theta1_1)*sin(theta4_3))*cos(theta5_3)...
	    -ny*sin(theta1_1)*sin(theta23_3)*sin(theta5_3)...
	    -nz*(sin(theta23_3)*cos(theta4_3)*cos(theta5_3)...
	    +cos(theta23_3)*sin(theta5_3));
	theta6_3=atan2(ms6_3,mc6_3);
	
	ms6_4=-nx*(cos(theta1_2)*cos(theta23_4)*...
			sin(theta4_4)-sin(theta1_2)*cos(theta4_4))...
	    -ny*(sin(theta1_1)*cos(theta23_4)*...
	    	sin(theta4_4)+cos(theta1_2)*cos(theta4_4))...
	    +nz*(sin(theta23_4)*sin(theta4_4));
	mc6_4= nx*(cos(theta1_2)*cos(theta23_4)*cos(theta4_4)...
	     +sin(theta1_2)*sin(theta4_4))*cos(theta5_4)...
	     -nx*cos(theta1_2)*sin(theta23_4)*sin(theta4_4)...
	     +ny*(sin(theta1_2)*cos(theta23_4)*cos(theta4_4)...
	    +cos(theta1_2)*sin(theta4_4))*cos(theta5_1)...
	    -ny*sin(theta1_2)*sin(theta23_4)*sin(theta5_4)...
	    -nz*(sin(theta23_4)*cos(theta4_4)*cos(theta5_4)...
	    +cos(theta23_4)*sin(theta5_4));
	theta6_4=atan2(ms6_4,mc6_4);


% 整理得到4组运动学非奇异逆解
	theta_Med_1 = [ theta1_1,theta2_1,theta3_1,theta4_1,theta5_1,theta6_1;
				   %theta1_2,theta2_2,theta3_1,theta4_2,theta5_2,theta6_2;
				   %theta1_1,theta2_3,theta3_2,theta4_3,theta5_3,theta6_3;
				   %theta1_2,theta2_4,theta3_2,theta4_4,theta5_4,theta6_4;
                 ];
% 将操作关节‘翻转’可得到另外4组解
theta_Med_2 = ...
    [ %theta1_1,theta2_1,theta3_1,theta4_1+pi,-theta5_1,theta6_1+pi;
	  %theta1_2,theta2_2,theta3_1,theta4_2+pi,-theta5_2,theta6_2+pi;
	  %theta1_1,theta2_3,theta3_2,theta4_3+pi,-theta5_3,theta6_3+pi;
	  %theta1_2,theta2_4,theta3_2,theta4_4+pi,-theta5_4,theta6_4+pi;
      ];
  theta_Med=[theta_Med_1;theta_Med_2];         
end
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
46
47
48
49
50
51
52
53
54
55
56
57
58
59
60
61
62
63
64
65
66
67
68
69
70
71
72
73
74
75
76
77
78
79
80
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
运行结果