/*scroll to top*/

$(document).ready(function(){
	$(function () {
		$.scrollUp({
	        scrollName: 'scrollUp', // Element ID
	        scrollDistance: 300, // Distance from top/bottom before showing element (px)
	        scrollFrom: 'top', // 'top' or 'bottom'
	        scrollSpeed: 300, // Speed back to top (ms)
	        easingType: 'linear', // Scroll to top easing (see http://easings.net/)
	        animation: 'fade', // Fade, slide, none
	        animationSpeed: 200, // Animation in speed (ms)
	        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
					//scrollTarget: false, // Set a custom target element for scrolling to the top
	        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
	        scrollTitle: false, // Set a custom <a> title if required.
	        scrollImg: false, // Set true to use image
	        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
	        zIndex: 2147483647 // Z-Index for the overlay
		});
	});
	footerPosition();
	$(window).resize(footerPosition);
});

function footerPosition(){
	$("footer").removeClass("fixed-bottom");
	var contentHeight = document.body.scrollHeight,//网页正文全文高度
			winHeight = window.innerHeight;//可视窗口高度，不包括浏览器顶部工具栏
	if(!(contentHeight > winHeight)){
		//当网页正文高度小于可视窗口高度时，为footer添加类fixed-bottom
		$("footer").addClass("fixed-bottom");
	} else {
		$("footer").removeClass("fixed-bottom");
	}
}
function pagination(obj) {
	var url = obj.name;
	var pageArea = $(obj).parent().parent().parent().parent();
	var ele = pageArea.prev();
	ele.load(url);
	url = url.replace('show', 'page');
	pageArea.load(url);
	return false;
}
