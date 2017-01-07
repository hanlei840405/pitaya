/**
 * Created by JesseHan on 2017/1/7.
 */
$(document.body).ready(function () {
    $('#afterSaleRecords').load('aftersale/show/1');
    $('#afterSalePager').load('aftersale/page/1');
});

function bindAfterSaleSkus() {
    if ($.trim($('#executer').val()) == '') {
        alert('联系人不能为空');
        return false;
    }
    if ($.trim($('#courierNum').val()) == '') {
        alert('返修快递不能为空');
        return false;
    }
    if ($.trim($('#addr').val()) == '') {
        alert('返修后收货地址不能为空');
        return false;
    }
    if ($.isEmptyObject(exist)) {
        alert('请添加返修商品');
        return false;
    }
    var array = [];
    $('.repairSkuCount').each(function () {
        var sku = $(this).attr('id');
        var count = $(this).val();
        array.push({sku: sku, count: count});
    });
    $('#skus').val(JSON.stringify(array));
    return true;
}