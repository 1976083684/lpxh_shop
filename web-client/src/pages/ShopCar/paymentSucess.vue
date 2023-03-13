<template>
  <div id="paymentSucess">
    <div id="content">
      <div class="header">
        <img src="./../../common/img/支付-支付宝.png" class="header_logo" />
        <span>支付结果页面</span>
      </div>
      <div class="cont_title">
        <span>支付成功？</span>
        <div class="header"><img src="./../../common/img/支付成功.png" class="header_logo" /></div>
      </div>
    </div> 
  </div>
</template>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
import { mapState } from "vuex";
import { mapActions } from "vuex";
import { MessageBox } from "element-ui";
import { pay } from "./../../api/index";
import qs  from 'qs';
import  axios  from "axios";
export default {
  created(){
    let data = {
      out_trade_no:this.$route.query.out_trade_no,
      trade_no:this.$route.query.trade_no
    }

    alert(data.out_trade_no)
    console.log("created():"+qs.stringify(data));
    axios({
        url:'/api/api/queryOrder',
        method:"post",
        headers:{
          'content-type':'application/x-www-form-urlencoded'
        },
        data:qs.stringify(data)
      }).then(res=>{
        console.log( "结果：");
        console.log( res );

        let sqlStr = `update cart set ? where id in (?)`;

        conn.query(sqlStr,[data.out_trade_no],(error, results, fields) => {
        if (error) {
			console.log(error);
            res.json({err_code: 0, message: '结算失败!'});
        } else {
            res.json({success_code: 200, message: '结算成功!'});
        }
    });

      })
  }
  
};
</script>

<style scoped>
#content > .header {
  width: 100%;
  height: 90px;
  margin-top: 10px;
  position: relative;
}
.header > img {
  width: 80px;
  height: 80px;
  border: 1px solid gray;
  border-radius: 50%;
  cursor: pointer;
}
.header > span {
  display: inline-block;
  font-size: 25px;
  height: 35px;
  font-weight: 700;
  position: absolute;
  top: 30%;
  margin-left: 20px;
  cursor: pointer;
}
#content > .cont_title {
  margin: 10px auto;
  width: 80%;
  height: 35px;
  border-bottom: 2px solid #e6e6e6;
}
.cont_title > span {
  display: inline-block;
  font-weight: 700;
  font-size: 17px;
  height: 100%;
  width: 100px;
  text-align: center;
  line-height: 25px;
  cursor: pointer;
  color: #f40;
  border-bottom: 2px solid #f40;
}
#content > .cont_op {
  width: 80%;
  margin: 0 auto;
  height: 40px;
  display: flex;
  justify-content: space-around;
}
.cont_op > div {
  line-height: 40px;
}
.cont_op > div:nth-child(2) {
  width: 120px;
}
#content > .pro_box {
  margin: 0 auto;
  width: 80%;
  padding-bottom: 60px;
}
.pro_box > .goods {
  background: #fcfcfc;
  width: 100%;
  height: 130px;
  border: 1px solid #cccccc;
}
.goods > .item_content {
  padding: 15px;
  list-style: none;

  display: flex;
  justify-content: space-around;
}
.item_content > .td-item {
  width: 180px;
  position: relative;
}
.td-item > div {
  display: inline-block;
}
.td-item > .td-item-pic > img {
  width: 80px;
  height: 80px;
}
.td-item > .td-item-info {
  position: absolute;
  width: 80px;
  line-height: 15px;
  font-size: 12px;
  top: 0;
  margin-left: 20px;
}
.item_content > .td-sum {
  color: #f40;
}
.td-amount > .item-amout {
  height: 25px;
}
.item-amout a {
  display: inline-block;
  height: 23px;
  width: 17px;
  border: 1px solid #e5e5e5;
  background: #f0f0f0;
  text-align: center;
  line-height: 23px;
  color: #444;
  cursor: pointer;
}
.item-amout a:hover {
  color: #f50;
  border-color: #f60;
}
.item-amout > .text_amount {
  width: 40px;
  height: 20px;
  text-align: center;
  display: inline-block;
}
.td-op a {
  color: black;
}
.td-op a:hover {
  cursor: pointer;
  color: #f40;
}
#footer {
  width: 80%;
  height: 50px;
  position: fixed;
  bottom: 0;
  left: 10%;
  background: #e5e5e5;
  z-index: 9999;
}
#footer div {
  display: inline-block;
}
#footer > .foot_select {
  width: 50px;
  height: 50px;
  line-height: 50px;
  padding-left: 5px;
  cursor: pointer;
  font-size: 14px;
}
.foot_select input,
.foot_select label {
  cursor: pointer;
}
.foot_op {
  line-height: 50px;
  height: 50px;
}
.foot_op > .foot_remove {
  margin-left: 25px;
  font-size: 14px;
  cursor: pointer;
}
.foot_remove:hover {
  color: #f40;
}
.foot_total {
  float: right;
}
.foot_total > .amout-sum {
  cursor: pointer;
  height: 50px;
  color: #3c3c3c;
}
.foot_total .txt {
  line-height: 50px;
  font-size: 14px;
}
.amout-sum > #selected_amout {
  padding: 0 5px;
  color: #f40;
  font-weight: 700;
  font-size: 18px;
}
.price-sum {
  margin-left: 50px;
}
.price-sum > .selected_price {
  color: #f40;
  font-weight: 700;
  font-size: 20px;
  line-height: 50px;
}
.btn-area > .btn-sumbit {
  display: inline-block;
  background: #b0b0b0;
  color: #fff;
  border-left: 1px solid #e7e7e7;
  width: 119px;
  height: 50px;
  cursor: not-allowed;
  text-align: center;
  line-height: 50px;
  font-size: 20px;
}
.btn-area > .btn-sumbit.btn-allow {
  background: #f22d00;
  cursor: pointer;
}
</style>
