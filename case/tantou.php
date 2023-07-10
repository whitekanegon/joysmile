<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$tantou_id = $_GET["id"];

//担当者データをセット
if($tantou_id){
	$sql = "select * from sh_tantou where id = {$tantou_id}";
	list($data, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}else{
	header("location: index.php");
}

//カテゴリをセット
$TABLE_DATA = relation_tables();

foreach($TABLE_DATA["shindan"] as $row){
	$sql_cate[] = <<<EOS
	select id,shindan,photo_header,age,tantou,sex,kansou from sh_main where
	shindan = {$row["id"]}	and
	FIND_IN_SET($tantou_id,tantou)
	and shitagaki = 0 and kubun = 0
	order by id desc
EOS;
}

foreach($sql_cate as $sql){
	list($cate, $count) =  select_arrays($conn,$sql);
	foreach($cate as $key => $val){
		$cate[$key]["sex_ex"] = sex_str($cate[$key]["age"],$cate[$key]["sex"]);
		if($cate[$key]["kansou"])	$cate[$key]["kansou_mark"] = '★';
	}
	$shindan_cate[] = $cate;
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
$smarty -> assign('shindan_cate',$shindan_cate);
$smarty -> assign('category_title',$TABLE_DATA["shindan"]);
$smarty -> assign('tantou_id',$tantou_id);

if($prefix == 'mb_'){
	$smarty->registerFilter("output","SJIS_Encoding");
	$smarty -> assign('charset','Shift_JIS');
}

require_once(_MODULE_DIR."admin_mode.inc.php");

//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('tantou.tpl');

?>

