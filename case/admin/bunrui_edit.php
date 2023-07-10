<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_BUNRUI);
session_start();

$bunrui_name = bunrui_name();

$conn = db_connect(_DSN);

if($_GET["id"]) $_SESSION["edit_id"] = $_GET["id"];
if($_GET["mode"]) $_SESSION["mode"] = $_GET["mode"];

if(!$_SESSION["edit_id"] && $_SESSION["mode"] != 'regist_bunrui'){
	header("location: index.php");
}

if($_SESSION["edit_id"]){
	//idの一致するデータを取得
	$sql = 'select * from sh_'.$_SESSION["bid"].' where id = '.$_SESSION["edit_id"];
	list($data, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}

if($_SESSION["bid"] == "shindan"){
	if(!$_SESSION["photo_header"]){
		$_SESSION["photo_header"] = $data[0]["photo_header"];
	}else{
		$data[0]["photo_header"] = $_SESSION["photo_header"];
	}
}

if($_SESSION["mode"]){
	$data[0] = $_SESSION;
}

switch($_SESSION["bid"]){
	case "shindan":
		$data[0]["related_title"] = explode(",",$data[0]["related_title"]);
		$data[0]["related_url"] = explode(",",$data[0]["related_url"]);
	break;
	
	case "nendai":
		$data[0]["generation"] = explode(",",$data[0]["generation"]);
		//年齢のセレクトボックス生成
		$age_option = age_option();
	break;

	default:
}


require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

$smarty -> assign('session_name',session_name());
$smarty -> assign('session_real',$_SESSION);
$smarty -> assign('bid',$_SESSION["bid"]);
$smarty -> assign('edit_id',$_SESSION["edit_id"]);
$smarty -> assign('bunrui_name',$bunrui_name[$_SESSION["bid"]]);
$smarty -> assign('data',$data[0]);
$smarty -> assign('bunrui_id_options', bunrui_id($_SESSION["bid"]));
if($_SESSION["bid"] == 'nendai'){
	$smarty -> assign('age_option',$age_option);
}



$smarty->display('admin_bunrui_edit.tpl');


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;



?>

