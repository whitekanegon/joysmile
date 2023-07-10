

function selectBox(){
	var selectedTxt = $("#top_others option:selected").text();
	$("#select_fake").text(selectedTxt);
}

/*----------------------------------------------------*/ 
/* load function
------------------------------------------------------*/

$(function () {
	selectBox();
});