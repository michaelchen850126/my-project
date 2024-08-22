<template>
  <div>
    <button @click="submitPayment">送出參數</button>
  </div>
</template>

<script>
import axiosapi from '@/plugins/axios.js'; 
import CryptoJS from "crypto-js"; // 使用 crypto-js

export default {
  data() {
    return {
      merchantID: "3002607",
      hashKey: "pwFHCqoQZGmho4w6",
      hashIV: "EkRm7iFT261dpevs",
      isStage: true,
      totalAmount: "10000", //代入目前購物車金額
      tradeDesc: "測試敘述",
      itemName: "測試名稱", 
      returnURL: "https://www.ecpay.com.tw", //導向測試網址
      choosePayment: "ALL",
      ignorePayment: "Credit#WebATM#CVS#TWQR#BNPL#ATM" // 設定不開放的支付方式
    };
  },
  computed: {
    merchantTradeNo() {
      const date = new Date();
      return `od${date.getFullYear()}${(date.getMonth() + 1)
        .toString()
        .padStart(2, "0")}${date
        .getDate()
        .toString()
        .padStart(2, "0")}${date
        .getHours()
        .toString()
        .padStart(2, "0")}${date
        .getMinutes()
        .toString()
        .padStart(2, "0")}${date
        .getSeconds()
        .toString()
        .padStart(2, "0")}${date
        .getMilliseconds()
        .toString()
        .padStart(3, "0")}`;
    },
    merchantTradeDate() {
      return new Date().toLocaleDateString("zh-TW", {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
        hour: "2-digit",
        minute: "2-digit",
        second: "2-digit",
        hour12: false,
      });
    },
    checkMacValue() {
      return this.generateCheckMacValue();
    },
  },
  methods: {
    generateCheckMacValue() {
      const paramsBeforeCMV = {
        MerchantID: this.merchantID,
        MerchantTradeNo: this.merchantTradeNo,
        MerchantTradeDate: this.merchantTradeDate,
        PaymentType: "aio",
        EncryptType: 1,
        TotalAmount: this.totalAmount,
        TradeDesc: this.tradeDesc,
        ItemName: this.itemName,
        ReturnURL: this.returnURL,
        ChoosePayment: this.choosePayment,
        IgnorePayment: this.ignorePayment,
      };

      const step0 = Object.entries(paramsBeforeCMV)
        .map(([key, value]) => `${key}=${value}`)
        .join("&");

      const step1 = step0
        .split("&")
        .sort((a, b) => a.split("=")[0].localeCompare(b.split("=")[0]))
        .join("&");

      const step2 = `HashKey=${this.hashKey}&${step1}&HashIV=${this.hashIV}`;
      const step3 = this.dotNetUrlEncode(encodeURIComponent(step2));
      const step4 = step3.toLowerCase();
      const step5 = CryptoJS.SHA256(step4).toString().toUpperCase(); // 使用 crypto-js 进行 SHA256 加密

      return step5;
    },
    dotNetUrlEncode(string) {
      const replacements = {
        "%2D": "-",
        "%5F": "_",
        "%2E": ".",
        "%21": "!",
        "%2A": "*",
        "%28": "(",
        "%29": ")",
        "%20": "+",
      };

      return Object.entries(replacements).reduce(
        (acc, [encoded, decoded]) => acc.replace(new RegExp(encoded, "g"), decoded),
        string
      );
    },
    submitPayment() {
      const params = {
        MerchantID: this.merchantID,
        MerchantTradeNo: this.merchantTradeNo,
        MerchantTradeDate: this.merchantTradeDate,
        PaymentType: "aio",
        EncryptType: 1,
        TotalAmount: this.totalAmount,
        TradeDesc: this.tradeDesc,
        ItemName: this.itemName,
        ReturnURL: this.returnURL,
        ChoosePayment: this.choosePayment,
        IgnorePayment: this.ignorePayment,
        CheckMacValue: this.checkMacValue,
      };

      axiosapi2.post("/submitPayment", params)
        .then(response => {
          console.log("Payment Response:", response.data);
        })
        .catch(error => {
          console.error("Error submitting payment:", error);
        });
    }
  }
};
</script>

<style scoped>
button {
  background-color: #007bff;
  color: #fff;
  border: none;
  padding: 10px 20px;
  cursor: pointer;
}

button:hover {
  background-color: #0056b3;
}
</style>
