<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_DEFAULT);
session_start();

$edit_id = $_GET["id"];
if(isset($_GET["ikkatsu"])){
	$_SESSION["ikkatsu"] = $_GET["ikkatsu"];
}


if($_SESSION["mode"] == "regist"){
	$data_dmy[0] = $_SESSION;
}
elseif($edit_id){
	$conn = db_connect(_DSN);
	//$sql = 'select * from sh_main where id = '.$edit_id;
	$sql = db_tbl_alljoin(0,0,"id = {$edit_id}",1);
	list($main_data, $maincount) =  select_arrays($conn,$sql);
	if(!$maincount) header("location: index.php");
	$data_dmy[0] = $main_data[0];
	$data_dmy[0]["photo_first"] = explode(",",$data_dmy[0]["photo_first"]);
	$data_dmy[0]["photo_mdl"] = explode(",",$data_dmy[0]["photo_mdl"]);
	$data_dmy[0]["photo_end"] = explode(",",$data_dmy[0]["photo_end"]);
	if(!$_SESSION["photo_header"])	$_SESSION["photo_header"] = $data_dmy[0]["photo_header"];
	if(!$_SESSION["photo_first"])	$_SESSION["photo_first"] = $data_dmy[0]["photo_first"];
	if(!$_SESSION["photo_mdl"])	$_SESSION["photo_mdl"] = $data_dmy[0]["photo_mdl"];
	if(!$_SESSION["photo_end"])	$_SESSION["photo_end"] = $data_dmy[0]["photo_end"];
}
elseif($_SESSION["mode"] == "update"){
	$data_dmy[0] = $_SESSION;
}else{
	header("location: index.php");
}

//全リレーションテーブルをjoin
$data_dmy = all_join_table($data_dmy);

//改行を変換
$data_dmy[0]["thisinfo"] = nl2br($data_dmy[0]["thisinfo"]);
$data_dmy[0]["kansou"] = nl2br($data_dmy[0]["kansou"]);
$data_dmy[0]["comment"] = nl2br($data_dmy[0]["comment"]);
$data_dmy[0]["sex_ex"] = sex_str($data_dmy[0]["age"],$data_dmy[0]["sex"]);

$data_dmy[0]["shindan_sub"] = str_replace(",","、",$data_dmy[0]["shindan_sub"]);
$data_dmy[0]["souchi"] = str_replace(",","、",$data_dmy[0]["souchi"]);
$data_dmy[0]["tantou"] = str_replace(",","、",$data_dmy[0]["tantou"]);

if(!$data_dmy[0]["basshi_bui"]){
	$data_dmy[0]["basshi_bui"] = '';
}

//if(!$data_dmy[0]["tantou"]){
//	$data_dmy[0]["tantou"] = '';
//}

if($data_dmy[0]["photo_first"]){
foreach($data_dmy[0]["photo_first"] as $key => $val){
	$cross_num_real = $cross_num;
	($data_dmy[0]["photo_mdl"][$key]) ? $mdl = '<a href="../'.$data_dmy[0]["photo_mdl"][$key].'.jpg" rel="lightbox">'._PHOTO_MDL.'</a>' :		$mdl = _PHOTO_MDL;
	($data_dmy[0]["photo_end"][$key]) ? $end = '<a href="../'.$data_dmy[0]["photo_end"][$key].'.jpg" rel="lightbox">'._PHOTO_END.'</a>' :		$end = _PHOTO_END;
	$data_dmy[0]["crossLink"]["photo_first"][$key] = '<strong>'._PHOTO_FIRST.'</strong>｜'.$mdl.'｜'.$end;
}
}

if($data_dmy[0]["photo_mdl"]){
foreach($data_dmy[0]["photo_mdl"] as $key => $val){
	($data_dmy[0]["photo_first"][$key]) ? $fst = '<a href="../'.$data_dmy[0]["photo_first"][$key].'.jpg" rel="lightbox">'._PHOTO_FIRST.'</a>' :		$fst = _PHOTO_FIRST;
	($data_dmy[0]["photo_end"][$key]) ? $end = '<a href="../'.$data_dmy[0]["photo_end"][$key].'.jpg" rel="lightbox">'._PHOTO_END.'</a>' :		$end = _PHOTO_END;
	$data_dmy[0]["crossLink"]["photo_mdl"][$key] = $fst.'｜<strong>'._PHOTO_MDL.'</strong>｜'.$end;
}
}

if($data_dmy[0]["photo_end"]){
foreach($data_dmy[0]["photo_end"] as $key => $val){
	($data_dmy[0]["photo_first"][$key]) ? $fst = '<a href="../'.$data_dmy[0]["photo_first"][$key].'.jpg" rel="lightbox">'._PHOTO_FIRST.'</a>' :		$fst = _PHOTO_FIRST;
	($data_dmy[0]["photo_mdl"][$key]) ? $mdl = '<a href="../'.$data_dmy[0]["photo_mdl"][$key].'.jpg" rel="lightbox">'._PHOTO_MDL.'</a>' :		$mdl = _PHOTO_MDL;
	$data_dmy[0]["crossLink"]["photo_end"][$key] = $fst.'｜'.$mdl.'｜<strong>'._PHOTO_END.'</strong>';
}
}

$photo = photo_array();

require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

$smarty -> assign("session_real",$_SESSION);
$smarty -> assign("session",$data_dmy[0]);
$smarty -> assign("edit_id",$edit_id);
$smarty -> assign("photo",$photo);
$smarty -> assign('ikkatsu',$_SESSION["ikkatsu"]);

//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('admin_kiji_confirm.tpl');

?>

