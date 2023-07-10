<?php

//----------------------------------------------------
// サイドメニュー　全症例数
//----------------------------------------------------

function side_all_count($conn){
	$sql = "select * from sh_main where shitagaki = 0";
	$result = execute_sql($conn,$sql);
	$data_count = $result->numRows();

	return array($data_count);
}

//----------------------------------------------------
// サイドメニュー　診断別
//----------------------------------------------------

function side_shindan($conn){
	$sql = 'select * from sh_shindan where id not in (10,11,12,13) order by id';
	list($data, $count) =  select_arrays($conn,$sql);

	foreach($data as $row){
			$sql = "select * from sh_main where shindan = {$row["id"]} and shitagaki = 0";
			$result = execute_sql($conn,$sql);
			$data_count[] = $result->numRows();
	}
		return array($data,$data_count);
}

//----------------------------------------------------
// サイドメニュー　年代別
//----------------------------------------------------

function side_nendai($conn){
	$sql = 'select * from sh_nendai order by id';
	list($nendai, $count) =  select_arrays($conn,$sql);
	
	foreach($nendai as $row){
			$age = explode(",",$row["generation"]);
			$sql = "select * from sh_main where age between {$age[0]} and {$age[1]} and shitagaki = 0";
			$result = execute_sql($conn,$sql);
			$nendai_count[] = $result->numRows();
	}
		return array($nendai,$nendai_count);
}

//----------------------------------------------------
// サイドメニュー　担当医別
//----------------------------------------------------

function side_tantou($conn){
	$sql = 'select * from sh_tantou order by id';
	list($tantou, $count) =  select_arrays($conn,$sql);
	
	foreach($tantou as $row){
			$sql = "select * from sh_main where FIND_IN_SET({$row["id"]},tantou) and shitagaki = 0";
			$result = execute_sql($conn,$sql);
			$tantou_count[] = $result->numRows();
	}
		return array($tantou,$tantou_count);
}

//----------------------------------------------------
// 分類項目名を定義
//----------------------------------------------------

function item_name($key){
	switch($key){
		case "shindan":
			$name = "診断名";
			break;
		case "shiretsu":
			$name = "歯列";
			break;
		case "basshi":
			$name = "治療方針";
			break;
		case "basshi_bui":
			$name = "抜歯部位";
			break;
		case "nendai":
			$name = "年代";
			break;
		case "sex":
			$name = "性別";
			break;
		case "souchi":
			$name = "装置";
			break;
		case "tantou":
			$name = "担当医";
			break;
		case "kansou":
			$name = "感想";
			break;
		case "comment":
			$name = "コメント";
			break;
		default:
	}
	return $name;
}

//----------------------------------------------------
// キャリア別　テンプレートファイル選択
//----------------------------------------------------

function carrier_select($car){
	if($car == "sp"){
		$prefix = "sp_";
	}elseif($car == "mb"){
		$prefix = "mb_";
	}elseif($car == "fb"){
		$prefix = "fb_";
	}
	return $prefix;
}

//if(preg_match("/DoCoMo|J-PHONE|Vodafone|SoftBank|UP.Browser/i", $agent)){


//----------------------------------------------------
// 携帯出力用
//----------------------------------------------------

function SJIS_Encoding($tpl_output, &$smarty){
	$tpl_output = mb_convert_encoding($tpl_output,'SJIS','UTF-8');
	return $tpl_output;
}


?>