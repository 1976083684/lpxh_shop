<template>
  <div id="admin-sales">
    <el-table :data="tableData" stripe style="width: 100%" >
      <el-table-column prop="goods_name" label="商品名" width="380">
      </el-table-column>
      <el-table-column prop="thumb_url" label="图片" width="100">
        <template slot-scope="scope">
          <img :src="scope.row.thumb_url" alt="" width="50" />
        </template>
      </el-table-column>
      <el-table-column prop="price" width="60" label="价格"> </el-table-column>
      <el-table-column prop="buy_count" width="60" label="数量">
      </el-table-column>
      <el-table-column prop="user_name" width="100" label="用户名">
      </el-table-column>
     
      <el-table-column prop="addr_info" label="收货信息" width="180" show-overflow-tooltip> </el-table-column>
       <el-table-column prop="is_pay" label="是否完成" width="130">
        <template slot-scope="scope">
          <span v-if="scope.row.is_pay == 1">已完成订单</span>
          <el-button
            size="small"
            type="primary"
            v-if="scope.row.is_pay == 2"
            @click="changeorder_pay(scope.row.id)"
            >完成订单</el-button
          >
        </template>
      </el-table-column>
      <el-table-column prop="pay_time" label="下单时间"> </el-table-column>
      
    </el-table>
  </div>
</template>

<script>
import { get_orders, pay } from "../../../api";
export default {
  data() {
    return {
      tableData: []
    };
  },
  methods: {
    changeorder_pay(id) {
      pay([id], 1).then(() => {
        this.fetchdata();
        this.$message({
          type: "success",
          message: "完成订单成功"
        });
      });
    },
    fetchdata() {
      get_orders().then(res => {
        //处理价格
         res.message.map((item) => {
          console.log(item.price)
          item.price = item.price / 100 + '元';
         });
        this.tableData = res.message;
      });
    }
  },
  created() {
    this.fetchdata();
  }
};
</script>
