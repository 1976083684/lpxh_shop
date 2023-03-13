// 暂时不用
import config from '../src/config'

const sqlConfig = {
    host: config.host, // 数据库的地址
    user: config.user, // 账号
    password: config.password, // 密码
    database: config.database, // 数据库名称
    multipleStatements: true,  // 允许多条sql同时查询
}
// let conn = mysql.createConnection(sqlConfig);
// conn.connect();

// export default conn;
 export default sqlConfig;