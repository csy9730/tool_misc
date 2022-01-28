# 数据库实体间一对多（多对一）、多对多关系处理
数据库实体间一对多（多对一）、多对多关系处理
数据库实体间有三种对应关系：一对一，一对多，多对多。
一对一关系示例：一个学生对应一个学生档案材料，或者每个人都有唯一的身份证编号。
一对多关系示例：一个学生只属于一个班，但是一个学院有多名学生。
多对多关系示例：一个学生可以选择多门课，一门课也有多名学生。

这三种关系在数据库中逻辑结构处理分析：

1.一对多关系处理：
我们以学生和班级之间的关系来说明一对多的关系处理方法。
假设现有基本表学生表（学号，姓名，……），班级表（班级号，备注信息，……）。

                       
方法一：
新增一个关系表，用来表示学生与班级的属于关系，该关系表包含字段（学生号，班级号）。通过学生号与班级号的对应关系表示学生属于的班级。
方法二：
在学生表中新增字段（班级号），该字段作为学生表的外键与班级表中的班级号关联。每一个学生实体在班级号字段的值，表示该学生属于的班级。
小结：一般情况下，一对多关系采用方法二来处理。一对多的两个实体间，在“多”的实体表中新增一个字段，该字段是“一”实体表的主键。

2.多对多关系处理：

 

在多对多关系中，我们要新增加一个关系表。如在上面示例中，在学生表和课程表的基础上增加选课表来表示学生与课程之间的多对多关系。在选课表中，必须含有的属性有学生号和课程号。（学生号，课程号）这个属性集刚好也就是选课表的关键字。

 