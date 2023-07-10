<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_DEFAULT);
session_start();

$conn = db_connect(_DSN);

//mainを全て取り出す
$sql = 'select * from sh_main order by date desc';
list($data, $count) =  select_arrays($conn,$sql);

//全リレーションテーブルをjoin
//$data = all_join_table($data);

$TABLE_DATA = relation_tables();

foreach($data as $key => $val){
	$data[$key]["shiretsu"] = $TABLE_DATA["shiretsu"][$data[$key]["shiretsu"] - 1]["name"];
	$data[$key]["basshi"] = $TABLE_DATA["basshi"][$data[$key]["basshi"] -1]["name"];
	$tantou_array = explode(",",$data[$key]["tantou"]);
	foreach($tantou_array as $tantou_key => $tantou_val){
		$tantou_array[$tantou_key] = $TABLE_DATA["tantou"][$tantou_val -1]["name"];
	}
	$data[$key]["tantou"] = implode("<br />",$tantou_array);
	if($data[$key]["shindan"] == 99){
		$sonota = end($TABLE_DATA["shindan"]);
		$data[$key]["shindan"] = $sonota["name"];
	}else{
		$data[$key]["shindan"] = $TABLE_DATA["shindan"][$data[$key]["shindan"] -1]["name"];
	}
	if($data[$key]["case_num"] == 0) $data[$key]["case_num"] = '';
}

//性別、感想、コメント、日付を変換
$data = change_listcolumn($data);

require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

$smarty -> assign('data',$data);
$smarty -> assign('db_msg',$_SESSION['db_msg']);
$smarty -> assign('post',$_POST);
$smarty -> assign('insert_id',$_SESSION['insert_id']);

$_SESSION = array();
if (isset($_COOKIE[session_name()])) {
    setcookie(session_name(), '', time()-42000, '/');
}
session_destroy();

$smarty->display('admin_index.tpl');


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;



?>

