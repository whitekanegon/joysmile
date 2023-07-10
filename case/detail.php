<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$main_id = $_GET["id"];
$nendai_id = $_GET["nendai"];
$tantou_id = $_GET["tantou"];

//年代データをセット

if($main_id){
	//$sql = "select * from sh_main where id = {$main_id} and shitagaki = 0";
	$sql = db_tbl_alljoin(0,0,"id = {$main_id}",0);
	list($data, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}else{
	header("location: index.php");
}

$sql = "select * from sh_main where id = {$main_id} and shitagaki = 0";
list($s_data, $count) =  select_arrays($conn,$sql);
$shindan_id = $s_data[0]["shindan"];
//$data = all_join_table($data);

//データ整形

if($data[0]["shindan_sub"]){
	$data[0]["shindan_sub"] = explode(",",$data[0]["shindan_sub"]);
}
if($data[0]["souchi"]){
	$data[0]["souchi"] = explode(",",$data[0]["souchi"]);
	foreach($data[0]["souchi"] as $key => $val){
		$data[0]["souchi"][$key] = ereg_replace("エッジワイズ装置","エッジワイズ装置<br />",$val);
	}
}
if($data[0]["tantou"]){
	$data[0]["tantou"] = explode(",",$data[0]["tantou"]);
}
$data[0]["sex_ex"] = sex_str($data[0]["age"],$data[0]["sex"]);
$data[0]["thisinfo"] = nl2br($data[0]["thisinfo"]);
$data[0]["kansou"] = nl2br($data[0]["kansou"]);
$data[0]["comment"] = nl2br($data[0]["comment"]);
if($data[0]["kansou"])	$data[0]["kansou_mark"] = '★';

$data[0]["photo_first"] = explode(",",$data[0]["photo_first"]);
$data[0]["photo_mdl"] = explode(",",$data[0]["photo_mdl"]);
$data[0]["photo_end"] = explode(",",$data[0]["photo_end"]);

//症例画像ライトボックス処理

if($data[0]["photo_first"]){
	foreach($data[0]["photo_first"] as $key => $val){
		($data[0]["photo_mdl"][$key]) ? $mdl = '<a href="'.$data[0]["photo_mdl"][$key].'.jpg" rel="lightbox">'._PHOTO_MDL.'</a>' :		$mdl = _PHOTO_MDL;
		($data[0]["photo_end"][$key]) ? $end = '<a href="'.$data[0]["photo_end"][$key].'.jpg" rel="lightbox">'._PHOTO_END.'</a>' :		$end = _PHOTO_END;
		$data[0]["crossLink"]["photo_first"][$key] = '<strong>'._PHOTO_FIRST.'</strong>｜'.$mdl.'｜'.$end;
	}
}

if($data[0]["photo_mdl"]){
	foreach($data[0]["photo_mdl"] as $key => $val){
		($data[0]["photo_first"][$key]) ? $fst = '<a href="'.$data[0]["photo_first"][$key].'.jpg" rel="lightbox">'._PHOTO_FIRST.'</a>' :		$fst = _PHOTO_FIRST;
		($data[0]["photo_end"][$key]) ? $end = '<a href="'.$data[0]["photo_end"][$key].'.jpg" rel="lightbox">'._PHOTO_END.'</a>' :		$end = _PHOTO_END;
		$data[0]["crossLink"]["photo_mdl"][$key] = $fst.'｜<strong>'._PHOTO_MDL.'</strong>｜'.$end;
	}
}

if($data[0]["photo_end"]){
	foreach($data[0]["photo_end"] as $key => $val){
		($data[0]["photo_first"][$key]) ? $fst = '<a href="'.$data[0]["photo_first"][$key].'.jpg" rel="lightbox">'._PHOTO_FIRST.'</a>' :		$fst = _PHOTO_FIRST;
		($data[0]["photo_mdl"][$key]) ? $mdl = '<a href="'.$data[0]["photo_mdl"][$key].'.jpg" rel="lightbox">'._PHOTO_MDL.'</a>' :		$mdl = _PHOTO_MDL;
		$data[0]["crossLink"]["photo_end"][$key] = $fst.'｜'.$mdl.'｜<strong>'._PHOTO_END.'</strong>';
	}
}

$photo = photo_array();

//その他の症例

if($nendai_id){
	$sql = "select * from sh_nendai where id = {$nendai_id}";
	list($nendai_now, $count) =  select_arrays($conn,$sql);
	$gene = explode(",",$nendai_now[0]["generation"]);
	$sql = "select * from sh_main where shindan = {$shindan_id} and age between {$gene[0]} and {$gene[1]} and shitagaki = 0";
}elseif($tantou_id){
	$sql = "select * from sh_tantou where id = {$tantou_id}";
	list($tantou_now, $count) =  select_arrays($conn,$sql);
	$sql = "select * from sh_main where shindan = {$shindan_id} and FIND_IN_SET({$tantou_id},tantou) and shitagaki = 0 order by id";
}else{
	$sql = "select * from sh_main where shindan = {$shindan_id} and shitagaki = 0 order by id";
}
list($related_data, $related_count) =  select_arrays($conn,$sql);
//$related_data = all_join_table($related_data);

$TABLE_DATA = relation_tables();
foreach($related_data as $key => $val){
	$related_data[$key]["sex_ex"] = sex_str($related_data[$key]["age"],$related_data[$key]["sex"]);
	if($related_data[$key]["kansou"])	$related_data[$key]["kansou_mark"] = '★';
	$related_data[$key]["shiretsu"] = $TABLE_DATA["shiretsu"][$val["shiretsu"] - 1]["name"];
	$related_data[$key]["basshi"] = $TABLE_DATA["basshi"][$val["basshi"] -1]["name"];
}


require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

//サイドメニュー読込
require_once("sidemenu.php");

$smarty -> assign('data',$data[0]);
$smarty -> assign("photo",$photo);
$smarty -> assign("main_id",$main_id);
$smarty -> assign("related_data",$related_data);
$smarty -> assign("related_count",$related_count);
$smarty -> assign("nendai_name",$nendai_now[0]["name"]);
$smarty -> assign("tantou_name",$tantou_now[0]["name"]);
$smarty -> assign("nendai_id",$nendai_id);
$smarty -> assign("shindan_id",$shindan_id);

if($prefix == 'mb_'){
	$smarty->registerFilter("output","SJIS_Encoding");
	$smarty -> assign('charset','Shift_JIS');
}

require_once(_MODULE_DIR."admin_mode.inc.php");


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('detail.tpl');

?>

