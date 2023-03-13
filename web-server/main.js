// 入口文件

/*
1.实例化Vue。
2.放置项目中经常会用到的插件和CSS样式。例如： 网络请求插件:axios和vue-resource、图片懒加载插件：vue-lazyload
3.存储全局变量。例如（用于的基本信息）
链接：https://www.jianshu.com/p/e108ae9d1c88
是初始化vue实例并使用需要的插件
并且将你的内容渲染到主页面上
是你的项目的入口文件
它执行的时候都是从你的 main.js 从上到下的执行的
链接：https://blog.csdn.net/qq_44163269/article/details/105227457
*/

// es6语法支持

//require 钩子将自身绑定到 node 的 require 模块上，并在运行时自动编译文件https://zhuanlan.zhihu.com/p/390874006
require('babel-register'); 
require('./src/app');