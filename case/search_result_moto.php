<?php

require_once("php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");
require_once(_MODULE_DIR."screen.inc.php");

$conn = db_connect(_DSN);

$TABLE_DATA = relation_tables();

$get_count = 0;
foreach($_GET as $key => $row){
	if($key == "x" || $key == "y") continue;
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
		$sql_word = "select * from sh_main where shitagaki = 0 order by id";
		list($all_data, $count) =  select_arrays($conn,$sql_word);
		
		$s_con = $_GET["s_con"];
		$hit_id = array();
		
		$row = mb_convert_kana($row,"s","utf-8");
		$keyword = explode(" ", $row);
		foreach($keyword as $wk => $word){
			$hit_id_dmy[] = search_word($all_data,$word);
			//$hit_id = array_merge($hit_id,$hit_id_dmy);
		}
		foreach($hit_id_dmy as $hval){
			$hit_id = array_merge($hit_id,$hval);
		}
		$hit_id_check = $hit_id;
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
					$item[] = $TABLE_DATA[$key][$val - 1]["name"];
				}
			}
			
			$search_item[$key]["result"] = join("／",$item);
			$search_item[$key]["name"] = item_name($key);
			if($key == "souchi"){
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
	$sql = "select * from sh_main where shitagaki = 0 order by id";
	list($data, $count) =  select_arrays($conn,$sql);
}
else{
	if($_GET["freeword"]){
		if($hit_id){
			if($s_con == "AND" && $word_count > 1){
				$ovarrap = array_count_values($hit_id);
				foreach($hit_id as $k => $v){
					if($ovarrap[$v] > ($word_count - 1)) $hit_id_orap[] = $v;
				}
				($hit_id_orap) ?	$hit_id = $hit_id_orap : $no_flag = 1;
			}
			
			$hit_id = array_unique($hit_id);
			
			if(!$no_flag){
				foreach($hit_id as $id){
					$sql_item[] = "id = {$id}";
				}
				$sql_item_all = join(" or ",$sql_item);
			}else{	$sql_item_all = "age = 10000000000000";}
		}else{
			$sql_item_all = "age = 10000000000000";
		}
	}
	elseif($_GET["side_others"]){
		$sql_item_all = $sql_item;
	}
	else{
		if($sql_item){
			$sql_item_all = join(" and ",$sql_item);
			if($sql_item_shindan) $sql_item_all = $sql_item_all." and (".$sql_item_shindan." or ".$sql_item_shindan_sub.")";
		}else{
			$sql_item_all = $sql_item_shindan." or ".$sql_item_shindan_sub;
		}
	}
	$sql = <<<EOS
	select * from sh_main where
	({$sql_item_all})
	and shitagaki = 0
	order by id
EOS;
	list($data, $count) =  select_arrays($conn,$sql);
}

//テーブル整形

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
	
	if($data[$key]["tantou"]){
		$data[$key]["tantou"] = $TABLE_DATA["tantou"][$val["tantou"] -1]["name"];
	}
	
	if($data[$key]["basshi_bui"]){
		$data[$key]["basshi_bui"] = $TABLE_DATA["basshi_bui"][$val["basshi_bui"] -1]["name"];
	}
	
	if($data[$key]["shindan_sub"]){
		$shindan_sub = explode(",",$data[$key]["shindan_sub"]);
		foreach($shindan_sub as $k => $v){
			$shindan_sub[$k] = $TABLE_DATA["shindan"][$v - 1]["name"];
		}
		$data[$key]["shindan_sub"] = join("、",$shindan_sub);
	}
	
	if($data[$key]["souchi"]){
		$souchi = explode(",",$data[$key]["souchi"]);
		foreach($souchi as $k => $v){
			$souchi[$k] = $TABLE_DATA["souchi"][$v - 1]["name"];
		}
		$data[$key]["souchi"] = join("、",$souchi);
	}
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


//** 次の行のコメントをはずすと、デバッギングコンソールを表示します
#$smarty->debugging = true;

$smarty->display('search_result.tpl');

?>

