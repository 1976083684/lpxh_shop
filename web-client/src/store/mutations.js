//Vuex的store的状态管理的所有方法所在的文件
import Vue from 'vue'
import {
  HOME_CASUAL,
  CATEGORY_LIST,
  HOME_SHOP_LIST,
  RECOMMEND_SHOP_LIST,
  GOODS_DETAIL,
  GOODS_COMMENT,
  USER_INFO,
  RESET_USER_INFO,
  CART_GOODS_LIST,
  CHANGE_GOODS_COUNT,
  SELECTED_ALL_GOODS,
  SELECTED_SINGLE_GOODS,
  DEL_SINGLE_GOODS,
  DEL_ALL_GOODS,
  SEARCH_KEYWORDS
} from './mutation-types'

export default {
  //首页轮播图
  [HOME_CASUAL](state, {homecasual}) {
     //将服务器请求过来的 homecasual 赋值给state中自定义的数组 homecasual
    state.homecasual = homecasual;
  },

  [CATEGORY_LIST](state,{categoryList}){
    // 分类数组
	  state.categoryList = categoryList;
  },

  [HOME_SHOP_LIST](state, {homeshoplist}) {
    // 首页的商品列表
    state.homeshoplist = state.homeshoplist.concat(homeshoplist);
  },

  [RECOMMEND_SHOP_LIST](state, {recommendshoplist}) {
    // 推荐的商品列表
    state.recommendshoplist = recommendshoplist;
  },

  [GOODS_DETAIL](state, {goodsDetail}) {
    // 商品详细信息
    state.goodsDetail = goodsDetail;
  },

  [GOODS_COMMENT](state, {goodsComment}) {
    // 商品评论
    state.goodsComment = goodsComment;
  },

  [USER_INFO](state, {userInfo}) {
    // 用户数据
    state.userInfo = userInfo;
  },

  [RESET_USER_INFO](state) {
    state.userInfo = {};
  },

  [CART_GOODS_LIST](state, {cartgoods}) {
    state.cartgoods = cartgoods;
  },

  [CHANGE_GOODS_COUNT](state, {goods,count}) {
    const index = state.cartgoods.indexOf(goods);
    state.cartgoods[index].buy_count = count;
  },

  [SELECTED_ALL_GOODS](state, {isSelectedAll}){
    state.cartgoods.forEach((goods)=>{
      if(goods.checked){
        // 该属性存在
        goods.checked = !isSelectedAll;
      }else{
        Vue.set(goods, 'checked', !isSelectedAll);
      }
    });
  },

  [SELECTED_SINGLE_GOODS](state, {goods}){
    const index = state.cartgoods.indexOf(goods);
    if(!goods.checked){
      //Vue.set(goods, 'checked', true);
      state.cartgoods[index].checked = true;
    }else{
      state.cartgoods[index].checked = !state.cartgoods[index].checked;
    }
  },

  [DEL_SINGLE_GOODS](state, {goods}){
    goods.buy_count = 0;
    const index = state.cartgoods.indexOf(goods);
    state.cartgoods.splice(index, 1);
  },

  [DEL_ALL_GOODS](state){
    state.cartgoods = [];
  },

  [SEARCH_KEYWORDS](state, {searchresults}) {
    // 搜索结果
    state.searchresults = searchresults;
  },

}
