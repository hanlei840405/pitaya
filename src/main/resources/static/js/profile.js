/**
 * Created by hanlei6 on 2016/12/2.
 */
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");
$(document.body).ready(function () {
    $('#birthday').datepicker({
        format: "yyyy-mm-dd",
        language: "zh-CN"
    });
    loadOrders();
    loadAddresses();
    loadShopInfos();
    $('.certificate').click(function () {
        var form = $(this).parent('form');
        var file = form.find('input:file');
        if (file.val() == '') {
            alert("请上传交易凭证");
            return false;
        }
        form.submit();
    });
});

function loadOrders() {
    $('#orders').load('order/show/1');
    $('#orderPager').load('order/page/1');
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

                var usedSpan = $('<a title="设为常用"></a>');
                usedSpan.addClass('fa fa-anchor pull-right');
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
