1.node_modules文件夹
这文件夹就是在创建完项目后，cd到项目目录执行npm install后生成的文件夹，下载了项目需要的依赖项

2.package.json文件
此文件是项目的配置文件（可定义应用程序名，版本，依赖项等等）
node_modules文件夹下的依赖项是从哪里知道的呢？原因就是项目根目录下的这个package.json文件，执行npm install时会去找此文件中的dependencies，并安装指定的依赖项

3.public文件夹(包含images、javascripts、stylesheets)
这个文件夹做过Web开发的应该一看就知道，为了存放图片、脚本、样式等文件的

4.routes文件夹
用于存放路由文件，

5.views文件夹
用于存放模版文件


