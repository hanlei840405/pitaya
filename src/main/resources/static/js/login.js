/**
 * Created by hanlei6 on 2016/12/2.
 */

$(document.body).ready(function () {
    $('#birthday').datepicker({
        format: "yyyy-mm-dd",
        language: "zh-CN"
    });
    $('.male').click(function () {
        $('#sex').val('M');
        $('.male').removeClass('btn-default').addClass('btn-success');
        $('.female').removeClass('btn-success').addClass('btn-default');
    });
    $('.female').click(function () {
        $('#sex').val('F');
        $('.female').removeClass('btn-default').addClass('btn-success');
        $('.male').removeClass('btn-success').addClass('btn-default');
    });
    $('.normalShop').click(function () {
        $('#cusType').val('0');
        $('.normalShop').removeClass('btn-default').addClass('btn-success');
        $('.wxShop').removeClass('btn-success').addClass('btn-default');
    });
    $('.wxShop').click(function () {
        $('#cusType').val('1');
        $('.wxShop').removeClass('btn-default').addClass('btn-success');
        $('.normalShop').removeClass('btn-success').addClass('btn-default');
    });
    $('.submit').on('click', register);
});
function register() {
    var flag = true;
    var f1 = validate($('#cusName'));
    var f2 = validate($('#passwd'));
    var f3 = validate($('#birthday'));
    var f4 = validate($('#email'));
    var f5 = validate($('#phone'));
    var f6 = validate($('#wechat'));
    if (flag && f1 && f2 && f3 && f4 && f5 && f6) {
        $('#signForm').submit();
    }
}
function validate(dom) {
    if ($.trim(dom.val()) == '') {
        dom.css('background', '#a94442');
        return false;
    }
    return true;
}