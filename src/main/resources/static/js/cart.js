/**
 * Created by hanlei6 on 2016/12/2.
 */

var selectAddress = null;
$(document).ready(function () {
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
    $('.check_out').each(function () {
        var me = $(this);
        me.click(function () {
            var form = $('form:first');
            if (selectAddress != null) {
                form.prop('action', '../cart/settle/' + selectAddress);
            } else {
                form.prop('action', '../cart/settle/');
            }
            form.submit();
        });
    });
    $('.update').click(function () {
        $('#addresses').css('display', 'block');
    });
});
