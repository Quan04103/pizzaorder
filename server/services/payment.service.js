const axios = require('axios').default;
const CryptoJS = require('crypto-js');
const moment = require('moment');

const config = {
    app_id: '2553',
    key1: 'PcY4iZIKFCIdgZvA6ueMcMHHUbRLYjPL',
    key2: 'kLtgPl8HHhfvMuDHPwKfgfsY4Ydm9eIz',
    endpoint: 'https://sb-openapi.zalopay.vn/v2/create',
};

async function createPayment(app_user, amount) {
    const embed_data = {
        // redirecturl: 'https://phongthuytaman.com',
    };

    const items = [];
    const transID = Math.floor(Math.random() * 1000000);

    const order = {
        app_id: config.app_id,
        app_trans_id: `${moment().format('YYMMDD')}_${transID}`,
        app_user: app_user,
        app_time: Date.now(),
        item: JSON.stringify(items),
        embed_data: JSON.stringify(embed_data),
        amount: amount,
        callback_url: 'https://3c5c-171-248-98-69.ngrok-free.app/callback',
        description: `Domini - Đơn hàng #${transID}`,
        bank_code: 'zalopayapp',
    };

    const data =
        config.app_id +
        '|' +
        order.app_trans_id +
        '|' +
        order.app_user +
        '|' +
        order.amount +
        '|' +
        order.app_time +
        '|' +
        order.embed_data +
        '|' +
        order.item;
    order.mac = CryptoJS.HmacSHA256(data, config.key1).toString();
    console.log('mac =', order.mac);

    try {
        const result = await axios.post(config.endpoint, null, { params: order });
        return result.data;
    } catch (error) {
        console.log(error);
    }
}

async function updateOrderStatus(app_trans_id, status) {
    // Logic để cập nhật trạng thái đơn hàng trong cơ sở dữ liệu
    console.log(`Updating order status: ${app_trans_id} to ${status}`);
    // Ví dụ:
    await OrderModel.updateOne({ app_trans_id }, { status });
}

function handleCallback(dataStr, reqMac) {
    let result = {};
    let mac = CryptoJS.HmacSHA256(dataStr, config.key2).toString();
    
    console.log('mac2 =', mac);
    if (reqMac !== mac) {
        result.return_code = -1;
        result.return_message = 'mac not equal';
    } else {
        // thanh toán thành công
        // merchant cập nhật trạng thái cho đơn hàng ở đây
        let dataJson = JSON.parse(dataStr, config.key2);
        updateOrderStatus(dataJson['app_trans_id'], 'success');
        result.return_code = 1;
        console.log(
            "update order's status = success where app_trans_id =",
            dataJson['app_trans_id'],
        );
        console.log("amount =", dataJson['amount'])
        console.log("mac =", mac)
        result.return_message = 'success';
    }
    return result;
}



module.exports = {
    createPayment,
    handleCallback
};