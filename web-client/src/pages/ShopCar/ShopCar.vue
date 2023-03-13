<template>
  <div id="shopcar">
    <div id="content">
      <div class="header">
        <img src="./../../common/img/logo-round.png" class="header_logo" />
        <span>购物车</span>
      </div>
      <div class="cont_title">
        <span>全部商品</span>
        
      </div>
      <div class="cont_op">
        <div class="con_selet">
          <input
            type="checkbox"
            class="con_selectAll"
            :checked="isSelectedAll"
            @click.stop="selectedAll(isSelectedAll)"
          />
          <label for="con_selectAll">全选</label>
        </div>
        <div>商品信息</div>
        <div>单价</div>
        <div>数量</div>
        <div>金额</div>
        <div>操作</div>
      </div>
      <div class="pro_box" v-if="cartgoods.length">
        <div class="goods" v-for="(goods, index) in cartgoods" :key="index">
          <ul class="item_content">
            <li class="td td-chk">
              <div>
                <input
                  type="checkbox"
                  class="checkBox"
                  :checked="goods.checked"
                  @click="singleSelected(goods)"
                />
              </div>
            </li>
            <li class="td td-item">
              <div class="td-item-pic">
                <img :src="goods.thumb_url" />
              </div>
              <div class="td-item-info">{{ goods.goods_name }}</div>
            </li>
            <li class="td td-price">
              <strong>{{ (goods.price / 100) | moneyFormat }}</strong>
            </li>
            <li class="td td-amount">
              <div class="item-amout">
                <el-input-number
                  v-model="goods.buy_count"
                  :min="1"
                  :max="goods.counts"
                  @change="updateGoodsCount(goods, goods.buy_count)"
                ></el-input-number>
              </div>
            </li>
            <li class="td td-sum">
              <strong>{{
                ((goods.buy_count * goods.price) / 100) | moneyFormat
              }}</strong>
            </li>
            <li class="td td-op"><a @click="clickTrash(goods)">删除</a></li>
          </ul>
        </div>
      </div>
      <div class="pro_box" v-else>购物车里空空如也</div>
    </div>
    <div id="footer">
      <div class="foot_select">
        <input
          type="checkbox"
          class="foot_selectAll"
          name="foot_selectAll"
          :checked="isSelectedAll"
          @click.stop="selectedAll(isSelectedAll)"
        />
        <label for="foot_selectAll">全选</label>
      </div>
      <div class="foot_op">
        <a class="foot_remove" @click.prevent="emptyCart">清空购物车</a>
        <span style="padding:0 20px;font-size:13px">配送到：{{userInfo.user_address}} / {{userInfo.user_phone}} / {{userInfo.user_name}}</span>
      </div>
      <div class="foot_total">
        <div class="amout-sum">
          <span class="txt">已选商品</span>
          <strong id="selected_amout">{{ totalAmount }}</strong>
          <span class="txt">件</span>
        </div>
        <div class="price-sum">
          <span class="txt">合计（不含运费）：</span>
          <strong class="selected_price">{{
            totalPrice | moneyFormat(totalPrice)
          }}</strong>
        </div>

        <div v-if="!userInfo.user_address" class="btn-area" style="color: red;padding: 0 20px;">
          请先到个人信息-完善收货地址再进行结算
        </div>
         <div v-else class="btn-area">
          <a
            class="btn-sumbit"
            :class="{ 'btn-allow': totalAmount }"
            @click="goPayment"
            >结&nbsp;算</a>
        </div>
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
    //支付才会执行
    if (this.$route.query.trade_no!= null) {
      //接收后台传过来的数据
      let address = this.$route.query.address;//收货地址
      let orderId = this.$route.query.out_trade_no;//商品单号
      let trade_no = this.$route.query.trade_no;//商品订单号
      let state = this.$route.query.state;//购物状态
      
    let data = {
       orderId: orderId,
       address: address,
       trade_no: trade_no,
       state: state
      }
      console.log( data );
     //向后台发送请求：添加订单并且清除购物车记录
    axios({
        url:'/api/api/sucessPay',
        method:"post",
        headers:{
          'content-type':'application/x-www-form-urlencoded'
        },
        data:qs.stringify(data)
      }).then(res=>{
        
         console.log( "响应结果="+res.success_code );
         if (res.success_code === 200) {
          //订单完成提示
          
        }
      })

    }


  },
  

  data() {
    return {
      shopsNum: [],
      isSelectedAll: false,
      totalPrice: 0, // 商品总价
      currentDelGoods: {}, // 当前删除的商品
      totalAmount: 0
    };
  },
  computed: {
    ...mapState(["userInfo", "cartgoods"])
  },
  mounted() {
    let user_id = this.userInfo.id;
    // 请求商品数据
    this.$store.dispatch("reqCartsGoods", { user_id });
  },
  methods: {

    //调用支付宝沙箱
    goPayment() {
      let money = this.totalPrice;//总金额
      let ids = this.cartgoods.filter(o => o.checked).map(o => o.id);//商品id
      let address2 = this.userInfo.user_address+" / "+this.userInfo.user_phone+" / "+this.userInfo.user_name//收货地址
      
      // alert(ids)
      
      let data = {
       orderId: ids+"",
       address: address2+"",
       moneyFormat: money,
       state: 2
      }
      //测试打印
      console.log( data );
     //  alert("stop")
     //向后端发送请求，传输数据调用支付宝沙箱支付接口
      axios({
        url:'/api/api/payment',
        method:"post",
        headers:{
          'content-type':'application/x-www-form-urlencoded'
        },
        data:qs.stringify(data)
      }).then(res=>{
         window.location.href=res.data.result;
        console.log( "响应结果1="+res );      
      })

      
    },
    
    submit() {
      let ids = this.cartgoods.filter(o => o.checked).map(o => o.id);
      var address = this.userInfo.user_address+" / "+this.userInfo.user_phone+" / "+this.userInfo.user_name
      pay(ids,2,address).then(result => {
        if (result.success_code === 200) {
          this.$message({
            type: "success",
            message: "结算成功 请等待确认订单"
          });
        }
        setTimeout(() => {
          window.location.reload()
        }, 1000);
      });
      
    },
    // 1.更新单个商品数量
    updateGoodsCount(goods, count) {
      let user_id = this.userInfo.id;
      this.$store.dispatch("updateGoodsCount", { goods, count, user_id });
      this.getAllGoodsPrice();
    },
    // 2.是否选中所有商品
    selectedAll(isSelectedAll) {
      this.isSelectedAll = !isSelectedAll;
      this.$store.dispatch("selectedAll", { isSelectedAll });
      this.getAllGoodsPrice();
      this.hasSelectedAll();
    },
    // 3.计算商品总价
    getAllGoodsPrice() {
      let totalPrice = 0;
      this.cartgoods.forEach((goods, index) => {
        if (goods.checked) {
          totalPrice += (goods.price / 100) * goods.buy_count;
        }
      });
      this.totalPrice = totalPrice;
    },
    // 4.单个商品的选中与否
    singleSelected(goods) {
      this.$store.dispatch("singleSelected", { goods });
      this.hasSelectedAll();
      this.getAllGoodsPrice();
    },
    // 5.判断是否全选
    hasSelectedAll() {
      let flag = true;
      let totalNum = 0;
      this.cartgoods.forEach((goods, index) => {
        if (!goods.checked) {
          flag = false;
        } else {
          totalNum += 1;
        }
      });
      this.totalAmount = totalNum;
      this.isSelectedAll = flag;
    },
    // 6.删除单个商品
    clickTrash(goods) {
      this.$confirm("您确定删除该商品吗？", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          let user_id = this.userInfo.id;
          this.currentDelGoods = goods;
          this.$store.dispatch("delSingleGoods", { goods, user_id });
          this.getAllGoodsPrice();
          window.location.reload();
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    },
    // 7.删除所有商品
    emptyCart() {
      this.$confirm("您确定删除所有商品吗？", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      })
        .then(() => {
          let user_id = this.userInfo.id;
          this.$store.dispatch("delAllGoods", { user_id });
          this.getAllGoodsPrice();
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除"
          });
        });
    }
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
