
//sp_sign

$(function(){
	$('body').prepend('<span class="sp_sign"></span>');
});



//shindan_sub

$(function(){
	if(!$(".search_result").length){
		var s_main = "div.shindan_title p.notice_category";
		var s_sub = "div.shindan_title div.sub";
		var s_main_width = $(s_main).width();
		$(s_main).width(s_main_width);
		s_main_width = $(s_main).outerWidth({margin: true});
		$(s_sub).width(630 - s_main_width);
	}
});

//inputCheckBox

$(function(){
	$('input[type="checkbox"]').each(function(){
		if($(this).attr("checked")){
			$(this).parent("label").addClass("on");
		}
		$(this).click(function(){
			if($(this).attr("checked")){
				$(this).parent("label").addClass("on");
			}else{
				$(this).parent("label").removeClass("on");
			}
		});
	});
});

$(function(){
	$('input[type="radio"]').each(function(){
		if($(this).attr("checked")){
			$(this).parent("label").addClass("on");
		}
		$(this).click(function(){
			var name = $(this).attr("name");
			$('input[name="'+name+'"]').parent("label").removeClass("on");
			$(this).parent("label").addClass("on");
		});
	});
});

$(function(){
	$(".reset_btn a").click(function(){
		$('input').each(function(){
			var name = $(this).attr("name");
			if(name) {
				if(name.indexOf("s_con") !== -1){
					return true;
				}else{
					$(this).removeAttr("checked");
					$(this).parent("label").removeClass("on");
				}
			}
		});
		return false;
	});
});


//search

$(function(){
	var souchi_category = [
		["可撤式装置",1],
		["固定式装置",7],
		["顎外固定式装置",13],
		["エッジワイズ装置",16],
		["保定装置",24]
	];
	
	var _souchi_list = "form.search_item ul.souchi li";
	$(_souchi_list).each(function(){
		var souchi_id = $(this).find("input").val();
		for(var i = 0; i<souchi_category.length; i++){
			if(souchi_id == souchi_category[i][1]){
				$(this).before('<li class="title">'+souchi_category[i][0]+'</li>');
			}
		}
	});
	
	$(window).on('load resize',function(){
		var con = $('.search .freewords ul.con');
		var con_parent = $('.search .freewords');
		if($('.sp_sign').is(':visible')){
			con.insertAfter(con_parent.find('input[type=text]'));
		}else{
			con.appendTo(con_parent);
		}
	});
	
});

//biggerlink

$(function(){
	$("div.search_result > ul > li").biggerlink();
	$(".caselist li").biggerlink();
});


//shindan.php 

$(function(){
	var li_num;
	if($('.sp_sign').is(':visible')){
		li_num = 4;
	}else{
		li_num = 5;
	}
	$('.categoy_entries').not('.kubun_shindan').find('dd ul').each(function(){
		if($(this).find('li').length > li_num){
			$(this).after('<ul class="hide"></ul>');
			$(this).find('li:gt('+(li_num - 1)+')').appendTo($(this).next('ul.hide'));
			if($(this).find('.kubun').length){
				var key = $(this).parents('dd').prev('dt').attr('data-key');
				$(this).parent().append('<p class="btn_more_page"><a href="kubun_shindan.php?id='+key+'" class="cmnbtn03">もっと見る</a></p>');
			}else{
				$(this).parent().append('<p class="btn_more"><a href="#">もっと見る</a></p>');
			}
		}
	});
	$('.categoy_entries dd .btn_more a').click(function(){
		var btn_more = $(this);
		btn_more.parents('dd').find('ul.hide').slideToggle('fast',function(){
			if(btn_more.hasClass('close')){
				btn_more.removeClass('close').text('もっと見る');
				var blocktop = btn_more.parents('dd').prev('dt').offset().top;
				$("html, body").animate({scrollTop:blocktop}, 500, "swing");
			}else{
				btn_more.addClass('close').text('閉じる');
			}
		});
		return false;
	});

});

//search_result

$(function(){
	var result_list = $('.search_result').not('.hide').children('ul');
	if(result_list.children('li').length > 5){
		result_list.after('<ul class="hide"></ul>');
		result_list.children('li:gt(4)').appendTo('ul.hide');
		result_list.parent().append('<p class="btn_more"><a href="#">もっと見る</a></p>');
	}
	
	$('.search_result .btn_more a').click(function(){
		var btn_more = $(this);
		btn_more.parents('.search_result').children('ul.hide').slideToggle('fast',function(){
			if(btn_more.hasClass('close')){
				btn_more.removeClass('close').text('もっと見る');
				var blocktop = $('#contents').offset().top;
				$("html, body").animate({scrollTop:blocktop}, 500, "swing");
			}else{
				btn_more.addClass('close').text('閉じる');
			}
		});
		return false;
	});
});

//detail.php 

$(function(){
	var karte = $('.titlebox .karte');
	var karte_txt = karte.text();
	karte.text(karte_txt.replace(/千里|堺/,''));
	
	$('.shourei_detail').magnificPopup({
		delegate: 'a',
		type: 'image',
		closeOnContentClick: false,
		closeBtnInside: false,
		mainClass: 'mfp-with-zoom mfp-img-mobile',
		image: {
			verticalFit: true,
		},
		gallery: {
			enabled: true,
			navigateByImgClick: false,
			tCounter: ''
		},
		zoom: {
			enabled: true,
			duration: 300, // don't foget to change the duration also in CSS
			opener: function(element) {
				return element.find('img');
			}
		}
	});
	$('.photo_patient').magnificPopup({
		delegate: 'a',
		type: 'image',
		closeOnContentClick: false,
		closeBtnInside: false,
		mainClass: 'mfp-with-zoom mfp-img-mobile',
		image: {
			verticalFit: true,
		},
		zoom: {
			enabled: true,
			duration: 300, // don't foget to change the duration also in CSS
			opener: function(element) {
				return element.find('img');
			}
		}
	});
});

