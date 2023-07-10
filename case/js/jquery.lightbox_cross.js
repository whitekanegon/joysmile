/*----------------------------------------------------*/ 
/* lightbox_load
------------------------------------------------------*/

function lightbox_load(){
	$('a[rel*=lightbox]').lightBox({
		imageLoading:'/case/img/lightbox/lightbox-ico-loading.gif',
		imageBtnClose:'/case/img/lightbox/lightbox-btn-close.gif',
		imageBtnPrev:'/case/img/lightbox/lightbox-btn-prev.gif',
		imageBtnNext:'/case/img/lightbox/lightbox-btn-next.gif',
		imageBlank:'/case/img/lightbox/lightbox-blank.gif'
	});
}

function lightbox_load_cross(){
	$('a[rel*=lightbox]').lightBox({
		imageLoading:'/case/img/lightbox/lightbox-ico-loading.gif',
		imageBtnClose:'/case/img/lightbox/lightbox-btn-close.gif',
		imageBtnPrev:'/case/img/lightbox/lightbox-btn-prev.gif',
		imageBtnNext:'/case/img/lightbox/lightbox-btn-next.gif',
		imageBlank:'/case/img/lightbox/lightbox-blank.gif'
	});
	var linkcount = $("#lightbox-image-details-caption a").length;
	$("#lightbox-image-details-caption a").attr("minus_count",linkcount);
}

function light_box_finish(){
	$('#jquery-lightbox').remove();
	$('#jquery-overlay').remove();
	// Show some elements to avoid conflict with overlay in IE. These elements appear above the overlay.
	$('embed, object, select').css({ 'visibility' : 'visible' });
}

/*----------------------------------------------------*/ 
/* load function
------------------------------------------------------*/

$(function () {
	lightbox_load();
});