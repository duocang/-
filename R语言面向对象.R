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
