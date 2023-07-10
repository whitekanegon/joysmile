<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");


$conn = db_connect(_DSN);

$TABLE_DATA = relation_tables();

$get_count = 0;
foreach($_GET as $key => $row){
	if($key == "x" || $key == "y") continue;
	if(!is_array($row)){
	$enc = mb_detect_encoding($row);
	if($enc == 'SJIS'){
		$row = mb_convert_encoding($row,"UTF-8","SJIS"); 
	}
	}
	$item = array();
	if($key == "sex" && $row){
		$search_item[$key]["result"] = $row."性";
		$search_item[$key]["name"] = item_name($key);
		$sql_item[] = "{$key} = '{$row}'";
		$get_count++;
	}
	elseif($key == "kansou" && $row){
		$search_item[$key]["result"] = $row;
		$search_item[$key]["name"] = item_name($key);
		if($row == "あり"){
			$sql_item[] = "{$key} not like ''";
		}else{
			$sql_item[] = "{$key} = ''";
		}
		$get_count++;
	}
	elseif($key == "side_others" && $row){
		if(ereg(":",$row)){
			$others_pair = explode(":",$row);
			foreach($others_pair as $o_val){
				$others = explode("=",$o_val);
				$sql_item[] = "{$others[0]} = '{$others[1]}'";
				$search_item[$others[0]]["result"] = $TABLE_DATA[$others[0]][$others[1] - 1]["name"];
				$search_item[$others[0]]["name"] = item_name($others[0]);
			}
			$sql_item = join(" and ",$sql_item);
		}else{
			$others = explode("=",$row);
			$sql_item = "{$others[0]} = '{$others[1]}'";
			if($others[0] == "sex"){
				$search_item[$others[0]]["result"] = $others[1]."性";
				$search_item[$others[0]]["name"] = item_name($others[0]);
			}else{
				$search_item[$others[0]]["result"] = $TABLE_DATA[$others[0]][$others[1] - 1]["name"];
				$search_item[$others[0]]["name"] = item_name($others[0]);
			}
		}
		$get_count++;
	}
	elseif($key == "freeword" && $row){
		
		$s_con = $_GET["s_con"];

		$row = mb_convert_kana($row,"s","utf-8");
		$keyword = explode(" ", $row);
		$sql_freeword = db_tbl_alljoin($keyword,$s_con,0,0);
		$word_count = count($keyword);
		if($word_count > 1) $str = "　（{$s_con} 検索）";
		$search_item[$key]["result"] = $row.$str;
		$search_item[$key]["name"] = "ワード";
		$value_word = $row;
		$get_count++;
	}
	else{
		if(is_array($row)){
			foreach($row as $val){
				if($val == 99){
					$sonota = end($TABLE_DATA[$key]);
					$item[] = $sonota["name"];
				}else{
					foreach($TABLE_DATA[$key] as $sk => $sv){
						if($sv["id"] == $val){
							$item[] = $sv["name"];
						}
					}
				}
			}
			
			$search_item[$key]["result"] = join("／",$item);
			$search_item[$key]["name"] = item_name($key);
			if($key == "souchi" || $key == "tantou"){
				foreach($row as $val){
					$sql_item_child[] = "FIND_IN_SET({$val},{$key})";
				}
				$sql_item[] = join(" or ",$sql_item_child);
			}
			elseif($key == "nendai"){
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
	$sql = "select * from sh_main where shitagaki = 0 and kubun = 0 order by id";
	list($data, $count) =  select_arrays($conn,$sql);
}
else{
	if($_GET["freeword"]){
		$sql_freeword;
		list($data, $count) =  select_arrays($conn,$sql_freeword);
	}
	elseif($_GET["side_others"]){
		$sql_item_all = $sql_item;
	$sql = <<<EOS
	select * from sh_main where
	({$sql_item_all})
	and shitagaki = 0 and kubun = 0
	order by id
EOS;
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
	and shitagaki = 0 and kubun = 0
	order by id
EOS;
	list($data, $count) =  select_arrays($conn,$sql);
	}
}

//テーブル整形
if(!$_GET["freeword"]){
foreach($data as $key => $val){
	$data[$key]["sex_ex"] = sex_str($val["age"],$val["sex"]);
	if($val["kansou"])	$data[$key]["kansou_mark"] = '★';
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
			//$shindan_sub[$k] = $TABLE_DATA["shindan"][$v - 1]["name"];
		}
		$data[$key]["shindan_sub"] = join("、",$shindan_sub);
	}
	
	if($data[$key]["souchi"]){
		$souchi = explode(",",$data[$key]["souchi"]);
		foreach($souchi as $k => $v){
			foreach($TABLE_DATA["souchi"] as $sk => $sv){
				if($sv["id"] == $v){
					$souchi[$k] = $sv["name"];
				}
			}
			//$souchi[$k] = $TABLE_DATA["souchi"][$v - 1]["name"];
		}
		$data[$key]["souchi"] = join("、",$souchi);
	}

	if($data[$key]["tantou"]){
		$tantou = explode(",",$data[$key]["tantou"]);
		foreach($tantou as $k => $v){
			foreach($TABLE_DATA["tantou"] as $sk => $sv){
				if($sv["id"] == $v){
					$tantou[$k] = $sv["name"];
				}
			}
			//$tantou[$k] = $TABLE_DATA["tantou"][$v - 1]["name"];
		}
		$data[$key]["tantou"] = join("、",$tantou);
	}
}
}else{
foreach($data as $key => $val){
	if($val["kansou"])	$data[$key]["kansou_mark"] = '★';
	$data[$key]["sex_ex"] = sex_str($val["age"],$val["sex"]);
	}
}

foreach($data as $key => $val){
	$data[$key]["thisinfo"] = mb_substr($data[$key]["thisinfo"],0,40,"utf-8")."...";
}

	
require_once('Smarty.class.php');

$smarty = new Smarty();
$smarty -> template_dir = _SMARTY_TEMPLATES_DIR;
$smarty -> compile_dir = _SMARTY_TEMPLATES_C_DIR;
$smarty -> config_dir = _SMARTY_CONFIG_DIR;
$smarty -> cache_dir = _SMARTY_CACHE_DIR;

//サイドメニュー読込
require_once("sidemenu.php");

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

$smarty->display('search_result.tpl');

?>

