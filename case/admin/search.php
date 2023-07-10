<?php

require_once("../php_libs/config/config.inc.php");
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
list($shindan,$shindan_count) = side_shindan($conn);
list($nendai,$nendai_count) = side_nendai($conn);
$smarty -> assign('all_count',side_all_count($conn));
$smarty -> assign('shindan',$shindan);
$smarty -> assign('shindan_count',$shindan_count);
$smarty -> assign('nendai',$nendai);
$smarty -> assign('nendai_count',$nendai_count);

$smarty -> assign('data',$TABLE_DATA);


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('admin_search.tpl');

?>

