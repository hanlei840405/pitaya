/**
 * Created by hanlei6 on 2016/12/1.
 */
$(document).ready(function () {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $('.sku-area').each(function () {
        var page = 1;
        var cateCode = $(this).attr('id');
        $(this).load('sku/show/' + page + '/' + cateCode);
        $(this).next().load('sku/page/' + page + '/' + cateCode);
    });
    $('#exclusive').load('sku/show/1/exclusive');
    $('#exclusivePager').load('sku/page/1/exclusive');
    $('.btn-add-to-cart').each(function (index) {
        var me = $(this);
        $(this).click((function (param) {
            return function () {
                var url = me.attr('href');
                var count = $('.purchase-text').get(param).value;
                if (count > 0) {
                    $.ajax({
                        url: url,
                        type: 'POST',
                        data: {count: count},
                        beforeSend: function (xhr) {
                            xhr.setRequestHeader(header, token);
                        },
                        success: function (response) {
                            if (undefined == response.code) {
                                location.href = 'login';
                            } else if (response.code == '500') {
                                alert("库存不足");
                                return;
                            } else {
                                $("#accordion").load('cart/fresh');
                            }
                        }
                    });
                } else {
                    alert("请填写购买数量");
                }
                return false;
            }
        })(index));
    });
    $('#accordion').find('.collapse').collapse({toggle: false});
    $('.cart-settle').click(function () {
        if ($('#accordion').find('.panel-default').size() == 1) {
            alert('购物车为空');
            return false;
        }
    });
});