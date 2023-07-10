

/*----------------------------------------------------*/ 
/* On Hover Over
------------------------------------------------------*/

	function megaHoverOver(){
		$(this).find(".sub").stop().fadeTo('fast', 1).show();
			
		//Calculate width of all ul's
		(function($) { 
			jQuery.fn.calcSubWidth = function() {
				rowWidth = 0;
				//Calculate row
				$(this).find("li").each(function() {					
					rowWidth += $(this).attr("offsetWidth");
				});	
			};
		})(jQuery); 
		
		if ( $(this).find(".row").length > 0 ) { //If row exists...
			var biggestRow = 0;	
			//Calculate each row
			$(this).find(".row").each(function() {							   
				$(this).calcSubWidth();
				//Find biggest row
				if(rowWidth > biggestRow) {
					biggestRow = rowWidth;
				}
			});
			//Set width
			$(this).find(".sub").css({'width' :biggestRow});
			$(this).find(".row:last").css({'margin':'0'});
			
		} else { //If row does not exist...
			
			$(this).calcSubWidth();
			//Set Width
			$(this).find(".sub").css({'width' : rowWidth});
			
		}
	}
	
	function megaHoverOut(){ 
	  $(this).find(".sub").stop().fadeTo('fast', 0, function() {
		  $(this).hide(); 
	  });
	}


	var config = {    
		 sensitivity: 5, // number = sensitivity threshold (must be 1 or higher)    
		 interval: 5, // number = milliseconds for onMouseOver polling interval    
		 over: megaHoverOver, // function = onMouseOver callback (REQUIRED)    
		 timeout: 5, // number = milliseconds delay before onMouseOut    
		 out: megaHoverOut // function = onMouseOut callback (REQUIRED)    
	};

/*----------------------------------------------------*/ 
/* trLink
------------------------------------------------------*/

function trLink(){
	var rows = ".trlink tbody tr";
	$(rows).click(function(){
		var url = $(this).children().find("a:first").attr("href");
		if(url) location.href = url;
	});
}

/*----------------------------------------------------*/ 
/* inputForcus
------------------------------------------------------*/

function inputForcus(object){
	$(object).focus(function(){
		var motobgcolor = $(this).css("background-color");
		$(this).css("background-color","#FFFFF4");
	}).blur(function(){
		$(this).css("background-color","#FFF");
	});;
}

/*----------------------------------------------------*/ 
/* inputCheckBox
------------------------------------------------------*/

function inputCheckBox(){
	$('input[type="checkbox"]').each(function(){
		if($(this).attr("checked")){
			$(this).parent("label").addClass("on")
		}
		$(this).click(function(){
			if($(this).attr("checked")){
				$(this).parent("label").addClass("on")
			}else{
				$(this).parent("label").removeClass("on")
			}
		});
	});
}

function inputRadio(){
	$('input[type="radio"]').each(function(){
		if($(this).attr("checked")){
			$(this).parent("label").addClass("on")
		}
		$(this).click(function(){
			var name = $(this).attr("name");
			$('input[name="'+name+'"]').parent("label").removeClass("on");
			$(this).parent("label").addClass("on");
		});
	});
}

function checkAllClear(){
	$(".reset_btn a").click(function(){
		$('input').each(function(){
			var name = $(this).attr("name");
			if(name.indexOf("s_con") != -1){
				return true;
			}else{
				$(this).removeAttr("checked");
				$(this).parent("label").removeClass("on")
			}
		});
		return false;
	});
}


/*----------------------------------------------------*/ 
/* fakeInput
------------------------------------------------------*/

function fakeInput(){
	$(".file").change(function(){
		$(this).parent().find("input.inputfake").val($(this).val());
	});
	$(".uploadimg").each(function(){
		$(this).find("li:last").addClass("end");
	});
}

/*----------------------------------------------------*/ 
/* testupload
------------------------------------------------------*/

function testupload(){
	$('.uploadimg input[type="image"]').each(function(){
		$(this).click(function(){
			if($(this).parent().prev().find('input.inputfake').val()){
				$(this).parent().next().find("img").show();
			}
			return false;
		});
	});
}

/*----------------------------------------------------*/ 
/* get_response_text
------------------------------------------------------*/

function get_response_text ( text ) {
	//var text = req.responseText;
	if ( navigator.appVersion.indexOf( "KHTML" ) > -1 ) {
		var esc = escape( text );
		if ( esc.indexOf("%u") < 0 && esc.indexOf("%") > -1 ) {
			text = decodeURIComponent( esc );
		}
	}
	return text;
}

/*----------------------------------------------------*/ 
/* deleteConfirm
------------------------------------------------------*/

function deleteConfirm(){
	$("form.delete").submit(function(){
		if(window.confirm('本当に削除しますか？')){
		}else{
			return false;
		}
	});
	$("form.delete_bunrui").submit(function(){
		if(window.confirm('削除しようとしている項目は、記事で使用されていませんか？\n登録済みの記事にその項目がある場合、削除するとリンクエラーとなります。\n本当に削除してもよろしいですか？')){
		}else{
			return false;
		}
	});
}

/*----------------------------------------------------*/ 
/* form_validate
------------------------------------------------------*/

function form_validate(){

//半角アルファベット（大文字･小文字）もしくは数字のみ
jQuery.validator.addMethod("alphanum", function(value, element) {
	return this.optional(element) || /^([a-zA-Z0-9]+)$/.test(value);
	}, "半角英数字を入力してください"
);

	$("form#kiji_edit").validate({
		rules:{
			sex:{
				required:true
			},
			shiretsu:{
				required:true
			},
			basshi:{
				required:true
			},
			shindan:{
				required:true
			},
			/*
			case_num:{
				required:true,
				number:true
			},
			*/
			thisinfo:{
				required:true
			}
		},
		errorElement: "p"
	});

	$("form#shindan_edit").validate({
		rules:{
			name:{
				required:true
			},
			dir:{
				required:true,
				alphanum:true
			},
			explanation:{
				required:true
			},
			explanation_short:{
				required:true
			}
		},
		errorElement: "p"
	});
	
	$("form#nendai_edit").validate({
		rules:{
			name:{
				required:true
			},
			explanation:{
				required:true
			}
		},
		errorElement: "p"
	});
	
	$("form#others_edit").validate({
		rules:{
			name:{
				required:true
			}
		},
		errorElement: "p"
	});
	
}

/*----------------------------------------------------*/ 
/* upload
------------------------------------------------------*/

function upload_load(){
	$(".upload_btn").click(function(){
		var parentObj = $(this).parents("dl");
		if(parentObj.find(".file").val()){
		parentObj.find(".fileinputs").upload('upload.php', function(res){
			if(res.filepath != 'error'){
				parentObj.find("dd.upimage img").attr("src",res.filepath);
			}
			parentObj.find("dd.msg").html(res.msg);
			parentObj.find("dd.msg").show();
		},'json');
		}else{
			parentObj.find("dd.msg").text("画像を選択して下さい。");
			parentObj.find("dd.msg").show();
		}
		return false;
	});
	
	$(".photo_delete_btn").click(function(){
		var parentObj = $(this).parents("dl");
		parentObj.find(".fileinputs").upload('photo_delelte.php', function(res){
			if(res.filepath){
				parentObj.find("dd.upimage img").attr("src",res.filepath+".gif");
				parentObj.find("dd.msg").html(res.msg);
				parentObj.find("dd.msg").show();
			}
		},'json');
		return false;
	});
}

/*----------------------------------------------------*/ 
/* add_related
------------------------------------------------------*/

function add_relatedLink(){
	$(".add_relatedLink").click(function(){
		var add_dt = $("<dt />").html('<input type="text" name="related_title[]" class="text" value="" />');
		var add_dd = $("<dd />").html('<input type="text" name="related_url[]" class="text" value="" />');
		$("div.relateLink dl").append(add_dt).append(add_dd);
		return false;
	});
}


/*----------------------------------------------------*/ 
/* load function
------------------------------------------------------*/

$(function(){
	trLink();
	fakeInput();
	deleteConfirm();
	inputForcus('input[type="text"]');
	inputForcus('textarea');
	inputCheckBox();
	inputRadio();
	form_validate();
	upload_load();
	add_relatedLink();
	checkAllClear();
	$("div.search_result > ul > li").biggerlink();
	$("#gnavi li .sub").css({'opacity':'0'});
	$("#gnavi li").hoverIntent(config);
	$("#gnavi > ul > li > a").click(function(){return false;});
	
});