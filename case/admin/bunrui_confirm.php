<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_BUNRUI);
session_start();

$bunrui_name = bunrui_name();

$conn = db_connect(_DSN);

if(isset($_POST['id']))	$_SESSION["id"] = addslashes($_POST['id']);
if(isset($_POST['edit_id'])) $_SESSION["edit_id"] = $_POST['edit_id'];
$_SESSION["mode"] = addslashes($_POST['mode']);
$_SESSION["name"]	= addslashes($_POST['name']);
	
switch($_SESSION["bid"]){
	case "shindan":
		$_SESSION["alias"] = addslashes($_POST['alias']);
		$_SESSION["dir"] = addslashes($_POST['dir']);
		$_SESSION["explanation"] = addslashes($_POST['explanation']);
		$_SESSION["explanation_short"] = addslashes($_POST['explanation_short']);
		if(isset($_POST['related_title'])){
			$_POST["related_title"] = array_merge(array_diff($_POST['related_title'], array("")));
			$_SESSION["related_title"] = addslashes(join(",",$_POST['related_title']));
		}
		if(isset($_POST['related_url'])){
			$_POST["related_url"] = array_merge(array_diff($_POST['related_url'], array("")));
			$_SESSION["related_url"] = addslashes(join(",",$_POST['related_url']));
		}
	break;
	
	case "nendai":
		$_SESSION["generation"] = addslashes(join(",",$_POST['generation']));
		$_SESSION["explanation"] = addslashes($_POST['explanation']);
	break;
	
	default:
	
}
	
if($_SESSION["mode"]){
	$data_dmy = $_SESSION;
}else{
	header("location: index.php");
}

$data_dmy["explanation"] = nl2br($data_dmy["explanation"]);
switch($_SESSION["bid"]){
	case "shindan":
		$data_dmy["explanation_short"] = nl2br($data_dmy["explanation_short"]);
		$data_dmy["related_title"] = explode(",",$data_dmy["related_title"]);
		$data_dmy["related_url"] = explode(",",$data_dmy["related_url"]);
	break;
	
	case "nendai":
		$data_dmy["generation"] = explode(",",$data_dmy["generation"]);
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
$smarty -> assign('bunrui_name',$bunrui_name[$_SESSION["bid"]]);
$smarty -> assign('session',$data_dmy);

$smarty->display('admin_bunrui_confirm.tpl');


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;



?>

