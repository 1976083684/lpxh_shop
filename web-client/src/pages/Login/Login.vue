<template>
  <div class="login-container">
    <!--登录面板内容部分-->
    <div class="login-inner">
      <!--面板头部-->
      <div class="login-header">
        <div class="login-logo">
          <img src="./images/logo-round.png" alt="" width="150" />
        </div>
        <!--面板标题-->
        <div class="login-header-title">
          <a
            href="javascript:;"
            :class="{ current: mode }"
            @click="dealLoginMode(true)"
            >用户注册</a
          >
          <a
            href="javascript:;"
            :class="{ current: !mode }"
            @click="dealLoginMode(false)"
            >密码登录</a
          >
        </div>
      </div>
      <!--面板表单部分-->
      <div class="login-content">
        <form>
          <!--用户注册-->
          <div :class="{ current: mode }">
            <section class="login-message">
              <input placeholder="用户名" v-model="newUserName" />
            </section>
            <section class="login-verification">
              <input placeholder="密码" v-model="newPwd" />
            </section>
            <button class="login-submit" @click.prevent="register()">
              注册
            </button>
          </div>
          <!--账号登录部分-->
          <div :class="{ current: !mode }">
            <section>
              <section class="login-message">
                <input
                  type="text"
                  maxlength="11"
                  placeholder="账号"
                  v-model="user_name"
                />
              </section>
              <section class="login-verification">
                <input
                  type="password"
                  maxlength="18"
                  placeholder="密码"
                  v-if="pwdMode"
                  v-model="pwd"
                />
                <input
                  type="text"
                  maxlength="18"
                  placeholder="密码"
                  v-else
                  v-model="pwd"
                />
                <div class="switch-show">
                  <img
                    @click.prevent="dealPwdMode(false)"
                    :class="{ on: pwdMode }"
                    src="./images/hide_pwd.png"
                    alt=""
                    width="20"
                  />
                  <img
                    @click.prevent="dealPwdMode(true)"
                    :class="{ on: !pwdMode }"
                    src="./images/show_pwd.png"
                    alt=""
                    width="20"
                  />
                </div>
              </section>
              <section class="login-message">
                <input
                  type="text"
                  maxlength="11"
                  placeholder="验证码"
                  v-model="captcha"
                />
                <img
                  ref="captcha"
                  class="get-verification"
                  src="/api/api/captcha"
                  alt="captcha"
                  @click.prevent="getCaptcha()"
                />
              </section>
              <!-- <section class="login-hint">
                温馨提示：未注册帐号的用户账号，登录时将自动注册，且代表已同意
                <a href="javascript:;">服务协议与隐私政策</a>
              </section> -->
            </section>
            <button class="login-submit" @click.prevent="login()">登录</button>
          </div>
        </form>
        <button class="login-back" @click="$router.back()">返回</button>
      </div>
    </div>
  </div>
</template>

<script>
import {
  getPhoneCode,
  phoneCodeLogin,
  pwdLogin,
  register,
} from "./../../api/index";
import { MessageBox } from "element-ui";
import { mapActions } from "vuex";

export default {
  name: "Login",
  data() {
    return {
      mode: false, // 方式, true 注册 false 账号登录
      newUserName: "", // 注册用户名
      newPwd: "", // 注册密码
      pwdMode: true, // 密码的显示方式 true 密文 false 明文
      pwd: "", // 密码
      userInfo: {}, // 用户的信息
      user_name: "", // 用户名
      captcha: "", // 图形验证码
    };
  },
  created() {

    if(this.$route.params.mode == 'register') { // 为注册
    
      this.mode = true
    } 
  },
  methods: {
    ...mapActions(["syncUserInfo"]),
    // 1. 模式 登录还是注册
    dealLoginMode(flag) {
      this.mode = flag;
    },
    // 2. 注册
    async register() {
      // 账号和密码登录
      // 前端校验
      if (!this.newUserName) {
        MessageBox({
          type: "info",
          message: "请输入用户名!",
          showClose: true,
        });
        return;
      } else if (!this.newPwd) {
        MessageBox({
          type: "info",
          message: "请输入密码!",
          showClose: true,
        });
        return;
      }
      const result = await register(this.newUserName, this.newPwd);
      
      if (result.success_code === 200) {
        MessageBox({
          type: "success",
          message: "注册成功!",
          showClose: true,
        });
        this.mode = !this.mode; // 切换为登录
      } else {
        MessageBox({
          type: "info",
          message: result.message,
          showClose: true,
        });
      }
    },
    // 3. 密码的显示方式
    dealPwdMode(flag) {
      this.pwdMode = flag;
    },
    // 4. 获取图形验证码
    getCaptcha() {
      this.$refs.captcha.src =
        "/api/api/captcha?time=" + new Date();
    },
    // 5. 登录
    async login() {
      // 账号和密码登录
      // 5.4 前端校验
      if (!this.user_name) {
        MessageBox({
          type: "info",
          message: "请输入账号!",
          showClose: true,
        });
        return;
      } else if (!this.pwd) {
        MessageBox({
          type: "info",
          message: "请输入密码!",
          showClose: true,
        });
        return;
      } else if (!this.captcha) {
        MessageBox({
          type: "info",
          message: "请输入验证码!",
          showClose: true,
        });
        return;
      }
      // 5.5 用户名和密码的登录
      const result = await pwdLogin(this.user_name, this.pwd, this.captcha);

      if (result.success_code === 200) {
        this.userInfo = result.message;
        clearInterval(this.intervalId);
        this.code = ""; // 验证码
        this.pwd = ""; // 密码
        this.user_name = ""; // 账号
        this.captcha = ""; // 图形验证码
      } else {
        this.userInfo = {
          message: result.message,
        };
      }
      // 6. 后续处理
      if (!this.userInfo.id) {
        // 失败
        MessageBox({
          type: "info",
          message: this.userInfo.message,
          showClose: true,
        });
      } else {
        // 成功
        // 6.1 同步用户数据
        this.syncUserInfo(this.userInfo);
        // 6.2 回到主界面
        MessageBox({
          type: "success",
          message: "登录成功!",
          showClose: true,
        });
        this.$router.back();
        window.localStorage.setItem("userInfo", JSON.stringify(this.userInfo));
        window.localStorage.removeItem("adminInfo");
      }
    },
  },
};
</script>

<style scoped lang="stylus" rel="stylesheet/stylus">
@import '../../common/stylus/mixins.styl';

.login-container {
  width: 100%;
  height: 100%;
  background: #fff;

  .login-inner {
    padding-top: 60px;
    width: 25%;
    margin: 0 auto;

    .login-header {
      .login-logo {
        font-size: 20px;
        font-weight: bold;
        color: mediumpurple;
        text-align: center;
      }

      .login-header-title {
        padding-top: 40px;
        padding-bottom: 10px;
        text-align: center;

        > a {
          color: #333;
          font-size: 14px;
          padding-bottom: 4px;

          &:first-child {
            margin-right: 40px;
          }

          &.current {
            color: mediumpurple;
            font-weight: 700;
            border-bottom: 2px solid mediumpurple;
          }
        }
      }
    }

    .login-content {
      > form {
        > div {
          display: none;

          &.current {
            display: block;
          }

          input {
            width: 100%;
            height: 100%;
            padding-left: 8px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 4px;
            outline: 0;
            font: 400 14px Arial;

            &:focus {
              border: 1px solid mediumpurple;
            }
          }

          .login-message {
            position: relative;
            margin-top: 16px;
            height: 48px;
            font-size: 14px;
            background: #fff;

            .get-verification {
              position: absolute;
              top: 50%;
              right: 10px;
              transform: translateY(-50%);
              border: 0;
              color: #ccc;
              font-size: 14px;
              background: transparent;

              &.phone_right {
                color: purple;
              }
            }
          }

          .login-verification {
            position: relative;
            margin-top: 16px;
            height: 48px;
            font-size: 14px;
            background: #fff;

            .switch-show {
              position: absolute;
              right: 10px;
              top: 12px;

              img {
                display: none;
              }

              img.on {
                display: block;
              }
            }
          }

          .login-hint {
            margin-top: 12px;
            color: #999;
            font-size: 12px;
            line-height: 20px;

            > a {
              color: mediumpurple;
            }
          }
        }

        .login-submit {
          display: block;
          width: 100%;
          height: 42px;
          margin-top: 30px;
          border-radius: 4px;
          background: mediumpurple;
          color: #fff;
          text-align: center;
          font-size: 16px;
          line-height: 42px;
          border: 0;
        }
      }

      .login-back {
        display: block;
        width: 100%;
        height: 42px;
        margin-top: 15px;
        border-radius: 4px;
        background: transparent;
        border: 1px solid mediumpurple;
        color: mediumpurple;
        text-align: center;
        font-size: 16px;
        line-height: 42px;
      }
    }
  }
}
</style>
