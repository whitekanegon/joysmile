<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$kubun_id = $_GET["id"];

//年代データをセット
if($kubun_id){
/*
	$sql = "select * from sh_kubun where id = {$kubun_id}";
	list($data, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
	*/
	if($kubun_id != 1) header("location: index.php");
}else{
	header("location: index.php");
}

//カテゴリをセット
$TABLE_DATA = relation_tables();

foreach($TABLE_DATA["shindan"] as $row){
	$sql_cate[$row["id"]] = <<<EOS
	select id,shindan,photo_header,photo_first,photo_mdl,photo_end,age,sex,kansou from sh_main where
	shindan = {$row["id"]}	and
	kubun = 1
	and shitagaki = 0
	order by id desc
EOS;
}

foreach($sql_cate as $shindan_key => $sql){
	list($cate, $count) =  select_arrays($conn,$sql);
	foreach($cate as $key => $val){
		$cate[$key]["sex_ex"] = sex_str($cate[$key]["age"],$cate[$key]["sex"]);
		if($cate[$key]["kansou"])	$cate[$key]["kansou_mark"] = '★';
		$cate[$key]["photo_first"] = explode(",",$cate[$key]["photo_first"]);
		$cate[$key]["photo_mdl"] = explode(",",$cate[$key]["photo_mdl"]);
		$cate[$key]["photo_end"] = explode(",",$cate[$key]["photo_end"]);
	}
	if($shindan_key < 5 || $shindan_key == 6){
		$shindan_cate[] = $cate;
		$shindan_keys[] = $shindan_key;
		$category_title[] = $TABLE_DATA["shindan"][$shindan_key - 1];
	}else{
		$shindan_cate_others[] = $cate;
	}
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
$smarty -> assign('shindan_keys',$shindan_keys);
$smarty -> assign('category_title',$category_title);
$smarty -> assign('shindan_cate_others',$shindan_cate_others);

if($prefix == 'mb_'){
	$smarty->registerFilter("output","SJIS_Encoding");
	$smarty -> assign('charset','Shift_JIS');
}

require_once(_MODULE_DIR."admin_mode.inc.php");

//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('kubun.tpl');

?>

