<template>
  <div class="pro" @click="goDetail(pro.goods_id)">
    <img v-lazy="pro.thumb_url" class="pro_img" />
    <div class="pro_text">
      <p>
        <em>{{ (pro.price / 100) | moneyFormat }}</em>
      </p>
      <p>{{ pro.short_name }}</p>
    </div>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  props: {
    pro: {
      type: Object,
      required: true,
    },
  },
  methods: {
    goDetail(id) {
      this.$router.replace("/goods/" + id);
    },
  },
};
</script>

<style scoped>
.pro {
  position: relative;
  margin-right: 20px;
  width: 250px;
  height: 100%;
  background: white;
  flex-direction: column;
  display: flex;
  align-items: center;
}
.pro:hover {
  transform: translateY(-3px);
  box-shadow: 1px 1px 20px #999;
}
.pro > .pro_img {
  margin: 20px;
  width: 180px;
  height: 180px;
}
.pro > .pro_text {
  margin-top: 30px;
  height: 130px;
  width: 140px;
  line-height: 25px;
}
.pro_text > p {
  margin-bottom: 10px;
}
.pro_text > p:first-child {
  color: red;
  font-weight: 900;
}
.pro_text > p:nth-child(2) {
  font-size: 13px;
}
.pro_text > p:nth-child(3) {
  font-size: 12px;
  color: #999;
}
</style>
