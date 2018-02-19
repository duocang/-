R语言实现封装

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
