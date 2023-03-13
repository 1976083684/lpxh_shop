import express from 'express'
import config from './config'
import indexRouter from '../routes/index'

import createError from 'http-errors'
import cookieParser from 'cookie-parser'
import logger from 'morgan'
import session from 'express-session'

const app = express();

// 使用cors解决跨域问题
import cors from 'cors'
app.use(cors());

// 解析 cookie，将cookie从req.headers.cookie取出来，处理后存入一个对象
// 经过插件的处理，就可以通过 req.cookies 来访问 cookie 了。
app.use(cookieParser());

// 使用express-session保存用户登录状况
app.use(session({
	secret: config.secret,
	resave: false,
	saveUninitialized: true,
	cookie: {
		maxAge: config.maxAge, 
	},
}));


// 请求体
import bodyParser from 'body-parser'
app.use(bodyParser.urlencoded({extended: false}));

let ejs = require('ejs');
// 配置Express 视图引擎, Express默认的模板引擎是pug（jade），想要渲染html页面必须要导入对应的模板引擎ejs
app.set('views', config.viewsPath); // 设置模板文件夹的路径
app.engine('html', ejs.__express);
app.set('view engine', 'html');

app.use(logger('dev')); // 可以很轻松的写日志了。
app.use(express.json()); // 可以通过 req.body 来获取数据
app.use(express.urlencoded({ extended: false })); // 兼容不同的提交方式 
app.use(express.static(config.publicPath)); // 静态资源路径

app.use('/', indexRouter);  
// 区别
// app.use(path,callback)中的callback既可以是router对象又可以是函数
// app.get(path,callback)中的callback只能是函数

// catch 404 and forward to error handler,简单处理
app.use((req, res, next) => {
  next(createError(404)); // 遇到错误时，统一处理，后台打印404，相当于try，catch，并不会中断程序报错
});

// error handler， 返回错误页面
app.use((err, req, res, next) => {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};
  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

app.listen(config.port, ()=>{
    console.log(`服务器已经启动, 端口是: ${config.port}`);
});

export default app;
