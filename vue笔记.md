

#### dom渲染

默认情况下，dom切换会复用重复结构，若不想复用，需要使用key区分

#### 样式绑定
:class绑定的样式和class绑定的不冲突
- 第一种方式是对象： \<div class="x" :class="{z:flag, y"true}">我很帅\</div>
- 第二种方式是数组 ： \<div class="x" :class="[class1, class2, {:z: false}]">我很帅\</div>

#### filter过滤器
vue实例共用过滤器：全局过滤器挂载在vue实例构造器上
computed计算==属性==，不是方法： 方法没有缓存，computed会根据==依赖==的属性进行缓存

- get（必须）
- set （一般，通过js赋值影响其他人或则会表单元素设置值得时候会调用set）
- 计算属性不支持异步

#### watch
- watch的属性名要和观察的对象名字保持一致
- watch支持异步（访问API）
- 设置中间状态（setTimeOut）
- watch默认只监控一层数据，可以设置深度监测handler()

#### v-if 和 v-show
v-if 操作dom
v-show操作样式，\<template>不被v-shwo支持

#### \<template>标签是vue提供的，没有任何意，用于包裹元素 


#####局部组件，一个组件就是一个对象
组件是相互独立的，不能跨组件调用（也不能直接用父组件），实例也是一个组件，组件中拥有生命周期函数

组件理论上可以无限嵌套

let handsome = {template: '\<div>我很英俊</div>'}
1. 创建组件
2. 注册组件
3. 引用组件

#### 实现单页开发的方式

- 通过hash记录跳转的路径（可以产生历史管理）

- 浏览器自带的历史管理（hsitroy）（history.pushState()可能导致404错误）

开发时使用hash的方式，上线后我们使用hsitroy方式



#### 自定义指令

#### localStrorage

#### 组件

如果要在一个组件中使用另外一个组件

1. 先保证被使用的组件是真实存在的
2. 提前定义被引用的组件
3. 组件需要在父级的模版中通过标签的形式引入



#### props 

属性名和data中的名字不能重复，校验是不会阻断代码执行，只会警告



#### 发布-订阅

发布-订阅模式又称为观察者模式，他定义的是一种一对多的依赖关系，带一个状态发生改变时，所有以这个状态的对象都会得到通知。

##### 实用性：

- 发布订阅模式可以广泛的应用于异步编程中
- 发布订阅模式可以取代对象之间的硬编码通知机制

##### 售楼处

- 首先指定好谁充当发布者（售楼处）
- 然后给发布者添加一个缓存列表，用于存放回调函数，以便通知订阅者（售楼处花名册）
- 最后发布消息的时候，发布者会遍历这个缓存列表，依次出发里面存放的订阅者的回调函数

```js
let salesOffices = {} // 售楼处
salesOffices.books = [] // 缓存列表，存放订阅者的回调函数。
// 增加订阅者
salesOffices.listen = function(fn) {
  this.books.push(fn) // 订阅的消息添加近缓存列表里面
}
salesOffices.trigger = function() {
  // 发布消息
  for (let i = 0, fn; (fn = salesOffices.books[i++]); ) {
    fn.apply(this, arguments) // arguments 是发布消息的时候带上的参数
  }
}

salesOffices.listen(function(price, squareMeter) {
  // 购买者a
  console.log(`价格是：${price}`)
  console.log(`面积大小：${squareMeter}`)
})
salesOffices.listen(function(price, squareMeter) {
  // 购买者b
  console.log(`价格是：${price}`)
  console.log(`面积大小：${squareMeter}`)
})

salesOffices.trigger(2000000, 88)
salesOffices.trigger(3000000, 128)

```

##### vue对发布订阅模式的使用

vue的数据初始化：

```js
var v = new Vue({
  data() {
    return {
      a: 'hello'
    }
  }
})
```

这个初始化的代码的背后包含着发布订阅模式的思想，接下来看看官网的一个图

![上面代码的别后包含着发布订阅的思想](https://segmentfault.com/img/remote/1460000013338806?w=1200&h=750)



#### 插槽

Vue实现了一套内容分发的API，\<slot>元素作为承载分发内容的出口。通俗地说，插槽用于决定将所携带的内容，插入到指定的某一个位置，从而使模版分块，具有模块化的特指和更大的重用

\<slot>可以被看做占位符、标签替代。父组件中放入带有slot属性的内容，然后这些内容就会被分到子组件中的特殊slot元素，根据name属性在子组件中重新组合、替换。

```html
<!--父组件-->
<div id="parent">
    <child>
        <!--等待分发的内容-->
        <p slot="one">一些内容</p>  
        <p slot="two">另外一些内容</p>
        <p>不带slot属性的标签</p>
    </child>
</div>
```

```html
<!--子组件-->
<div id="child">
    <slot><h1>默认替换不带slot的元素</h1></slot>
    <slot name="one">会被替换成父组件中slot="one"的元素</slot>
    <slot name="two">会被替换成父组件中slot="two"的元素</slot>
    <p>子组件自己的标签</p>
</div>
```

最后会被渲染成：

标签的顺序是根据子组件的顺序排列的

```html
<div>  
    <!--渲染后-->
    <p>不带slot属性的标签</p> <!--父组件的第三个<p>覆盖了子组件的第一个slot（不带name的slot）-->
    <p>一些内容</p> 
    <p>另外一些内容</p> 
    <p>子组件自己的标签</p>
</div>
```

如果父组件内没有那个不带slot属性的p标签，则子组件内不带name属性的\<slot>会显示标签内的内容，没有标签包裹。

```html
<div>  
    <!--渲染后-->
    <h1>默认替换不带slot的元素</h1>
    <p>一些内容</p> 
    <p>另外一些内容</p> 
    <p>子组件自己的标签</p>
</div>
```

slot就是外部调用时会被外部替换掉，如果外部没有内容则显示自己的内容;

 