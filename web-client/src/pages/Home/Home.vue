<template>
  <div id="home">
    <div id="container" v-if="categoryList[0]">
      <ul class="tab">
        <li @mouseenter="handleIn(-1)" @mouseout="handleOut(-1)" class="tab_item" :class="current === 0?'active': ''">首页</li>
        <li @mouseenter="handleIn(index)" @click.prevent="getRList(item.cate_id)" v-for="(item, index) in categoryList" :key="item.cate_name" class="tab_item" :class="current === (index+1) ?'active': ''"> {{item.cate_name}}</li>
      </ul>
      <div @mouseout="handleOut(-11)" class="shop" v-if="isShow" >
        <div @click="goDetail(item.goods_id)" class="shop_item" v-for="(item,index) in homeshoplist[categoryList[current-1].cate_id - 1].slice(0,6)" :key="index" >
          <img :src="item.thumb_url" class="tab_img"  width="165px" height="180px"/>
          <div class="dec">{{item.short_name}} </div>
          <em class="money">¥{{item.price / 100}}</em>
        </div>
      </div> 
      <div class="carousel">
        <el-carousel height="400px" v-if="homecasual.length > 0">
          <!--遍历从请求到的数组--> 
          <el-carousel-item v-for="casual in homecasual" :key="casual.id">
            <img :src="casual.imgurl" alt="" />
          </el-carousel-item>
        </el-carousel>
      </div>
      <!-- 分类产品展示区域 -->
      <!-- 分类一 -->
      <div class="product">
        <div class="pro_line">
          <h3>{{ categoryList[0].cate_name }}</h3>
          <div><a @click.prevent="getRList(categoryList[0].cate_id)">MORE</a></div>
        </div>
		<div class="pro_show">
          <ProductItem
            v-for="pro in homeshoplist[categoryList[0].cate_id - 1]"
            :key="pro.goods_id"
            :pro="pro"
          />
        </div>
      </div>
		<!-- 分类二 -->
      <div class="pro_show">
        <div class="pro_line">
          <h3>{{ categoryList[1].cate_name }}</h3>
          <div><a @click.prevent="getRList(categoryList[1].cate_id)">MORE</a></div>
        </div>
        <div class="cate">
          <HomeItem
            v-for="pro in homeshoplist[categoryList[1].cate_id - 1]"
            :key="pro.goods_id"
            :pro="pro"
          />
        </div>
      </div>
	  		<!-- 分类二 -->
        <div class="pro_line">
          <h3>{{ categoryList[2].cate_name }}</h3>
          <div><a @click.prevent="getRList(categoryList[2].cate_id)">MORE</a></div>
        </div>
        <div class="cate">
          <HomeItem
            v-for="pro in homeshoplist[categoryList[2].cate_id - 1]"
            :key="pro.goods_id"
            :pro="pro"
          />
      </div>
	  		<!-- 分类二 -->
      <div>
        <div class="pro_line">
          <h3>{{ categoryList[3].cate_name }}</h3>
          <div><a @click.prevent="getRList(categoryList[3].cate_id)">MORE</a></div>
        </div>
        <div class="cate">
          <HomeItem
            v-for="pro in homeshoplist[categoryList[3].cate_id - 1]"
            :key="pro.goods_id"
            :pro="pro"
          />
        </div>
      </div>
	  	  		<!-- 分类二 -->
      <div>
        <div class="pro_line">
          <h3>{{ categoryList[4].cate_name }}</h3>
          <div><a @click.prevent="getRList(categoryList[4].cate_id)">MORE</a></div>
        </div>
        <div class="cate">
          <HomeItem
            v-for="pro in homeshoplist[categoryList[4].cate_id - 1]"
            :key="pro.goods_id"
            :pro="pro"
          />
        </div>
      </div>
    </div>
    <div class="end_show"></div>

    <!-- 尾部 -->
    <div id="footer">
      <img src="./img/footer.png" />
      <div class="footer_text"></div>
    </div>

    <!--左侧微型购物车区域-->
    <DrawerSection
      v-if="this.$route.path.indexOf('/home') != -1"
      @goShopCar="goShopCar"
    />
  </div>
</template>

<script>
//1：引入vuex中从服务器端发送过来的数据，也就是state.js中的数据
import { mapState } from "vuex";

import DrawerSection from "./children/DrawerSection/DrawerSection";
import ProductItem from "../../components/ProductItem/ProductItem";
import HomeItem from "../../components/ProductItem/HomeItem";
import { MessageBox } from "element-ui";

export default {
  //计算属性
  computed: {
    ...mapState(["homecasual", "categoryList", "homeshoplist", "userInfo"]),
  },
  data() {
    return{
      current: 0,
      isShow: false
    }
  },
  components: {
    DrawerSection,
	ProductItem,
	HomeItem,
  },
  methods: {
    getRList(cate_id) {
      this.$router.replace("/search/" + cate_id + "/1");
    },
    goDetail(id){
        this.$router.replace('/goods/' + id);
      },
    goShopCar() {
      if (this.userInfo.id) {
        this.$router.replace("/shopcar");
      } else {
        MessageBox({
          type: "info",
          message: "请先登录!",
          showClose: true,
        });
      }
    },
    handleIn(index) {
      this.current = index+1
      if(index!=-1) {
        this.isShow = true
      }
    },
    handleOut() {
      this.isShow = false
      this.current = 0
    }
  },
  //生命周期函数，组件创建后调用
  mounted() {
    // 请求轮播图数据
    this.$store.dispatch("reqHomeCasual");
    // 请求分类数据
    this.$store.dispatch("reqCategory");
    // 请求商品数据
    if (this.userInfo && this.userInfo.id) {
      let user_id = this.userInfo.id;
      this.$store.dispatch("reqCartsGoods", { user_id });
    }
  },
  watch: {
    categoryList() {
      //$nextTick()将回调延迟到下次 DOM 更新循环之后执行。在修改数据之后立即使用它，然后等待 DOM 更新。
      this.$nextTick(() => {
        // 请求首页商品数据
        this.$store.dispatch("reqHomeShopList");
      });
    },
  },
};
</script>

<style scoped>
#home {
  font-family: "Microsoft YaHei";
}
/*产品展示、购买、分类简介区*/
#container {
  position: relative;
  margin: 60px auto;
  width: 100%;
  background: rgba(245, 245, 245, 0.5);
}
ul li{
list-style: none;
}
.tab {
  display: flex;
  justify-content: space-around;
  padding: 0 35px;
  line-height: 40px;
}
.tab_item:hover {
  color: red;
}
.shop {
  display: flex;
  padding: 0 35px;
  background-color: white;
  width: 100%;
  justify-content: space-around;
}

.shop_item {
  text-align: center;
}
.shop_item:hover {
  color: red;
}
.shop_item + .shop_item {
  margin-left: 10px;
}
.dec {
  margin: 10px auto 2px;
  width: 10em;
  overflow:hidden;
	text-overflow:ellipsis;
	white-space:nowrap;
  text-align: center;
}
.money {
  color: red;
  font-weight: bold;
  text-align: center;
}
.active {
  font-weight: bold;
  font-size: 20px;
  border-bottom: 2px solid red;
}
#container .el-row .el-col {
  height: 400px;
}
.carousel {
	padding: 0 35px;
}
.el-row .cateList .cate_img {
  width: 100%;
  text-indent: 14px;
  height: 60px;
  color: white;
  line-height: 40px;
  font-size: 16px;
  background: #f10215;
}
.cate {
	padding: 0 35px;
	display: flex;
}
/*自动播放图片区域*/
.el-col .el-carousel {
  height: 100%;
  border-top: 2px solid #ff0036;
}
.el-carousel .el-carousel__item img {
	height: 400px;
  width: 100%;
}
/*一级菜单*/

/*展示登录信息区域*/
#container .el-row .con_log.el-col {
  background: white;
  text-align: center;
  font-size: 15px;
  color: #989898;
  border: 1px solid #ccc;
  height: 320px;
}
.con_log > div {
  margin-top: -30px;
  margin-left: 75px;
  margin-bottom: 60px;
  width: 70px;
  height: 70px;
}
.con_log > div > img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  box-shadow: 3px 3px 5px 5px #e3e3e3;
}
.con_log > p {
  margin-bottom: 20px;
}
.con_log > p > a {
  font-size: 13px;
  margin-right: 10px;
  margin-bottom: 5px;
  color: #666;
  cursor: pointer;
  text-decoration: none;
}
.con_log > .userIn > a {
  display: block;
}
.con_log > p > a:hover {
  color: red;
  font-weight: 700;
}
.con_log > button {
  margin-right: 5px;
  width: 70px;
  height: 25px;
  line-height: 25px;
  font-size: 12px;
  text-align: center;
  border-radius: 13px;
  box-shadow: 6px 8px 20px rgba(45, 45, 45, 0.15);
  transition: background 0.3s ease, color 0.3s ease;
  outline: none;
  border: none;
}
.con_log > button.welfare {
  color: #e43f3b;
  background: white;
}
.con_log > button.vip {
  color: #e5d790;
  background: #2d2d2a;
}
.con_log > button:hover {
  color: white;
  background: #e43f3b;
}
/*每类产品的简单展示*/
#container > .product {
  margin-top: 50px;
  width: 100%;
  height: 300px;
}
.pro_line {
  width: 100%;
  height: 50px;
  margin: 0 35px;
  line-height: 50px;
  font-size: 26px;
  font-family: sans-serif;
  font-weight: normal;
  color: #222;
  margin-bottom: 20px;
}
.pro_line > h3 {
  display: inline-block;
}
.pro_line > div {
  display: inline-block;
  margin-left: 15px;
  cursor: pointer;
}
.pro_line > div > a {
  color: red;
  font-weight: 700;
  font-size: 17px;
  text-decoration: none;
  transition: 0.5s;
}
.pro_line > div > a:after {
  content: "»";
  opacity: 0; /*opacity属性不占用文档流的空间*/
  transition: 0.5s;
}
.pro_line > div:hover a:after {
  opacity: 1;
}
.product > .pro_show {
  padding-left: 35px;
  width: 980px;
  height: 205px;
  display:flex;
}
.pro_1 {
  width: 100%;
  text-align: center;
  margin-top: 300px;
}
.pro_1 > .item_content {
  width: 100%;
  text-align: center;
}
#footer > img {
  display: block;
  margin: 0 auto;

}
#footer > .footer_text {
  width: 100%;
  border-top: 1px solid #dedede;
}
</style>
