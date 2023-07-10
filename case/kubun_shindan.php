<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$shindan_id = $_GET["id"];

//診断データをセット
if($shindan_id){
	if($shindan_id != 'others'){
		$sql = "select * from sh_shindan where id = {$shindan_id}";
		list($data, $count) =  select_arrays($conn,$sql);
		if(!$count) header("location: index.php");
	}
}else{
	header("location: index.php");
}

//カテゴリをセット
$TABLE_DATA = relation_tables();

if($shindan_id == 'others'){
	$sql_cate[] = "select id,photo_header,photo_first,photo_mdl,photo_end	,age,sex,kansou,id from sh_main where shindan > 4 and shindan != 6 and kubun = 1 order by shindan asc, id desc";
} else {
	$sql_cate[] = "select id,photo_header,photo_first,photo_mdl,photo_end	,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and kubun = 1 order by id desc";
}

foreach($sql_cate as $sql){
	list($cate, $count) =  select_arrays($conn,$sql);
	foreach($cate as $key => $val){
		$cate[$key]["sex_ex"] = sex_str($cate[$key]["age"],$cate[$key]["sex"]);
		if($cate[$key]["kansou"])	$cate[$key]["kansou_mark"] = '★';
		$cate[$key]["photo_first"] = explode(",",$cate[$key]["photo_first"]);
		$cate[$key]["photo_mdl"] = explode(",",$cate[$key]["photo_mdl"]);
		$cate[$key]["photo_end"] = explode(",",$cate[$key]["photo_end"]);
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
$smarty -> assign('category_title',$category_title);
$smarty -> assign('shindan_id',$shindan_id);

if($prefix == 'mb_'){
	$smarty->registerFilter("output","SJIS_Encoding");
	$smarty -> assign('charset','Shift_JIS');
}

require_once(_MODULE_DIR."admin_mode.inc.php");


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('kubun_shindan.tpl');

?>

