<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_DEFAULT);
session_start();

$conn = db_connect(_DSN);

//リレーショナルテーブル読込
$TABLE_DATA = relation_tables();
foreach($TABLE_DATA["souchi"] as $key => $val){
	$TABLE_DATA["souchi"][$key]["name"] = ereg_replace("エッジワイズ装置","エッジワイズ装置<br />",$val["name"]);
}

foreach($TABLE_DATA["shindan"] as $key => $val){
	if(ereg("10|11|12|13",$val["id"])) continue;
	$TABLE_DATA["shindan_main"][$key] = $val;
}


//年齢のセレクトボックス生成
$age_option = age_option();

$edit_id = $_GET["id"];


//idの一致するデータを取得
if($edit_id){
	$sql = 'select * from sh_main where id = '.$edit_id;
	list($main_data, $maincount) =  select_arrays($conn,$sql);

	if($_SESSION["mode"]){
		$data_dmy = $_SESSION;
	}else{
		$data_dmy = $main_data[0];
	}

}else{
	if($_SESSION["mode"] == 'regist'){
		$data_dmy = $_SESSION;
	}else{
		$_SESSION = array();
		if (isset($_COOKIE[session_name()])) {
		    setcookie(session_name(), '', time()-42000, '/');
		}
		session_destroy();
	}
}

require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

foreach($TABLE_DATA as $key => $val){
	$smarty -> assign($key,$val);
}

//カンマ区切りのデータを配列に変換
$data_dmy["shindan_sub"] = explode(",",$data_dmy["shindan_sub"]);
$data_dmy["souchi"] = explode(",",$data_dmy["souchi"]);
$data_dmy["tantou"] = explode(",",$data_dmy["tantou"]);

//性別の接尾語を設定
$data_dmy["sex_ex"] = sex_str($data_dmy["age"],$data_dmy["sex"]);

foreach($data_dmy as $key => $val){
	$smarty -> assign("main_".$key,$val);
}
$smarty -> assign("session",$data_dmy);
$smarty -> assign('age_option',$age_option);
$smarty -> assign('edit_id',$edit_id);

//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('admin_kiji_edit.tpl');

?>

