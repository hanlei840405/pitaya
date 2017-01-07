/**
 * Created by JesseHan on 2017/1/7.
 */
$(document.body).ready(function () {
    $('#customerRateds').load('customerRated/show/1');
    $('#ratePager').load('customerRated/page/1');
});

function uploadCertificate(obj) {
    var file = $(obj).find('input:file')[0];
    debugger;
    if (file.value == '') {
        alert("请上传交易凭证");
        return false;
    }
    return true;
}