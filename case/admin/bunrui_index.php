<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_BUNRUI);
session_start();

$bunrui_name = bunrui_name();

$_SESSION["bid"] = $_GET["bid"];
$db_msg = $_SESSION['db_msg'];
$insert_id = $_SESSION['insert_id'];

if($_SESSION["bid"]){
	//bid以外のセッションを破棄
	foreach($_SESSION as $key => $val){
		if($key != "bid"){
			unset($_SESSION[$key]);
		}
	}
	//bidのテーブルが存在しない場合、トップへ遷移
	$TABLE_DATA = relation_tables();
	if(!$TABLE_DATA[$_SESSION["bid"]]) header("location: index.php");
}
else{
	header("location: index.php");
}

$conn = db_connect(_DSN);

//mainを全て取り出す
$sql = 'select * from sh_'.$_SESSION["bid"].' order by id';
list($data, $count) =  select_arrays($conn,$sql);

switch($_SESSION["bid"]){
	case "nendai":
		foreach($data as $key => $val){
			$data[$key]["generation"] = explode(",",$data[$key]["generation"]);
		}
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
$smarty -> assign('data',$data);
$smarty -> assign('db_msg',$db_msg);
$smarty -> assign('insert_id',$insert_id);


$smarty->display('admin_bunrui_index.tpl');


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;



?>

