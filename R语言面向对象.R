#R语言实现封装

# 定义老师对象和行为
teacher <- function(x, ...) 
    UseMethod("teacher")
teacher.lecture <- function(x)
    print("讲课")
teacher.assignment <- function(x)
    print("布置作业")
teacher.correcting <- function(x)
    print("批改作业")
teacher.default <- function(x)
    print("你不是teacher")

# 定义同学对象和行为
student <- function(x, ...)
    UseMethod("student")
student.attend <- function(x) 
    print("听课")
student.homework <- function(x) 
    print("写作业")
student.exam <- function(x) 
    print("考试")
student.default<-function(x) 
    print("你不是student")

# 定义两个变量，a老师和b同学
a <- 'teacher'
b <- 'student'

# 给老师变量设置行为
attr(a, 'class') <- 'lecture'
# 执行老师的行为
teacher(a)

# 给同学设置行为
attr(b, 'class') <- 'attend'
# 执行同学的行为
student(b)

attr(a, 'class') <- 'assignment'
teacher(a)

attr(b, 'class') <- 'homework'
student(b)

attr(a, 'class') <- 'correcting'
teacher(a)

# 定义一个变量，既是老师有事同学
ab <- 'student_teacher'
# 分别设置不同对象的行为
attr(ab, 'class') <- c('lecture', 'homework')
# 执行老师的行为
teacher(ab)
# 执行同学的行为
student(ab)

# R语言实现继承
student.correcting <- function(x)
    print("帮助老师改作业")
# 辅助变量用于设置初始值
char0 = character(0)

# 实现继承关系
create <- function(classes=char0, parents=char0){
    mro <- c(classes)
    print("打印mro")
    print(mro)
    for (name in parents){
        print("打印name in parents")
        print(name)
        mor <- c(mro, name)
        ancestors <- attr(get(name), 'type')    # Search by name for an object (get) or zero or more objects (mget).
        mro <- c(mro, ancestors[ancestors != name])
    }
    print("打印create()的结果")
    print(mro)
    return(mro)
}

# 定义构造函数，创建对象
NewInstance <- function(value=0, classes=char0, parents=char0){
    obj <- value
    attr(obj, 'type') <- create(classes, parents)
    attr(obj, 'class') <- c('homework', 'correting', 'exam')
    return(obj)
}

# 创建父对象实例
StudentObj <- NewInstance()

# 创建子对象实例
s1 <- NewInstance('普通同学',classes='normal', parents='StudentObj')
s2 <- NewInstance('课代表',classes='leader', parents='StudentObj')

# 给课代表增加批改作业的行为
attr(s2, 'class') <- c(attr(s2, 'class'), 'correcting')

# 查看普通同学的对象实例
s1

# 查看课代表的对象实例
s2


# R语言实现多态
e1 <- NewInstance('优等生', classes = 'excellent', parents = 'StudentObj')
e2 <- NewInstance('次等生', classes = 'poor', parents = 'StudentObj')

# 修改同学考试的行为，大于85分结果为优秀，小于70分结果为及格
student.exam <- function(x, score){
    p <- '考试'
    if (score > 85)
        print(paste(p, "结果为优秀", sep = ""))
    if (score < 70)
        print(paste(p, "结果为及格", sep = ""))
}

# 执行优等生的考试行为，并输入分数为90
attr(e1, 'class') <- 'exam'
student(e1, 90)

# 执行次等生的考试行为，并输入分数为66
attr(e2, 'class') <- 'exam'
student(e2, 66)

# R语言的面向过程编程

#########################################
# 定义老师和同学两个对象和行为
# 辅助变量用于设置初始值
char0 <- character(1)

# 定义老师对象和行为
teacher_fun <- function(x = char0){
    if (x == 'lecture'){
        print('讲课')
    } else if (x == "assignment"){
        print("布置作业")
    } else if (x == "correcting"){
        print("批改作业")
    } else{
        print("你不是teacher")
    }
}

# 定义同学对象和行为
student_fun <- function(x = char0){
    if (x == 'attend'){
        print("听课")
    } else if (x == 'homework'){
        print("写作业")
    } else if (x == "exam"){
        print("考试")
    } else {
        print("你不是student")
    }
}

# 执行老师的一个行为
teacher_fun('lecture')

# 执行同学的一个行为
student_fun('attend')

#########################################
# 区别普通同学和课代表的行为

# 重新定义同学的函数，增加角色判断
student_fun <- function(x = char0, role = 0){
    if ( x== 'attend'){
        print("听课")
    }else if (x == "homework"){
        print("写作业")
    } else if (x == "correcting"){
        if (role == 1)
            print("帮助老师批改作业")
        else
            print("你不是课代表")
    } else{
        print("你不是student")
    }
}

# 以普通同学的角色，执行课代表的行为
student_fun('correcting')

# 以课代表的角色，执行课代表的行为
student_fun('correcting',1)

#########################################
# 参加考试，以成绩区别出优等生和次等生

# 修改同学的函数定义，增加扩盎司成绩参数
student_fun <- function(x = char0, role = 0, score){
    if ( x == 'attend')
        print("听课")
    else if (x == 'homework')
        print('写作业')
    else if (x == 'exam'){
        p <- '考试'
        if (score > 85)
            print(paste(p, "成绩优秀", sep = ""))
        if (score < 85)
            print(paste0(p, "成绩及格"))
    } else if (x == 'correcting'){
        if (role == 1)
            print("帮老师批改作业")
        else
            print("你不是课代表")
    } else
        print("你不是student")
}

# 执行考试函数，考试成绩为大于85分，为优等生
student_fun('exam', score = 90)

# 执行考试函数，考试成绩为小于70分，为次等生
student_fun('exam', score = 66)
