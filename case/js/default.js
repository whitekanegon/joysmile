
// rollover
function initRollOverImages() {
  var image_cache = new Object();
  $("img.on").each(function(i) {
    var imgsrc = this.src;
    var dot = this.src.lastIndexOf('.');
    var imgsrc_ro = this.src.substr(0, dot) + '_on' + this.src.substr(dot, 4);
    image_cache[this.src] = new Image();
    image_cache[this.src].src = imgsrc_ro;
    $(this).hover(
      function() { this.src = imgsrc_ro; },
      function() { this.src = imgsrc; });
  });
}

$(document).ready(initRollOverImages);


// sidemenu_sub

$(document).ready(function() {
	$("dt.smenu_menuOff").hover(
		function(){
		$(this).css("cursor","pointer");
	 $(this).addClass("hilite");
		},
		function(){
		$(this).css("cursor","default"); 
	 $(this).removeClass("hilite");
	});
	$("dd.category01").css("display","none");
	$("dt.smenu_menuOff").click(
		function(){
		$(this).next().slideToggle("fast");
		});
});



$(document).ready(function() {
	$("dt.smenu_menuOn").hover(
		function(){
		$(this).css("cursor","pointer");
	 $(this).addClass("hilite");
		},
		function(){
		$(this).css("cursor","default"); 
	 $(this).removeClass("hilite");
	});
	$("dd.category02").css("display","block");
	$("dt.smenu_menuOn").click(
		function(){
		$(this).next().slideToggle("fast");
		});
});


function movieWin(url) {
	press=window.open(url, "movie", "width=350,height=270,toolbar=no,menubar=no,status=no,location=no,scrollbars=no,resizable=no");
press.focus();
}

function gsearchBox(){
	var _msg = 'div.catetitle #searchGbox td.gsc-input p.msg';
	var _input_td = 'div.catetitle #searchGbox td.gsc-input';
	var _input = 'div.catetitle #searchGbox input.gsc-input';
	
	$(_input_td).append('<p class="msg">サイト内検索</p>');
	$(_msg).click(function(){
		$(this).hide();
		$(_input).focus();
	});
	$(_input).click(function(){
		$(_msg).hide();
	});
	
	$("td.gsc-search-button").prepend('<input type="image" class="dmybtn" src="/common/img/btn_search_01.gif" alt="検索" />');
	$("td.gsc-search-button input.dmybtn").css({position:"absolute",top:0,right:0,zIndex:5});
	$("#contents form.gsc-search-box td.gsc-search-button input.dmybtn").css("right","20px");
	
}

$(window).load(function() {
	setTimeout(function(){
		gsearchBox();
	},100);
});
