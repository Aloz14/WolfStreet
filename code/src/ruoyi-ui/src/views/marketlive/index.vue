<template>
    <div>   
      <el-card class="box-card">
        <div slot="header" class="clearfix">
          <span>实时行情</span>
        </div>
        <div v-if="tickerData">
          <p><strong>交易对：</strong>{{ tickerData.instId }}</p>
          <p><strong>最新价格：</strong>{{ tickerData.idxPx }}</p>
          <p><strong>24h最高价：</strong>{{ tickerData.high24h }}</p>
          <p><strong>24h最低价：</strong>{{ tickerData.low24h }}</p>
        </div>
        <div v-else>
          <p>等待数据...</p>
        </div>
      </el-card>
    </div>
  </template>
    
  <script>
  export default {
    name: 'MarketLive',
    data() {
      return {
        tickerData: null,
        kData: null,
        ws: null,
        ws2: null,
      };
    },
    methods: {
      initWebSocket() {
        this.ws = new WebSocket('wss://ws.okx.com:8443/ws/v5/public');
        
        this.ws.addEventListener("open", () => {
          console.log("Connected");
          this.ws.send(JSON.stringify({
            op: "subscribe",
            args: [{
              channel: "index-tickers",
              instId: "BTC-USDT"
            }]
          }));
        });
  
        this.ws.addEventListener("message", (event) => {
          const message = JSON.parse(event.data);
          if (message.arg && message.arg.channel === "index-tickers") {
            this.tickerData = message.data[0];
            // console.log(this.tickerData);
          }
        });
  
        this.ws.addEventListener("close", () => {
          console.log("Disconnected");
        });
        
        this.ws.addEventListener("error", (error) => {
          console.error("WebSocket 错误:", error);
        });
      },

      initWebSocket2() {
        this.ws2 = new WebSocket('wss://ws.okx.com:8443/ws/v5/business');

        this.ws2.addEventListener("open", () => {
          console.log("Connected_2");
          this.ws2.send(JSON.stringify({
            op: "subscribe",
            args: [{
              channel: "index-candle30m",
              instId: "BTC-USD"
            }]
          }));
        });

        this.ws2.addEventListener("message", (event) => {
          const message = JSON.parse(event.data);
          this.kData = message.data[0];
        });

        this.ws2.addEventListener("close", () => {
          console.log("Disconnected_2");
        });
        
        this.ws2.addEventListener("error", (error) => {
          console.error("WebSocket2 错误:", error);
        });
      },
    },
    mounted() {
      this.initWebSocket();
      this.initWebSocket2();
    },
    beforeUnmount() {
      if (this.ws) {
        this.ws.close();
      }
      if (this.ws2) {
        this.ws.close();
      }
    }
  };
  </script>
  
  <style scoped>
  .box-card {
    width: 400px;
    margin: 20px auto;
  }
  </style>
  