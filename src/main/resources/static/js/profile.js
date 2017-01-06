/**
 * Created by hanlei6 on 2016/12/2.
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
var exist = {};
$(document.body).ready(function () {
    $('#birthday').datepicker({
        format: "yyyy-mm-dd",
        language: "zh-CN"
    });
    loadOrders();
    loadCustomerRated();
    loadAfterSales();
    loadAddresses();
    loadShopInfos();
    $("#select_repair").select2();
    $('#select_repair').on('select2:select', function (evt) {
        var value = evt.params.data.id;
        var text = evt.params.data.text;
        if (value == '') {
            return;
        }
        if (exist[value] == null) {
            exist[value] = value;
            var tableRepair = $('#table_repair');
            var tr = $('<tr/>');
            var skuTd = $('<td/>');
            skuTd.html(value)
            var skuNameTd = $('<td/>');
            skuNameTd.html(text)
            var inputCount = $('<input type="input" value="1" class="repairSkuCount" id="' + value + '"/>');
            inputCount.blur((function (ele) {
                return function () {
                    if (isNaN(ele.val()) || ele.val() < 1) {
                        alert('请输入大于0的数字');
                        window.setTimeout(function () {
                            ele.focus();
                        }, 0);
                    }
                }
            })(inputCount));
            var countTd = $('<td/>');
            countTd.append(inputCount);
            var btn_del = $('<input type="button" value="删除" class="btn btn-info"/>')
            btn_del.click((function (val) {
                return function () {
                    delete exist[val];
                    tr.remove();
                }
            })(value));
            var actionTd = $('<td/>');
            actionTd.append(btn_del);
            tr.append(skuTd).append(skuNameTd).append(countTd).append(actionTd);
            tableRepair.append(tr);
        }
        $("#select_repair").val(null).trigger("change");
    });
});

function loadOrders() {
    $('#orders').load('order/show/1');
    $('#orderPager').load('order/page/1');
}

function loadCustomerRated() {
    $('#customerRateds').load('customerRated/show/1');
    $('#ratePager').load('customerRated/page/1');
}

function loadAfterSales() {
    $('#afterSaleRecords').load('aftersale/show/1');
    $('#afterSalePager').load('aftersale/page/1');
}

function loadAddresses() {
    $.ajax({
        cache: false,
        type: 'POST',
        url: 'customer/listAddr',
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (response) {
            var addresses = $('#addresses');
            addresses.empty();
            var ul = $('<ul/>');
            for (var i = 0; i < response.length; i++) {
                var addr = response[i];
                var deleteSpan = $('<a title="删除"/>');
                deleteSpan.addClass('fa fa-times pull-right');
                deleteSpan.click((function (param) {
                    return function () {
                        $.ajax({
                            cache: false,
                            type: 'POST',
                            url: 'customer/deleteAddr',
                            data: {id: param.id},
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader(header, token);
                            },
                            success: function (response) {
                                if (response.code == '200') {
                                    alert("删除成功");
                                    loadAddresses();
                                } else {
                                    alert(response.msg);
                                }
                            }
                        });
                    }
                })(addr));

                var editSpan = $('<a title="编辑"/>');
                editSpan.addClass('fa fa-pencil-square-o pull-right');
                editSpan.click((function (param) {
                    return function () {
                        $('#address_addrId').val(param.id);
                        $('#address_addr').val(param.addr);
                        $('#address_recipient').val(param.recipient);
                        $('#address_phone').val(param.phone);
                    }
                })(addr));

                var usedSpan = $('<a title="设为常用">默认</a>');
                usedSpan.addClass('fa pull-right');
                usedSpan.click((function (param) {
                    return function () {
                        $.ajax({
                            cache: false,
                            type: 'POST',
                            url: 'customer/usedAddr',
                            data: {id: param.id},
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader(header, token);
                            },
                            success: function (response) {
                                if (response.code == '200') {
                                    alert("设置成功");
                                    loadAddresses();
                                } else {
                                    alert(response.msg);
                                }
                            }
                        });
                    }
                })(addr));

                var ele = $('<li/>');
                if (addr.used == '1') {
                    ele.css('font-weight', 'bolder');
                }
                ele.append(addr.addr).append(" ").append(addr.recipient).append(" ").append(addr.phone).append(usedSpan).append(deleteSpan).append(editSpan);
                ul.append(ele);
            }
            addresses.append(ul);
        }
    });
}

function loadShopInfos() {
    $.ajax({
        cache: false,
        type: 'POST',
        url: 'customer/listShop',
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (response) {
            var shopInfos = $('#shopInfos');
            shopInfos.empty();
            var ul = $('<ul/>');
            for (var i = 0; i < response.length; i++) {
                var shop = response[i];
                var deleteSpan = $('<a title="删除"/>');
                deleteSpan.addClass('fa fa-times pull-right');
                deleteSpan.click((function (param) {
                    return function () {
                        $.ajax({
                            cache: false,
                            type: 'POST',
                            url: 'customer/deleteShop',
                            data: {id: param.id},
                            beforeSend: function (xhr) {
                                xhr.setRequestHeader(header, token);
                            },
                            success: function (response) {
                                if (response.code == '200') {
                                    alert("删除成功");
                                    loadAddresses();
                                } else {
                                    alert(response.msg);
                                }
                            }
                        });
                    }
                })(shop));

                var editSpan = $('<a title="编辑"/>');
                editSpan.addClass('fa fa-pencil-square-o pull-right');
                editSpan.click((function (param) {
                    return function () {
                        $('#shopInfo_shopId').val(param.id);
                        $('#shopInfo_shopName').val(param.shopName);
                        $('#shopInfo_shopAddr').val(param.shopAddr);
                        if (param.category == '1') {
                            $('#shopInfo_category').prop('checked', true);
                        } else {
                            $('#shopInfo_category').prop('checked', false);
                        }
                    }
                })(shop));

                var viewSpan = $('<a title="查看照片" data-target="#myModal"/>');
                viewSpan.addClass('fa fa-eye pull-right');
                viewSpan.click((function (param) {
                    return function () {
                        $('#shopPic').attr('src', 'ext/private/' + param.shopPic);
                        $('#myModal').modal({
                            keyboard: true
                        })
                    }
                })(shop));

                var ele = $('<li/>');
                ele.append(shop.shopName).append(" ").append(shop.shopAddr).append(deleteSpan).append(viewSpan).append(editSpan)
                ul.append(ele);
            }
            shopInfos.append(ul);
        }
    });
}

function showPanel(tag) {
    $('.blog-post-area').each(function () {
        $(this).css('display', 'none');
    });
    $('#' + tag).css('display', 'block');
    footerPosition();
}

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

function uploadCertificate(obj) {
    var file = $(obj).find('input:file')[0];
    debugger;
    if (file.value == '') {
        alert("请上传交易凭证");
        return false;
    }
    return true;
}

function openWindow(){
    $('#modifyPasswordModal').modal({keyboard: false});
}

function changePwd() {
    var oldPwd = $('#oldPwd').val();
    var newPwd = $('#newPwd').val();
    $.ajax({
        cache: false,
        type: 'POST',
        url: 'customer/changePwd',
        data: {'newPwd': newPwd, 'oldPwd': oldPwd},
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
        },
        success: function (response) {
            if (response.code == '200') {
                alert("修改密码成功");
                loadAddresses();
            } else {
                alert(response.msg);
            }
        }
    });
}