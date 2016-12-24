/**
 * Created by hanlei6 on 2016/12/1.
 */
$(document).ready(function () {
    $('.sku-area').each(function () {
        var page = 1;
        var cateCode = $(this).attr('id');
        $(this).load('sku/show/' + page + '/' + cateCode);
        $(this).next().load('sku/page/' + page + '/' + cateCode);
    });

    $('#accordion').find('.collapse').collapse({toggle: false});
    $('.cart-settle').click(function () {
        if ($('#accordion').find('.panel-default').size() == 1) {
            alert('购物车为空');
            return false;
        }
    });
});

function addCart(element) {
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    var a = $(element);
    var sku = a.attr('data');
    var countElementId = a.attr('id').replace('link','count');
    var count = $('#' + countElementId).val();
    if (count > 0) {
        $.ajax({
            url: 'cart/addSku/' + sku,
            type: 'POST',
            data: {'count': count},
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
}