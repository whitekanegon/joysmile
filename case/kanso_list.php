<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");

$_GET["kansou"] = 'あり';

$conn = db_connect(_DSN);

if($_GET["shindan"][0]){
	$sql = "select * from sh_shindan where id = {$_GET["shindan"][0]}";
	list($dummy, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}

if($_GET["nendai"][0]){
	$sql = "select * from sh_nendai where id = {$_GET["nendai"][0]}";
	list($dummy, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}

if($_GET["tantou"][0]){
	$sql = "select * from sh_tantou where id = {$_GET["tantou"][0]}";
	list($dummy, $count) =  select_arrays($conn,$sql);
	if(!$count) header("location: index.php");
}

$TABLE_DATA = relation_tables();

$get_count = 0;
foreach($_GET as $key => $row){
	if($key == "x" || $key == "y") continue;
	$enc = mb_detect_encoding($row);
	if($enc == 'SJIS'){
		$row = mb_convert_encoding($row,"UTF-8","SJIS"); 
	}
	$item = array();
	if($key == "kansou" && $row){
		$search_item[$key]["result"] = $row;
		$search_item[$key]["name"] = item_name($key);
		if($row == "あり"){
			$sql_item[] = "{$key} not like ''";
		}else{
			$sql_item[] = "{$key} = ''";
		}
		$get_count++;
	}
	else{
		if(is_array($row)){
			
			$search_item[$key]["result"] = join("／",$item);
			$search_item[$key]["name"] = item_name($key);
			if($key == "nendai"){
				foreach($row as $n_key){
					$nendai_con = explode(",",$TABLE_DATA[$key][$n_key - 1]["generation"]);
					$sql_item_child[] = "age between {$nendai_con[0]} and {$nendai_con[1]}";
				}
				$sql_item[] = "(".join(" or ",$sql_item_child).")";
			}
			else{
				if($key == "shindan"){
					foreach($row as $val){
						$sql_item_child[] = "FIND_IN_SET({$val},shindan_sub)";
					}
					$sql_item_shindan = "FIND_IN_SET({$key},'".join(",",$row)."')";
					$sql_item_shindan_sub = join(" or ",$sql_item_child);
				}else{
					$sql_item[] = "FIND_IN_SET({$key},'".join(",",$row)."')";
				}
			}
			$get_count++;
		}
	}
	
}

if(!$get_count){
	//$sql = db_tbl_alljoin(0,0,'id > 0',0);
	$sql = "select * from sh_main where shitagaki = 0 and kubun = 0 order by id DESC";
	list($data, $count) =  select_arrays($conn,$sql);
}
else{
		if($sql_item){
			$sql_item_all = join(" and ",$sql_item);
			if($sql_item_shindan) $sql_item_all = $sql_item_all." and (".$sql_item_shindan." or ".$sql_item_shindan_sub.")";
		}else{
			$sql_item_all = $sql_item_shindan." or ".$sql_item_shindan_sub;
		}
	$sql = <<<EOS
	select * from sh_main where
	({$sql_item_all})
	and shitagaki = 0
	order by id DESC
EOS;
	list($data, $count) =  select_arrays($conn,$sql);
}

//テーブル整形
foreach($data as $key => $val){
	$data[$key]["sex_ex"] = sex_str($val["age"],$val["sex"]);
	$data[$key]["kansou"] = nl2br($data[$key]["kansou"]);
	$data[$key]["shiretsu"] = $TABLE_DATA["shiretsu"][$val["shiretsu"] - 1]["name"];
	$data[$key]["basshi"] = $TABLE_DATA["basshi"][$val["basshi"] -1]["name"];
	
	if($data[$key]["shindan"] == 99){
		$sonota = end($TABLE_DATA["shindan"]);
		$data[$key]["shindan"] = $sonota["name"];
	}else{
		$data[$key]["shindan"] = $TABLE_DATA["shindan"][$val["shindan"] -1]["name"];
	}

	if($data[$key]["basshi_bui"]){
		$data[$key]["basshi_bui"] = $TABLE_DATA["basshi_bui"][$val["basshi_bui"] -1]["name"];
	}
	
	if($data[$key]["shindan_sub"]){
		$shindan_sub = explode(",",$data[$key]["shindan_sub"]);
		foreach($shindan_sub as $k => $v){
			foreach($TABLE_DATA["shindan"] as $sk => $sv){
				if($sv["id"] == $v){
					$shindan_sub[$k] = $sv["name"];
				}
			}
		}
		$data[$key]["shindan_sub"] = join("、",$shindan_sub);
	}
	
	if($data[$key]["tantou"]){
		$tantou = explode(",",$data[$key]["tantou"]);
		foreach($tantou as $k => $v){
			foreach($TABLE_DATA["tantou"] as $sk => $sv){
				if($sv["id"] == $v){
					$tantou[$k] = $sv["name"];
				}
			}
		}
		$data[$key]["tantou"] = join("、",$tantou);
	}
}

if($_GET["shindan"][0])	{
	if($_GET["shindan"][0] == 99){
		$sonota = end($TABLE_DATA["shindan"]);
		$category_name[] = $sonota["name"];
	}else{
		$category_name[] = $TABLE_DATA["shindan"][$_GET["shindan"][0] -1]["name"];
	}
	$category_str[] = "診断：".end($category_name);
	$category_code[] = $_GET["shindan"][0];
	$category_type[] = "shindan";
}
if($_GET["nendai"][0])	{
	$category_name[] = $TABLE_DATA["nendai"][$_GET["nendai"][0] -1]["name"];
	$category_str[] = "年代：".end($category_name);
	$category_code[] = $_GET["nendai"][0];
	$category_type[] = "nendai";
}
if($_GET["tantou"][0])	{
	$category_name[] = $TABLE_DATA["tantou"][$_GET["tantou"][0] -1]["name"];
	$category_str[] = "担当医：".end($category_name);
	$category_code[] = $_GET["tantou"][0];
	$category_type[] = "tantou";
}

if(count($category_str)){
	$category = join("／",$category_str);
}else{
	$category = "全ての症例";
}
	
require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

//サイドメニュー読込
require_once("sidemenu.php");
if(count($category_code) == 1){
	$smarty -> assign('category_name',$category_name[0]);
	$smarty -> assign('category_code',$category_code[0]);
	$smarty -> assign('category_type',$category_type[0]);
}
$smarty -> assign('category',$category);
$smarty -> assign('data',$data);
$smarty -> assign('hit_id',$hit_id);
$smarty -> assign('post',$_GET);
$smarty -> assign('search_item',$search_item);
$smarty -> assign('post_count',$get_count);
$smarty -> assign('count',$count);
$smarty -> assign('sql',$sql);
$smarty -> assign('sword',$value_word);
$smarty -> assign('hit_id_orap',$ovarrap);
$smarty -> assign('hit_id_check',$hit_id_check);
$smarty -> assign('hit_id_dmy',$hit_id_dmy);

if($prefix == 'mb_'){
	$smarty->registerFilter("output","SJIS_Encoding");
	$smarty -> assign('charset','Shift_JIS');
}

require_once(_MODULE_DIR."admin_mode.inc.php");


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('kanso_list.tpl');

?>

