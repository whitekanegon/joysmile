<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_DEFAULT);
session_start();


if(isset($_POST['mode'])){
	$_SESSION["mode"] = addslashes($_POST['mode']);
	$_SESSION["shindan"]	= addslashes($_POST['shindan']);
	if(isset($_POST['shindan_sub'])){
		$_SESSION["shindan_sub"]	= addslashes(join(",",$_POST['shindan_sub']));
	}else{
		$_SESSION["shindan_sub"]	= "";
	}
	$_SESSION["shiretsu"] = addslashes($_POST['shiretsu']);
	$_SESSION["basshi"] = addslashes($_POST['basshi']);
	$_SESSION["basshi_bui"] = addslashes($_POST['basshi_bui']);
	$_SESSION["age"] = addslashes($_POST['age']);
	$_SESSION["sex"] = addslashes($_POST['sex']);
	$_SESSION["sex_ex"] = sex_str($_SESSION["age"],$_SESSION["sex"]);
	if(isset($_POST['souchi'])){
		$_SESSION["souchi"] = addslashes(join(",",$_POST['souchi']));
	}else{
		$_SESSION["souchi"]	= "";
	}
	if(isset($_POST['tantou'])){
		$_SESSION["tantou"] = addslashes(join(",",$_POST['tantou']));
	}else{
		$_SESSION["tantou"]	= "";
	}
	//$_SESSION["tantou"] = addslashes($_POST['tantou']);
	$_SESSION["case_num"] = addslashes($_POST['case_num']);
	$_SESSION["karte_num"] = addslashes($_POST['karte_num']);
	$_SESSION["thisinfo"] = addslashes($_POST['thisinfo']);
	$_SESSION["kansou"] = addslashes($_POST['kansou']);
	$_SESSION["comment"] = addslashes($_POST['comment']);
	if(isset($_POST['edit_id'])){
		$_SESSION["edit_id"] = $_POST['edit_id'];
		$conn = db_connect(_DSN);
		$sql = db_tbl_alljoin(0,0,"id = {$_POST['edit_id']}",1);
		list($main_data, $maincount) =  select_arrays($conn,$sql);
		if(!$maincount) header("location: index.php");
		$data_dmy[0] = $main_data[0];
		$_SESSION["photo_patient"] = $data_dmy[0]["photo_patient"];
		$_SESSION["photo_header"] = $data_dmy[0]["photo_header"];
		$_SESSION["photo_first"] = explode(",",$data_dmy[0]["photo_first"]);
		$_SESSION["photo_mdl"] = explode(",",$data_dmy[0]["photo_mdl"]);
		$_SESSION["photo_end"] = explode(",",$data_dmy[0]["photo_end"]);
	}
	$_POST['shitagaki'] ? $_SESSION["shitagaki"] = $_POST['shitagaki'] :	$_SESSION["shitagaki"] = "";
	$_POST['kubun'] ? $_SESSION["kubun"] = $_POST['kubun'] :	$_SESSION["kubun"] = "";
}

if(!isset($_SESSION['mode'])){
	header("location: index.php");
}

$session_dmy = $_SESSION;

$photo = photo_array();

require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

$smarty -> assign("session",$session_dmy);
$smarty -> assign("photo",$photo);
$smarty -> assign("edit_id",$_SESSION["edit_id"]);

//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('admin_kiji_img.tpl');

?>

