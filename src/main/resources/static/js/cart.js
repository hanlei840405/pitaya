/**
 * Created by hanlei6 on 2016/12/2.
 */

$(document).ready(function () {
    var selectAddress = $('#addressId').val();
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $('.select-address').each(function () {
        var me = $(this);
        me.click(function () {
            var url = me.attr('href');
            $.ajax({
                url: url,
                type: 'GET',
                beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                },
                success: function (response) {
                    if (response.code == '200') {
                        var address = response.address;
                        selectAddress = address.id;
                        var addr = address.addr;
                        var recipient = address.recipient;
                        var phone = address.phone;
                        $('#addr').text(addr);
                        $('#recipient').text(recipient);
                        $('#phone').text(phone);
                    }
                }
            });
            return false;
        });
    });
    $('.check_out').click(function () {
        var form = $('form:first');
        if (selectAddress == null && selectAddress == '') {
            var address = $('#cart_address').val();
            var recipient = $('#cart_recipient').val();
            var phone = $('#cart_phone').val();
            if ($.trim(address) == '' || $.trim(recipient) == '' || $.trim(phone) == '') {
                alert("地址、联系人、电话缺一不可！");
                return;
            }
            form.prop('action', '../cart/settle/');
        }
        form.submit();
    });
    $('.update').click(function () {
        $('#addresses').css('display', 'block');
    });
});
