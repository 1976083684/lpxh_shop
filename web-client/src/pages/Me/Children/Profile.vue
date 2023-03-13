<template>
  <div class="user-detail">
    <div class="user-detail-top">基本信息</div>
    <div class="user-detail-group">
      <div class="user-icon">
        <span>头像</span>
        <img :src="userInfo.user_avatar" alt="">
      </div>
      <div class="user-item">
        <span>手机</span>
        <span>{{ userInfo.user_phone || '暂无' }}</span>
      </div>
      <div class="user-item">
        <span>账号</span>
        <span>{{ userInfo.user_name || '暂无' }}</span>
      </div>
      <div class="user-item">
        <span>昵称</span>
        <span>{{ userInfo.user_nickname || '暂无' }}</span>
      </div>
      <div class="user-item">
        <span>性别</span>
        <span>{{ userInfo.user_sex || '暂无' }}</span>
      </div>
      <div class="user-item">
        <span>收货地址</span>
        <span>{{ userInfo.user_address || '暂无' }}</span>
      </div>
      <div class="user-item">
        <span>生日</span>
        <span>{{ userInfo.user_birthday || '暂无' }}</span>
      </div>
      <div class="user-item">
        <span>个性签名</span>
        <span>{{ userInfo.user_sign || '暂无' }}</span>
      </div>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {mapActions} from 'vuex'

  export default {
    data() {
      return {
      }
    },
    computed: {
      //通过mapState自动将需要的state值映射为实例的计算属性，同时使用展开运算符将映射的计算属性追加上去，而不是覆盖原有的
        ...mapState(["userInfo"])
    },
  }
</script>

<style scoped lang="stylus" ref="stylesheet/stylus">
  .user-detail
    width 70%
    height 100%
    margin 20px auto
    .user-detail-top
      width 100%
      height 60px
      line-height 60px
      padding-left 10px
      font-weight bold
    .user-detail-group
      .user-icon
        height 60px
        padding 0 10px
        background-color #fff
        border-bottom: 1px solid #e0e0e0
        display flex
        justify-content space-between
        align-items center
        img
          width 50px
          height 50px
          border-radius 50%
      .user-item
        height 50px
        padding 0 10px
        background-color #fff
        border-bottom: 1px solid #e0e0e0
        display flex
        justify-content space-between
        align-items center
    .right-title-color
      color #999
      font-size 14px
</style>

