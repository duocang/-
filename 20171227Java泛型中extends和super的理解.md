## Java泛型中extends和super的理解

首先，泛型的出现时为了安全，所有与泛型相关的异常都应该在编译期间发现，因此为了泛型的绝对安全，java在设计时做了相关的限制：

List<? extends E>表示该list集合中存放的都是E的子类型（包括E自身），由于E的子类型可能有很多，但是我们存放元素时实际上只能存放其中的一种子类型（这是为了泛型安全，因为其会在编译期间生成桥接方法**<Bridge Methods>**该方法中会出现强制转换，若出现多种子类型，则会强制转换失败），例子如下：

```
List<? extends Number> list=new ArrayList<Number>();
        list.add(4.0);//编译错误
        list.add(3);//编译错误
```

例中添加的元素类型不止一种，这样编译器强制转换会失败，为了安全，Java只能将其设计成不能添加元素。

虽然List<? extends E>不能添加元素，但是由于其中的元素都有一个共性--有共同的父类，因此我们在获取元素时可以将他们统一强制转换为E类型，我们称之为**get原则**。

对于List<? super E>其list中存放的都是E的父类型元素（包括E），我们在向其添加元素时，只能向其添加E的子类型元素（包括E类型），这样在编译期间将其强制转换为E类型时是类型安全的，因此可以添加元素，例子如下：

```
 List<? super Number> list=new ArrayList<Number>();
        list.add(2.0);
        list.add(3.0);
```
但是，由于该集合中的元素都是E的父类型（包括E），其中的元素类型众多，在获取元素时我们无法判断是哪一种类型，故设计成不能获取元素，我们称之为**put原则**。

实际上，我们采用extends，super来扩展泛型的目的是为了弥补例如List<E>只能存放一种特定类型数据的不足，将其扩展为List<? extends E> 使其可以接收E的子类型中的任何一种类型元素，这样使它的使用范围更广。

List<? super E>同理。

>? 通配符类型
<? extends T> 表示类型的上界，表示参数化类型的可能是T 或是 T的子类
<? super T> 表示类型下界（Java Core中叫超类型限定），表示参数化类型是此类型的超类型（父类型），直至Object

Java的类型擦除：类型擦除中第一步——将所有的泛型参数用其最左边界（最顶级的父类型）类型替换。
这里的左边届可以通过extends来体现。

>当生成泛型类的字节码时，编译器用类型参数的擦除替换类型参数。对于无限制类型参数 （），它的擦除是 Object。对于上限类型参数（>），它的擦除是其上限（在本例中是 Comparable）的擦除。对于具有多个限制的类型参数，使用其最左限制的擦除。


#### extends
上界用extends关键字声明，表示参数化的类型可能是所指定的类型，或者是此类型的子类。

比如，我们现在定义：List<? extends T>首先你很容易误解它为继承于T的所有类的集合，你可能认为，你定义的这个List可以用来put任何T的子类，那么我们看一下下面的代码：

```
import java.util.LinkedList;
import java.util.List;
/**
 * @author hollis
 */
public class testGeneric {
    public static void main(String[] args) {
        List<? extends Season> seasonList = new LinkedList<>();
        seasonList.add(new Spring());
    }
}
class Season{
}
class Spring extends Season{
}
```
seasonList.add(new Spring());这行会报错：The method put(Spring) is undefined for the type List<capture#1-of ? extends Season>


>List<? extends Season> 表示 “具有任何从Season继承类型的列表”，编译器无法确定List所持有的类型，所以无法安全的向其中添加对象。可以添加null,因为null 可以表示任何类型。所以List 的add 方法不能添加任何有意义的元素，但是可以接受现有的子类型List 赋值。
你也许试图这样做：

```
List<? extends Season> seasonList = new LinkedList<Spring>();
seasonList.add(new Spring());
```
但是，即使指明了Spring，也不能用add方法添加一个Spring对象。list中为什么不能加入Season类和Season类的子类呢，原因是这样的：
List<? extends Fruit>表示上限是Fruit,下面这样的赋值都是合法的:

```
 List<? extends Season> list1 = new ArrayList<Season>();
 List<? extends Season> list2 = new ArrayList<Spring>();
 List<? extends Season> list3 = new ArrayList<Winter>();
```

如果List<? extends Season>支持add方法的方法合法的话

list1可以add Season和所有Season的子类

list2可以add Spring和所有Spring的子类

list3可以add Winter和所有Winter的子类

**这样的话，问题就出现了**

List<? extends Season>所应该持有的对象是Season的子类，而且具体是哪一个子类还是个未知数，所以加入任何Season的子类都会有问题，
因为如果add Spring的话，可能List<? extends Season>持有的对象是new ArrayList()
Spring的加入肯定是不行的，如果 如果add Winter的话，可能List<? extends Season>持有的对象是new ArrayList<Jonathan的子类>()
Winter的加入又不合法，所以List<? extends Season> list 不能进行add

但是，这种形式还是很有用的，虽然不能使用add方法，但是可以在初始化的时候一个Season指定不同的类型。比如：
List<? extends Season> list1 = getSeasonList();//getSeasonList方法会返回一个Season的子类的list.

另外，由于我们已经保证了List中保存的是Season类或者他的某一个子类，所以，可以用get方法直接获得值：

```
List<? extends Season> seasonList = new LinkedList();
Spring spring = (Spring) seasonList.get(0);
Season season = seasonList.get(1);
```

### super
下界用super进行声明，表示参数化的类型可能是所指定的类型，或者是此类型的父类型，直至Object。

如：

```
List<Fruit> fruits = new ArrayList<Fruit>();
List<? super Apple> = fruits;
fruits.add(new Apple());                 //work
fruits.add(new RedApple());              //work
fruits.add(new Fruit());                 //compile error 
fruits.add(new Object());                //compile error
```
这里的fruits是一个Apple的超类（父类,superclass）的List。同样地，出于对类型安全的考虑，我们可以加入Apple对象或者其任何子类（如RedApple）对象，但由于编译器并不知道List的内容究竟是Apple的哪个超类，因此不允许加入特定的任何超类型。

而当我们读取的时候，编译器在不知道是什么类型的情况下只能返回Object对象，因为Object是任何Java类的最终祖先类。

### PECS原则
如果要从集合中读取类型T的数据，并且不能写入，可以使用 ? extends 通配符；(Producer Extends)

如果要从集合中写入类型T的数据，并且不需要读取，可以使用 ? super 通配符；(Consumer Super)

如果既要存又要取，那么就不要使用任何通配符。