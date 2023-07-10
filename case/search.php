<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$TABLE_DATA = relation_tables();

foreach($TABLE_DATA["souchi"] as $key => $val){
	$TABLE_DATA["souchi"][$key]["name"] = ereg_replace("エッジワイズ装置","エッジワイズ装置<br />",$val["name"]);
}

require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

//サイドメニュー読込
require_once("sidemenu.php");

$smarty -> assign('data',$TABLE_DATA);
$smarty -> assign('search',1);

require_once(_MODULE_DIR."admin_mode.inc.php");


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('search.tpl');

?>

