<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$shindan_id = $_GET["id"];

//診断データをセット
if($shindan_id){
	$sql = "select * from sh_shindan where id = {$shindan_id}";
	list($data, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}else{
	header("location: index.php");
}

$data[0]["explanation"] = nl2br($data[0]["explanation"]);
$data[0]["explanation_short"] = nl2br($data[0]["explanation_short"]);
$data[0]["related_title"] = explode(",",$data[0]["related_title"]);
$data[0]["related_url"] = explode(",",$data[0]["related_url"]);

//カテゴリをセット
$TABLE_DATA = relation_tables();

$category_title[] = "{$TABLE_DATA["shiretsu"][1]["name"]}　{$TABLE_DATA["basshi"][1]["name"]}";
$category_title[] = "{$TABLE_DATA["shiretsu"][1]["name"]}　{$TABLE_DATA["basshi"][0]["name"]}";
$category_title[] = "{$TABLE_DATA["shiretsu"][2]["name"]}　{$TABLE_DATA["basshi"][1]["name"]}";
$category_title[] = "{$TABLE_DATA["shiretsu"][2]["name"]}　{$TABLE_DATA["basshi"][0]["name"]}";

//追加カテゴリ
$category_title[] = "{$TABLE_DATA["basshi"][2]["name"]}";
$category_title[] = "{$TABLE_DATA["basshi"][3]["name"]}";

$sql_cate[] = "select id,photo_header,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and (shiretsu = 1 or shiretsu = 2) and basshi = 2 and shitagaki = 0 and kubun = 0 order by id desc";
$sql_cate[] = "select id,photo_header,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and (shiretsu = 1 or shiretsu = 2) and basshi = 1 and shitagaki = 0 and kubun = 0 order by id desc";
$sql_cate[] = "select id,photo_header,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and shiretsu = 3 and basshi = 2 and shitagaki = 0 and kubun = 0 order by id desc";
$sql_cate[] = "select id,photo_header,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and shiretsu = 3 and basshi = 1 and shitagaki = 0 and kubun = 0 order by id desc";

//追加カテゴリ
$sql_cate[] = "select id,photo_header,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and basshi = 3 and shitagaki = 0 and kubun = 0 order by id desc";
$sql_cate[] = "select id,photo_header,age,sex,kansou,id from sh_main where shindan = {$shindan_id} and basshi = 4 and shitagaki = 0 and kubun = 0 order by id desc";

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
$smarty -> assign('category_title',$category_title);
$smarty -> assign('shindan_id',$shindan_id);

if($prefix == 'mb_'){
	$smarty->registerFilter("output","SJIS_Encoding");
	$smarty -> assign('charset','Shift_JIS');
}

require_once(_MODULE_DIR."admin_mode.inc.php");


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('shindan.tpl');

?>

