// alipay.js 这里单独存放一个文件中，需要时引入即可
const AlipaySdk = require('alipay-sdk').default; // 引入 SDK
const alipaySdk = new AlipaySdk({
    appId: '2021000121661858', // 开放平台上创建应用时生成的 appId
    signType: 'RSA2', // 签名算法,默认 RSA2
    gateway: 'https://openapi.alipaydev.com/gateway.do', // 支付宝网关地址 ，沙箱环境下使用时需要修改
    alipayPublicKey: 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjo28uXaF0VcBT27QQbVM7tVsg1+clFFd5Ssevl3QL+mvn0WHNzqDTsZVr0bq9ncbN7Su2sVbSA/4t5Z0MyoKTIwlQe943M4R4G4V/cd996/q2+8n/SjqQAY7x+uOC6UadTDXRwTxIJkaradsBSCdMtB0wbU8oDeIIk7zgEUZDYcUk/mGoVPThLFQc9/8At7NIPIFdZO51ja3W0dmUFtp5tIngFF1irblMzUAU8Ibrtr/4Nn48Pf15LCQX26ml7dQEOSZjJwIwSZq0d3+3+NjsSoTQvAJH30c+WX6Oy/fj878yGwPf8DWmjGTXNXWlDD2Efv8JHYYZ7fGdB3a9RatJwIDAQAB', // 支付宝公钥，需要对结果验签时候必填
    privateKey: 'MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCUWl3jhAFQf+XtWkQGKIPHLkDt5FWa+a0s5CWQATI+BsWDpwD9ZLBpqUtTnuzuZLHcSbLdF3G1C9TVYChR96Evj+RqVah0lW896BAe4etPh6a9cr9eU9hIC7TCLL9Cvet2ZgCbPwc6Qgy6G/wRHmkmF8HU6zcOL0mrKRAL4yZs/hOUJxs76Mq6WOQ1/AUsLr7vtordjkdCqmjXPmi1LrFyKAQhMVFuGYoDAhBUvMe4yvaoKlIBxIo2W86yyXHDMBBwQeOs2BJyXH346Cm+CFSp3gv1gEgLu2mxfr65oEFtiyQB975GpExwOkMVy6FWBwKLReMEMl1NmO2BdHMzFQANAgMBAAECggEAM7/WEoBAqSEERqh/JBrL5RYYZiOJTRcdNpSbGcGhEgvwqD0AVmPiOelpMlE02u/bLzmyH/eGnZ3z7z6ssfMMkffCuOkKayiZdmHWBb/PAp4SJvG5GaFrx631rupHCXQQh+uK+Jyi28qgf+c1JY+TJEuTPL+UI+mQ7BjV1R+2jrwGBEwcMsvDK/hAykzQ5hL1tGRYsEpdhTKNod5pr+rXmp/1+NB1bRChCrntV+LvSUIJ44LABE3cgXfEzjsOUusq1d/JUHxsiWOlt1vPtTcNtIx9ySa7Bwku4sScB4ndrP1hNGtUwCpYQrYWZ7KxBasWSiSTcC1jqoDNVUFjUs7GoQKBgQDUngEmxzdu+X247QqmJrTZ4GEuCV/ugj1lSP4ci88qEf8LZ0oAZhMMpYoVXKXRzBpwXH32YDU4lOM+kcAkfYb4lG+6uW2zZ6iMKINLFkUbQ+HLScA6sdoqhdWCdXlTH6FJlg4F1cXkY63GcM0PyAsVPU8XMXU+aJ/MA+Idn+bdiQKBgQCyn4poWJu/FWWopxy3gpVBFP/GSRa1p/UHLdt5hX58WfjszX7V4T7ktV/KqZw3Wlw2Xlg1nOcdOyl03JV2XpT+ztuWL3OWSL/kTEAbCQVWuDBAvfmWBtI1ZShnRsjovZG4zptr37Tj6SLupMfS+yz2xov7av19On/EfVQQ+R2RZQKBgBbHGp555zFnXxWpp2NncCaLSD3zWSinIUaxjC+otrfuF6G0HhRu2wmWznU9aLJSKF7zObdkVS9LnBC+8pO2Mvh8hn+9j8gRidgCGxa3Ow4RtqXdr89Z8GJv1hDU3vuNvuywO65aWYn/N8WznfRb3PwYhlmYvdPCx6PGornDwKrpAoGBAKkMZKkscvn8/iEHRx5F74uQnCDEu0Fgm30X4Ua5GGQHopY6RXeVnThGj0n2C2o3kl3CHClhPTlk7G809B76lHgyvY79iZ8JatJdd64ec3cHCmO7Z6KdAgSWoA5d53adMnR81IrbRQ8NbYn9WUBLhtpmPcTMFOuXmaQUGKOXoGwhAoGAZC7JFOJH55HmkZgKhsRQPqaVs1mnSaqO4Q5DmBsQ1u1QNrzLVZ11AGbg/5ElrZrqOSZ2vrREmmFRqjg/7R/Kg9fm4NNVmQW+v2Ffhm8HcVtNE/R8Wj/16Py+yk62cEcfN1B6wCaD8rBjiW6lqHiBA0YJJtAiYIvYhYisvRK/uyg=', // 应用私钥字符串
});
module.exports = alipaySdk;

var express = require('express');

const alipaySdk = require('../utils/alipay');
const AlipayFormData = require('alipay-sdk/lib/form').default; // alipay.trade.page.pay 返回的内容为 Form 表单
router.post('/pcpay', (req, res) => {
    (async () => {        // 调用 setMethod 并传入 get，会返回可以跳转到支付页面的 url
        const formData = new AlipayFormData();
        formData.setMethod('get');
        // 通过 addField 增加参数
        // 在用户支付完成之后，支付宝服务器会根据传入的 notify_url，以 POST 请求的形式将支付结果作为参数通知到商户系统。
        formData.addField('notifyUrl', 'http://localhost:8080/shopcar'); // 支付成功回调地址，必须为可以直接访问的地址，不能带参数
        formData.addField('bizContent', {
            outTradeNo: req.body.outTradeNo, // 商户订单号,64个字符以内、可包含字母、数字、下划线,且不能重复
            productCode: 'FAST_INSTANT_TRADE_PAY', // 销售产品码，与支付宝签约的产品码名称,仅支持FAST_INSTANT_TRADE_PAY
            totalAmount: '0.01', // 订单总金额，单位为元，精确到小数点后两位
            subject: '商品', // 订单标题
            body: '商品详情', // 订单描述
        });        // 如果需要支付后跳转到商户界面，可以增加属性"returnUrl"
        const result = await alipaySdk.exec(
            'alipay.trade.page.pay', // 统一收单下单并支付页面接口
            {}, // api 请求的参数（包含“公共请求参数”和“业务参数”）
            {formData: formData},);        // result 为可以跳转到支付链接的 url
        res.json({url: result});
    })();
});