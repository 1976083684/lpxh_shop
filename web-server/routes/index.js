import express from 'express'
const router = express.Router({})

const alipaySdk = require('../db/alipayUtil');
const AlipayFormData = require('alipay-sdk/lib/form').default;
const cors = require('cors');
router.use(cors());
router.use(express.urlencoded({extended:true}));
// const axios = require('axios');
import  axios  from 'axios';
import mysql from 'mysql'
import config from '../src/config'
import sqlConfig from '../db/db'
import sms_util from './../util/sms_util'


import svgCaptcha from 'svg-captcha'
import md5 from 'blueimp-md5'
import formidable from 'formidable'
import {basename} from 'path'
import { Console } from 'console'
import dayjs from 'dayjs'

const S_KEY = '@WaLQ1314?.LqFtK.Com.#'; // 盐
const users = {}; // 用户信息
let tmp_captcha = '';

let conn
// 隔一定时间，数据库断开连接。闭包重来
function handleDisconnect() {
    conn = mysql.createConnection(sqlConfig); // Recreate the connection, since
                                                    // the old one cannot be reused.
  
    conn.connect(function(err) {              // The server is either down
      if(err) {                                     // or restarting (takes a while sometimes).
        console.log('error when connecting to db:', err);
        setTimeout(handleDisconnect, 2000); // We introduce a delay before attempting to reconnect,
        console.log('2323', conn)
      }                                     // to avoid a hot loop, and to allow our node script to
    });                                     // process asynchronous requests in the meantime.
                                            // If you're also serving http, display a 503 error.
    conn.on('error', function(err) {
      console.log('db error', err);
      if(err.code === 'PROTOCOL_CONNECTION_LOST') { // Connection to the MySQL server is usually
        handleDisconnect();                         // lost due to either server restart, or a
      } else {                                      // connnection idle timeout (the wait_timeout
        throw err;                                  // server variable configures this)
      }
    });
  }
  
handleDisconnect();

/* GET home page. */
router.get('/', (req, res, next) => {
    console.log(md5(md5("admin") + S_KEY))
    res.render('index', {title: '商城'});
});

/**************************************** 前台商城 ****************************************** */
/**
 * 获取首页轮播图
 */
router.get('/api/homecasual', (req, res) => {
    let sqlStr = 'SELECT * FROM homecasual';
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求轮播图数据失败'});
            console.log(error);
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 获取商品分类数
 */
router.get('/api/category', (req, res) => {
    let sqlStr = 'SELECT * FROM category';
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求商品分类数据失败'});
            console.log(error);
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 模糊搜索(商品名称)
 */
router.post('/api/searchgoods', (req, res) => {
    // 获取参数
    let keywords = req.body.keywords;
	keywords = keywords.replace(/\s+/g, ' ');
	keywords = keywords.replace(/(^\s*)|(\s*$)/g, '');
    let keyArr = keywords.split(' ');
    let sqlStr = 'SELECT * FROM recommend WHERE goods_name LIKE ';  // sql语句
    keyArr.forEach((item, index, arr)=>{
        sqlStr += "'%" + item + "%'";
        if(index != arr.length-1){
            sqlStr += " OR goods_name LIKE ";
        }
    });
    conn.query(sqlStr, (error, results, fields) => {
        results = JSON.parse(JSON.stringify(results));
        if (!error && results.length) {
            res.json({success_code: 200, message: results});
        }else{
            res.json({err_code: 0, message: '找不到商品'});
        }
    });
});

/**
 * 获取推荐商品列表
 *  1, 3
 */
router.get('/api/recommendshoplist', (req, res) => {
    // 获取参数
	let category = req.query.category || 1
    let pageNo = req.query.pageNo || 1;
    let pageSize = req.query.count || 3;

    let sqlStr = 'SELECT * FROM recommend WHERE category = ' + category + ' LIMIT ' + (pageNo - 1) * pageSize + ',' + pageSize;

    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求商品列表数据失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 获取所有商品
 */
router.get('/api/allgoods', (req, res) => {

    let sqlStr = 'SELECT * FROM recommend';

    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求商品数据失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 获取首页商品列表
 */
router.get('/api/homeshoplist', (req, res) => {
    // 获取总分类
    let cateSqlStr = 'SELECT COUNT(*) FROM category';
	conn.query(cateSqlStr, (error, results, fields) => {
		if (!error) {
            let sqlStr = '';
            for(let i=0; i < results[0]['COUNT(*)']; i++){
                sqlStr += 'SELECT * FROM recommend WHERE category = ' + (i+1) + ' LIMIT 5;';
            }
            conn.query(sqlStr, (error, results, fields) => {
                if (!error) {
                    results = JSON.parse(JSON.stringify(results));
                    res.json({success_code: 200, message: results});
                }
            });
		}
	});
});

/**
 * 获取商品详细信息
 */
router.get('/api/goodsdetail', (req, res) => {
    // 获取参数
    let goodsNo = req.query.goodsNo;
	let sqlStr = 'SELECT * FROM recommend WHERE goods_id = ' + goodsNo;
	conn.query(sqlStr, (error, results, fields) => {
		if (!error) {
            results = JSON.parse(JSON.stringify(results));
			res.json({success_code: 200, message: results});
		}
	});
});

/**
 * 获取商品评价
 */ 
router.get('/api/goodscomment', (req, res) => {
    // 获取参数
    let goodsId = req.query.goodsId;

	let sqlStr = 'SELECT user_info.id, user_info.user_name, user_info.user_nickname, comments.comment_detail, comments.comment_id, comments.comment_rating, comments.goods_id FROM user_info INNER JOIN comments ON user_info.id = comments.user_id WHERE goods_id = ' + goodsId;
	conn.query(sqlStr, (error, results, fields) => {
		if (!error) {
            results = JSON.parse(JSON.stringify(results));
			res.json({success_code: 200, message: results});
		}
	});
});

/**
  评论商品
*/
router.post('/api/postcomment', (req, res) => {
	// 获取参数
	let goods_id = req.body.goods_id;
	let comment_detail = req.body.comment_detail;
	let comment_rating = req.body.comment_rating;
	let user_id = req.body.user_id;
    const addSql = "INSERT INTO comments(goods_id, comment_detail, comment_rating, user_id) VALUES (?, ?, ?, ?)";
    const addSqlParams = [goods_id, comment_detail, comment_rating, user_id];
    conn.query(addSql, addSqlParams, (error, results, fields) => {
        results = JSON.parse(JSON.stringify(results));
        if (!error) {
          // 更新数据
          let sqlStr = "UPDATE recommend SET comments_count = comments_count + 1 WHERE goods_id = " + goods_id;
          conn.query(sqlStr, (error, results, fields) => {
            if (error) {
              console.log(error);
            } else {
              res.json({success_code: 200, message: "发布成功"});
            }
          });
        }
     });
});

/**
 一次性图形验证码
*/
router.get('/api/captcha', (req, res) => {
    // 生成随机验证码
    let captcha = svgCaptcha.create({
        color: true,
        noise: 3,
        ignoreChars: '0o1iIO',
        size: 4
    });

    // 保存
    req.session.captcha = captcha.text.toLocaleLowerCase();
	tmp_captcha = captcha.text.toLocaleLowerCase();

    // 返回客户端
    res.type('svg');
    res.send(captcha.data);
});

/**
  发送验证码短信
*/
router.get('/api/send_code', (req, res) => {
    // 获取手机号码
    let phone = req.query.phone;
    // 随机产生验证码
    let code = sms_util.randomCode(6);

    /* sms_util.sendCode(phone, code, function (success) {
        if (success) {
             users[phone] = code;
             res.json({success_code: 200, message: '验证码获取成功!'});
         } else {
             res.json({err_code: 0, message: '验证码获取失败!'});
         }
     });*/

    // 成功——模拟短信功能
    setTimeout(() => {
        users[phone] = code;
        res.json({success_code: 200, message: code});
    }, 2000);
});

/**
  手机验证码登录
*/
router.post('/api/login_code', (req, res) => {
// console.log(req.session.captcha);
	// console.log(tmp_captcha);
    // 获取数据
	const user_name = req.body.name;
    const user_pwd = md5(md5(req.body.pwd) + S_KEY);
    const captcha = req.body.captcha.toLowerCase();

    // 验证图形验证码是否正确
    if (captcha !== tmp_captcha) {
        res.json({err_code: 0, message: '图形验证码不正确!'});
        return;
    }

    tmp_captcha = '';
    
    // 查询数据
    let sqlStr = "SELECT * FROM user_info WHERE user_name = '" + user_name + "' LIMIT 1";
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '用户名不正确!'});
        } else {
            results = JSON.parse(JSON.stringify(results));

            if (results[0]) {  // 用户已经存在
                res.json({err_code: 0, message: '用户已存在'});
            } else { // 新用户
                const addSql = "INSERT INTO user_info(user_name, user_pwd, user_avatar) VALUES (?, ?, ?)";
                const addSqlParams = [user_name, user_pwd, 'http://localhost:' + config.port + '/avatar_uploads/avatar_default.jpg'];
                conn.query(addSql, addSqlParams, (error, results, fields) => {
                    results = JSON.parse(JSON.stringify(results));
                    if (!error) {
                        req.session.userId = results.insertId;
                        let sqlStr = "SELECT * FROM user_info WHERE id = '" + results.insertId + "' LIMIT 1";
                        conn.query(sqlStr, (error, results, fields) => {
                            if (error) {
                                res.json({err_code: 0, message: '注册失败'});
                            } else {
                                results = JSON.parse(JSON.stringify(results));
                                
                                res.json({
                                    success_code: 200,
                                    message: {
                                        id: results[0].id,
                                        user_name: results[0].user_name || '',
                                        user_nickname: results[0].user_nickname || '',
                                        user_avatar: results[0].user_avatar || ''
                                    }
                                });
                            }
                        });
                    }
                });
            }
        }
    });    

});

/**
  注册
*/
router.post('/api/register', (req, res) => {
	// console.log(req.session.captcha);
	// console.log(tmp_captcha);
    // 获取数据
	const user_name = req.body.name;
    const user_pwd = md5(md5(req.body.pwd) + S_KEY);
    
    // 查询数据
    let sqlStr = "SELECT * FROM user_info WHERE user_name = '" + user_name + "' LIMIT 1";
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '用户名不正确!'});
        } else {
            results = JSON.parse(JSON.stringify(results));

            if (results[0]) {  // 用户已经存在
                res.json({
                    success_code: 200,
                    message: '用户已存在',
                });
            }  else { // 新用户
                const addSql = "INSERT INTO user_info(user_name, user_pwd, user_avatar) VALUES (?, ?, ?)";
                const addSqlParams = [user_name, user_pwd, 'http://localhost:' + config.port + '/avatar_uploads/avatar_default.jpg'];
                conn.query(addSql, addSqlParams, (error, results, fields) => {
                    results = JSON.parse(JSON.stringify(results));
                    if (!error) {
                        req.session.userId = results.insertId;
                        let sqlStr = "SELECT * FROM user_info WHERE id = '" + results.insertId + "' LIMIT 1";
                        conn.query(sqlStr, (error, results, fields) => {
                            if (error) {
                                res.json({err_code: 0, message: '注册失败'});
                            } else {
                                results = JSON.parse(JSON.stringify(results));
                                
                                res.json({
                                    success_code: 200,
                                    message: {
                                        id: results[0].id,
                                        user_name: results[0].user_name || '',
                                        user_nickname: results[0].user_nickname || '',
                                        user_avatar: results[0].user_avatar || ''
                                    }
                                });
                            }
                        });
                    }
                });
            }
        }
    });
});


/**
 * 用户名和密码登录
 */
router.post('/api/login_pwd', (req, res) => {
	// console.log(req.session.captcha);
	// console.log(tmp_captcha);
    // 获取数据
	const user_name = req.body.name;
    const user_pwd = md5(md5(req.body.pwd) + S_KEY);
    const captcha = req.body.captcha.toLowerCase();

    // 验证图形验证码是否正确
    if (captcha !== tmp_captcha) {
        res.json({err_code: 0, message: '图形验证码不正确!'});
        return;
    }

    tmp_captcha = '';
    
    // 查询数据
    let sqlStr = "SELECT * FROM user_info WHERE user_name = '" + user_name + "' LIMIT 1";
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '用户名不正确!'});
        } else {
            results = JSON.parse(JSON.stringify(results));

            if (results[0]) {  // 用户已经存在
                // 验证密码是否正确
                if (results[0].user_pwd !== user_pwd) {
                    res.json({err_code: 0, message: '密码不正确!'});
                } else {
                    req.session.userId = results[0].id;
                    
                    res.json({
                        success_code: 200,
                        message: {
                            id: results[0].id,
                            user_name: results[0].user_name || '',
                            user_nickname: results[0].user_nickname || '',
                            user_phone: results[0].user_phone || '',
							user_sex: results[0].user_sex || '',
							user_address: results[0].user_address || '',
							user_sign: results[0].user_sign || '',
							user_birthday: results[0].user_birthday || '',
                            user_avatar: results[0].user_avatar || ''
                        },
                        info: '登录成功!'
                    });
                }
            } 
        }
    });
});

/**
*  根据session中的用户id获取用户信息
* */
router.get('/api/user_info', (req, res) => {
    // 获取参数
   let userId = req.query.user_id || req.session.userId;
   
    let sqlStr = "SELECT * FROM user_info WHERE id = " + userId + " LIMIT 1";
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '请求用户数据失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            if (!results[0]) {
                delete req.session.userId;
                res.json({error_code: 1, message: '请先登录'});
            } else {
                res.json({
                    success_code: 200,
                    message: {
                        id: results[0].id,
                        user_name: results[0].user_name || '',
                        user_nickname: results[0].user_nickname || '',
                        user_phone: results[0].user_phone || '',
                        user_sex: results[0].user_sex || '',
                        user_address: results[0].user_address || '',
                        user_sign: results[0].user_sign || '',
                        user_birthday: results[0].user_birthday || '',
                        user_avatar: results[0].user_avatar || ''
                    },
                });
            }
        }
    });
});

/**
 * 退出登录
 */
router.get('/api/logout', (req, res) => {
    // 清除session中userId

    delete  req.session.userId;
	
    res.json({
        success_code: 200,
        message: "退出登录成功"
    });
});

/**
 * 添加商品到购物车
 */
router.post('/api/add_shop_cart', (req, res) => {
    // 验证用户
    let user_id = req.body.user_id;
    if(!user_id){
        res.json({err_code:0, message:'非法用户'});
        return;
    }
    /* if(!user_id || user_id !== req.session.userId){
		 console.log( req.session.userId);
         res.json({err_code:0, message:'非法用户'});
         return;
     }
	*/
    // 获取客户端传过来的商品信息
    let goods_id = req.body.goods_id;
    let goods_name = req.body.goods_name;
    let thumb_url = req.body.thumb_url;
    let price = req.body.price;
    let buy_count = req.body.buy_count;
    let is_pay = 0; // 0 未购买 1购买
	let counts = req.body.counts;

    let sql_str = "SELECT * FROM cart WHERE goods_id = " + goods_id + " AND user_id=" + user_id + " and is_pay = 0 LIMIT 1 ";
    conn.query(sql_str, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '服务器内部错误!',error});
        } else {
            results = JSON.parse(JSON.stringify(results));
            if (results[0]) { // 商品已经存在
                res.json({success_code: 200, message: '该商品已在购物车中'});
            } else { // 商品不存在
				let add_sql = "INSERT INTO cart(goods_id, goods_name, thumb_url, price, buy_count, is_pay, user_id, counts) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
				let sql_params = [goods_id, goods_name, thumb_url, price, buy_count, is_pay, user_id, counts];
				conn.query(add_sql, sql_params, (error, results, fields) => {
					if (error) {
                        res.json({err_code: 0, message: '加入购物车失败!'});
                        console.log(error);
					} else {
						res.json({success_code: 200, message: '加入购物车成功!'});
					}
				});
            }
        }
    });

});

/**
 * 查询购物车的商品
 */
router.get('/api/cart_goods', (req, res) => {
    // 获取参数
    let user_id = req.query.user_id;
    let sqlStr = "SELECT * FROM cart WHERE is_pay = 0 and user_id =" + user_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求购物车商品数据失败'});
        } else {
            res.json({success_code: 200, message: results});
        }
    });
});

/**
 * 删除购物车单条商品
 */
router.post('/api/delete_goods', (req, res) => {
    // 获取数据
    const goods_id = req.body.goods_id;
	const user_id = req.body.user_id;
	
    let sqlStr = "DELETE FROM cart WHERE goods_id =" + goods_id + " AND user_id = " + user_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '删除失败!'});
        } else {
            res.json({success_code: 200, message: '删除成功!'});
        }
    });
});
/**
 * 购物车结算商品
 */
 router.post('/api/pay', (req, res) => {
    let sqlStr = `update cart set ? where id in (?)`;
    var payload = {
        is_pay:req.body.state
    }
    if(req.body.state == 2){
        payload.pay_time = dayjs().format("YYYY-MM-DD HH:mm:ss")
        payload.addr_info = req.body.address
    }
    conn.query(sqlStr,[payload,req.body.ids],(error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '结算失败!'});
        } else {
            res.json({success_code: 200, message: '结算成功!'});
        }
    });
});




/*********************************** 用户中心 **************************************** */

/**
 * 修改用户信息 
 */
router.post('/api/change_user_msg', (req, res) => {
    // 获取客户端传过来的商品信息
	const form = new formidable.IncomingForm();
    form.uploadDir = config.uploadsAvatarPath;  // 上传图片放置的文件夹
    form.keepExtensions = true; // 保持文件的原始扩展名
    form.parse(req, (err, fields, files)=>{
        if(err){
            return next(err);
        }
		let id = fields.id;
        let user_nickname = fields.user_nickname || '';
        let user_sex = fields.user_sex || '';
        let user_address = fields.user_address || '';
        let user_birthday = fields.user_birthday || '';
        let user_sign = fields.user_sign || '';
        let user_avatar = 'http://localhost:' + config.port + '/avatar_uploads/avatar_default.jpg';
        if(files.user_avatar){
            user_avatar = 'http://localhost:' + config.port + '/avatar_uploads/' + basename(files.user_avatar.path); 
        }

        // 验证
        if (!id) {
            res.json({err_code: 0, message: '修改用户信息失败!'});
        }

        // 更新数据
        let sqlStr = "UPDATE user_info SET user_nickname = ? , user_sex = ?, user_address = ?, user_birthday = ?, user_sign = ?, user_avatar = ? WHERE id = " + id;
        let strParams = [user_nickname, user_sex, user_address, user_birthday, user_sign, user_avatar];
        conn.query(sqlStr, strParams, (error, results, fields) => {
            if (error) {
                console.log(error);
                res.json({err_code: 0, message: '修改用户信息失败!'});
            } else {
                res.json({success_code: 200, message: '修改用户信息成功!'});
            }
        });
    });
});

/**
 * 修改用户密码
 */
router.post('/api/change_user_pwd', (req, res) => {
    // 获取数据
    let id = req.body.id;
    let oriPwd = '';
    let newPwd = md5(md5(req.body.newPwd) + S_KEY);
    if(req.body.oriPwd){
        oriPwd = md5(md5(req.body.oriPwd) + S_KEY);
    }

    let sqlStr = "SELECT * FROM user_info WHERE id = " + id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '查询失败!'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            if (results[0]) { // 用户存在
                if(!results[0].user_pwd || (results[0].user_pwd && oriPwd === results[0].user_pwd)){
                    let sqlStr = "UPDATE user_info SET user_pwd = ? WHERE id = " + id;
                    conn.query(sqlStr, [newPwd], (error, results, fields) => {
                        if(!error){
                            res.json({success_code: 200, message: '密码修改成功!'});
                        }
                    });
                }else if(oriPwd != results[0].user_pwd){
                    res.json({err_code: 0, message: '输入的原始密码错误!'});
                }
            } else { 
                res.json({err_code: 0, message: '非法用户!'});
            }
        }
    });
});

/**
  修改手机
*/
router.post('/api/change_user_phone', (req, res) => {
    // 获取数据
    const id = req.body.id;
    const phone = req.body.phone;
    const code = req.body.code;

    // 验证验证码是否正确
    if (users[phone] !== code) {
        res.json({err_code: 0, message: '验证码不正确!'});
    }

    // 查询数据
    delete  users[phone];

    let sqlStr = "UPDATE user_info SET user_phone = " + phone + " WHERE id = " + id;

    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
            res.json({err_code: 0, message: '修改失败'});
			console.log(error);
        } else {
            res.json({success_code: 200, message: '修改成功'});
        }
    });

});

/********************************* 后台管理系统 ********************************** */

/**
 * 管理员登录
 */
router.post('/api/admin_login', (req, res)=>{
    const account = req.body.account;
    const pwd = req.body.pwd;
    const md5Pwd = md5(md5(req.body.pwd) + S_KEY);

    if(!account || !pwd){
        res.json({error_code: 0, message: "账号和密码不得为空！"});
    }

    let sqlStr = "SELECT * FROM administrators WHERE account = '" + account + "'";
    conn.query(sqlStr, (error, results, fields) => {
        if(error){
            console.log(error);
            res.json({error_code: 0, message: "服务器内部错误！"});
        }else if(results[0]){
            let user = JSON.parse(JSON.stringify(results[0]));
            console.log('md5Pwd', md5Pwd)
            if(md5Pwd === user['pwd']){
                req.session.adminId = user['id'];
                res.json({success_code: 200, message: "登录成功！"});
            }else{
                res.json({error_code: 0, message: "密码错误！"});
            }
        }else{
            res.json({err_code: 0, message: "用户不存在！"});
        }
    });
});

/**
 * 管理员退出登录
 */
router.get('/api/admin_logout', (req, res) => {
    console.log(req.session.adminId)
    delete  req.session.adminId;
	
    res.json({
        success_code: 200,
        message: "退出登录成功"
    });
});

/**
 * 修改商品数量 
 */
router.post('/api/change_goods_count', (req, res) => {
    // 获取数据
    const goods_id = req.body.goods_id;
    const buy_count = req.body.count;
	const user_id = req.body.user_id;

    let sqlStr = "UPDATE cart SET buy_count = ? WHERE goods_id = " + goods_id + " AND user_id = " + user_id;
    let strParams = [buy_count];
    conn.query(sqlStr, strParams, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '修改商品数量失败!'});
        } else {
            res.json({success_code: 200, message: '修改商品数量成功!'});
        }
    });
});

/**
 * 获取所有用户信息
 */
router.get('/api/admin_allusers', (req, res) => {

    let sqlStr = 'SELECT id, user_name, user_phone, user_nickname, user_address FROM user_info';

    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求用户数据失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});


/**
 * 删除recommend单条商品
 */
router.post('/api/delete_recom_goods', (req, res) => {
    // 获取数据
    const goods_id = req.body.goods_id;
	
    let sqlStr = "DELETE FROM recommend WHERE goods_id =" + goods_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '删除失败!'});
        } else {
			let sqlStr2 = "DELETE FROM cart WHERE goods_id =" + goods_id;
			conn.query(sqlStr, (error, results, fields) => {
				if (error) {
					console.log(error);
					res.json({err_code: 0, message: '删除失败!'});
				} else {
					res.json({success_code: 200, message: '删除成功!'});
				}
			});
        }
    });
});

/**
 * 修改recommend商品信息 
 */
router.post('/api/update_recom_goods', (req, res) => {
    // 获取数据
    const goods_id = req.body.goods_id;
    const goods_name = req.body.goods_name;
    const short_name = req.body.short_name;
    const price = req.body.price;
    const counts = req.body.counts;
    const category = req.body.category;
    const details = req.body.details;
    let sqlStr = "UPDATE recommend SET goods_name = ?, short_name = ?, price = ?, counts = ?, category = ?, details = ? WHERE goods_id = " + goods_id;
    let strParams = [goods_name, short_name, price, counts, category,details];
    conn.query(sqlStr, strParams, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '修改失败!'});
        } else {
            res.json({success_code: 200, message: '修改成功!'});
        }
    });
});

/**
 * 添加商品到recommend
 */
router.post('/api/add_shop_recom', (req, res) => {
    // 获取客户端传过来的商品信息
	const form = new formidable.IncomingForm();
    form.uploadDir = config.uploadsGoodsPath;  // 上传图片放置的文件夹
    form.keepExtensions = true; // 保持文件的原始扩展名
    form.parse(req, (err, fields, files)=>{
        if(err){
            return next(err);
        }
		let goods_id = fields.goods_id;
		let goods_name = fields.goods_name;
		let short_name = fields.short_name;
		let price = fields.price;
		let normal_price = price + 300;
		let market_price = price + 500;
		let sales_tip = fields.sales_tip;
		let category = fields.category;
		let comments_count = 0;
		let counts = fields.counts;
		let thumb_url = 'http://localhost:' + config.port + '/uploads/' + basename(files.goods_img.path);
		let image_url = 'http://localhost:' + config.port + '/uploads/' + basename(files.goods_img.path);
		let hd_thumb_url = 'http://localhost:' + config.port + '/uploads/' + basename(files.goods_img.path);
    
		let sql_str = "SELECT * FROM recommend WHERE goods_id = " + goods_id;
		conn.query(sql_str, (error, results, fields) => {
			if (error) {
				res.json({err_code: 0, message: '服务器内部错误!'});
			} else {
				results = JSON.parse(JSON.stringify(results));
				if (results[0]) { // 商品已经存在
					res.json({success_code: 500, message: '该商品已在数据库中'});
				} else { // 商品不存在
					let add_sql = "INSERT INTO recommend(goods_id, goods_name, short_name, thumb_url, image_url, hd_thumb_url, price, normal_price, market_price, sales_tip, category, counts, comments_count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					let sql_params = [goods_id, goods_name, short_name, thumb_url, image_url, hd_thumb_url, price, normal_price, market_price, sales_tip, category, counts, comments_count];
					conn.query(add_sql, sql_params, (error, results, fields) => {
						if (error) {
							console.log(error);
							res.json({err_code: 0, message: '加入失败!'});
						} else {
							let sqlStr = "UPDATE category SET cate_counts = cate_counts + 1  WHERE cate_id = " + category;
							conn.query(sqlStr, [], (error, results, fields) => {
								if (error) {
									console.log(error);
								} else {
									res.json({success_code: 200, message: '加入成功!'});
								}
							});
						}
					});
				}
			}
		});
	});
});


/**
 * 删除所有商品
 */
router.post('/api/delete_all_goods', (req, res) => {
    // 获取数据
	const user_id = req.body.user_id;
	
    let sqlStr = "DELETE FROM cart WHERE user_id = " + user_id;
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '删除失败!'});
        } else {
            res.json({success_code: 200, message: '删除成功!'});
        }
    });

});




/**
 * 销售统计
 */
 router.get('/api/statistics', (req, res) => {
    // 获取数据
    // let sqlStr = `
    //     SELECT
    //         count(a.cate_id) AS count,
    //         a.cate_name
    //     FROM
    //         category AS a
    //     LEFT JOIN recommend AS b ON a.cate_id = b.category
    //     RIGHT JOIN cart ON b.goods_id = cart.goods_id
    //     WHERE
    //         cart.is_pay = 1
    //     GROUP BY
    //         a.cate_id
    // `;
    let sqlStr = `
        SELECT
            cart.buy_count,
            cart.price,
            cart.pay_time,
            category.cate_name
        FROM
            cart
        LEFT JOIN recommend ON cart.goods_id = recommend.goods_id
        LEFT JOIN category ON recommend.category = category.cate_id
        where cart.is_pay = 1
    `
    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '获取失败!'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            var date = []
            var c = {}
            results.forEach(o=>{
                if(!c[o.cate_name]){
                    c[o.cate_name] = 1
                }
            })
            for(var i = 0;i<7;i++){
                date.push(dayjs().subtract(i,'day').format("YYYY-MM-DD"))
            }
            date = date.reverse()
            var data_res = Object.keys(c).map(o=>{
                return {
                    name: o,
                    type: "line",
                    stack: "Total",
                    data:date.map(d=>{
                        return results.filter(r=>dayjs(r.pay_time).format("YYYY-MM-DD") == d && r.cate_name == o).map(o=>{
                            return o
                        }).reduce((total,curr)=>{
                            return total+curr.buy_count
                        },0)
                    })
                }
            })

            res.json({success_code: 200, message: {date:date,list:data_res,legend:c},});
        }
    });

});

// 获取订单数据
router.get('/api/orders', (req, res) => {

    let sqlStr = `
    SELECT
            cart.*,user_info.user_name
        FROM
            cart
        LEFT JOIN user_info ON cart.user_id = user_info.id

        where cart.is_pay in (1,2) order by cart.pay_time desc
    `;

    conn.query(sqlStr, (error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});

// 获取用户订单数据
router.get('/api/user_orders', (req, res) => {
    let sqlStr = `
    SELECT
            cart.*,user_info.user_name
        FROM
            cart
        LEFT JOIN user_info ON cart.user_id = user_info.id
        where cart.is_pay in (?) and cart.user_id = ? order by cart.pay_time desc
    `;
    conn.query(sqlStr, [req.query.state,req.session.userId],(error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '请求失败'});
        } else {
            results = JSON.parse(JSON.stringify(results));
            res.json({success_code: 200, message: results});
        }
    });
});

router.post('/api/queryOrder',function(req,res,next){
    let out_trade_no = req.body.out_trade_no;
    let trade_no = req.body.trade_no;

    console.log("out_trade_no:"+out_trade_no)
    //对接支付宝
    const formData = new AlipayFormData();
    formData.setMethod('get');
    formData.addField('bizContent', {
        out_trade_no,
        trade_no
        });
    const result =  alipaySdk.exec(
        'alipay.trade.query',
        {},
        { formData: formData },
    );
    result.then(resData => {
        axios({
            url: resData,
            method: "get"
        }).then(data => {
            console.log( "queryOrder:"+data );

            
            let r = data.data.alipay_trade_query_response;
            if (r.code === '10000') {
                switch (r.trade_status) {
                    case 'WAIT_BUYER_PAY':
                        res.send({
                            success: true,
                            code: 200,
                            msg: '支付宝有交易记录，没付款'
                        })
                        break;
                    case 'TRADE_FINISHED':
                        res.send({
                            success: true,
                            code: 200,
                            msg: '支付成功,不可退款'
                        })
                        break;
                    case 'TRADE_SUCCESS':
                        res.send({
                            success: true,
                            code: 200,
                            msg: '支付成功'
                        })
                        break;
                    case 'TRADE_CLOSED':
                        res.send({
                            success: true,
                            code: 200,
                            msg: '交易关闭'
                        })
                        break; 
                }
            } else if (r.code === ' 40004') {
                res.json('交易不存在')
            }


        }).catch(err => {
            res.json({
                msg: '查询失败',
                err
            })
        })
    })

});

//完成支付
router.post('/api/sucessPay',function(req,res,next){
    //前端给后端的数据
    let orderId = req.body.orderId;
    let trade_no = req.body.trade_no;
    let state = req.body.state;
    let address = req.body.address;

    let sqlStr = `update cart set ? where id in (?)`;
    var payload = {
        is_pay:state
    }
    if(state == 2){
        payload.pay_time = dayjs().format("YYYY-MM-DD HH:mm:ss")
        payload.addr_info = address
    }
    //测试
    console.log("完成购物：")
    console.log("orderId="+orderId+"is_pay="+payload.is_pay+","+"pay_time="+payload.pay_time+","+"addr_info="+payload.addr_info)
    
    //执行sql
    conn.query(sqlStr,[payload,orderId],(error, results, fields) => {
        //返回结果
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '结算失败!'});
        } else {
            res.json({success_code: 200, message: '结算成功!'});
        }
    });

});

//支付宝沙箱后台处理
router.post('/api/payment',function(req,res,next){
    //1. 前端给后端的数据
    let orderId = req.body.orderId;
    let money = req.body.moneyFormat;
    let state = req.body.state;
    let address = req.body.address;

    //测试
    // console.log("orderId="+orderId+","+"state="+state+","+"address2="+address)

    //2. 对接支付宝
    const formData = new AlipayFormData();
    // 调用 setMethod 并传入 get，会返回可以跳转到支付页面的 url
    formData.setMethod('get');
    //?orderId='+orderId+'&address='+address+'&
    formData.addField('returnUrl', 'http://localhost:8080/#/shopcar?address='+address+'&state='+state);
    formData.addField('bizContent', {
    outTradeNo: orderId,
    productCode: 'FAST_INSTANT_TRADE_PAY',
    totalAmount: money,
    subject: '商品',
    body: '商品详情',
    });
    //调用支付宝沙箱支付方法
    const result =  alipaySdk.exec(
        'alipay.trade.page.pay',
        {},
        { formData: formData },
      );
    //放回结果
    result.then((resp)=>{
        
        res.send({
            success:'true',
            code:200,
            'result':resp,
        })

    })
});

export default router;


