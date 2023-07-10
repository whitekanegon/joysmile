<?php

require_once("DB.php");

//----------------------------------------------------
// データベース接続
//----------------------------------------------------
function db_connect($dsn){
	$conn = DB::connect($dsn);

	// 接続に失敗したらメッセージを表示して終了します。
	if (DB::isError($conn)){ 
		die($conn->getMessage());
	}
	return $conn;
}

//----------------------------------------------------
// 検索結果を多次元配列で受け取る
//----------------------------------------------------
function select_arrays($conn, $sql){
	$result = execute_sql($conn, $sql);
	// レコードの取得
	$i=0;
	$data = array();
	while ($rec = $result->fetchRow(DB_FETCHMODE_ASSOC)) {
		foreach( $rec as $key => $value){
			//$value = sjis2euc_for_Winodows($value);
	    		$data[$i][$key] = $value;
		}
		$i++;
	}

	// 検索件数
	$count  = $result->numRows();

	// クエリー結果セットの開放
	$result->free();
	return array($data, $count);
}

//----------------------------------------------------
// SQL文の実行
//----------------------------------------------------
function execute_sql($conn,$sql){
	$result = $conn->query($sql);
	if(DB::isError($result)) {
		die ($result->getMessage());
	}
	return $result;
}


//----------------------------------------------------
// リレーションシップテーブルを多次元配列にセット
//----------------------------------------------------
function relation_tables(){
	$tbl_name = explode(",","sh_shindan,sh_nendai,sh_shiretsu,sh_basshi,sh_basshi_bui,sh_souchi,sh_tantou");
	$conn = db_connect(_DSN);
	foreach($tbl_name as $name){
		$sql = "select * from ".$name." order by id";
		list($data,$count) = select_arrays($conn, $sql);
		$TABLE_DATA[substr($name,3)] = $data;
	}
 return $TABLE_DATA;
}

//----------------------------------------------------
// メインテーブルに各テーブルを全結合
//----------------------------------------------------
function all_join_table($main_data){

	for($i=0; $i<count($main_data); $i++){
		foreach($main_data[$i] as $key => $value){
			if($key == 'shindan_sub' || $key == 'souchi' || $key == 'tantou'){
				$comma_val_ar = array();
				($key == 'shindan_sub') ? $key_dmy = 'shindan' : $key_dmy = $key;
				foreach(explode(",",$main_data[$i][$key]) as $comma_val){
					$comma_val_ar[] = join_table($key_dmy, $comma_val);
				}
				$main_data[$i][$key] = join(",",$comma_val_ar);
			}
			$main_data[$i][$key] = join_table($key, $main_data[$i][$key]);
		}
	}
	return $main_data;
}

function join_table($key,$val){
	$TABLE_DATA = relation_tables();
	if(is_array($TABLE_DATA[$key])){
		foreach($TABLE_DATA[$key] as $tbl_value){
			if($tbl_value["id"] == $val){
				$val = $tbl_value["name"];
			}
		}
	}
	return $val;
}


//----------------------------------------------------
// テーブルを全て結合
//----------------------------------------------------
function db_tbl_alljoin($keyword,$s_con,$sql_direct,$admin){
	$conn = db_connect(_DSN);
	$TABLE_DATA = relation_tables();
	
	$sql = "select id,shindan_sub,souchi,tantou from sh_main order by id";
	list($data ,$count) = select_arrays($conn, $sql);
	foreach($data as $key => $row){
		
		$shindan_sub = explode(",",$row["shindan_sub"]);
		if(is_array($shindan_sub)){
			foreach($shindan_sub as $k => $v){
				if( $TABLE_DATA["shindan"][$v - 1]){
					foreach($TABLE_DATA["shindan"] as $sk => $sv){
						if($sv["id"] == $v){
							$shindan_sub[$k] = $sv["name"];
							$shindan_sub_alias[$k] = $sv["alias"];
						}
					}
					//$shindan_sub[$k] = $TABLE_DATA["shindan"][$v - 1]["name"];
					//$shindan_sub_alias[$k] = $TABLE_DATA["shindan"][$v - 1]["alias"];
				}
				if($v == 99){
					$sonota = end($TABLE_DATA["shindan"]);
					$shindan_sub[$k] = $sonota["name"];
					$shindan_sub_alias[$k] = $sonota["alias"];
				}
			}
		}
		if(is_array($shindan_sub))	$shindan_sub = join(",",$shindan_sub);
		if(is_array($shindan_sub_alias))	$shindan_sub_alias = join(",",$shindan_sub_alias);
		$data[$key]["shindan_sub_change"] = $shindan_sub;
		$data[$key]["shindan_sub_change_alias"] = $shindan_sub_alias;
		
		$souchi = explode(",",$row["souchi"]);
		if(is_array($souchi)){
			foreach($souchi as $k => $v){
				foreach($TABLE_DATA["souchi"] as $sk => $sv){
					if($sv["id"] == $v){
						$souchi[$k] = $sv["name"];
					}
				}
				//if( $TABLE_DATA["souchi"][$v - 1])	$souchi[$k] = $TABLE_DATA["souchi"][$v - 1]["name"];
			}
		}
		$souchi = join(",",$souchi);
		$data[$key]["souchi_change"] = $souchi;

		$tantou = explode(",",$row["tantou"]);
		if(is_array($tantou)){
			foreach($tantou as $k => $v){
				foreach($TABLE_DATA["tantou"] as $sk => $sv){
					if($sv["id"] == $v){
						$tantou[$k] = $sv["name"];
					}
				}
			}
		}
		$tantou = join(",",$tantou);
		$data[$key]["tantou_change"] = $tantou;
	}
	
	$sql = <<<EOS
	create temporary table shindan_sub_tmp (id int(20), shindan_sub longtext, shindan_sub_alias longtext, souchi longtext, tantou longtext)
EOS;

 execute_sql($conn,$sql);
	
	foreach($data as $row){
	$sql = <<<EOS
	INSERT INTO shindan_sub_tmp 
	(id, shindan_sub, shindan_sub_alias, souchi, tantou)
	VALUES
	(
	'{$row["id"]}',
	'{$row["shindan_sub_change"]}',
	'{$row["shindan_sub_change_alias"]}',
	'{$row["souchi_change"]}',
	'{$row["tantou_change"]}'
	)
EOS;
		execute_sql($conn,$sql);
	}
	
	$field_tmp = array(
		'a.id',
		'b.name',
		'g.shindan_sub',
		'a.photo_patient',
		'a.photo_header',
		'a.photo_first',
		'a.photo_mdl',
		'a.photo_end',
		'c.name',
		'd.name',
		'e.name',
		'a.age',
		'a.sex',
		'g.souchi',
		'g.tantou',
		'a.case_num',
		'a.karte_num',
		'a.thisinfo',
		'a.kansou',
		'a.comment',
		'a.date',
		'a.shitagaki',
		'a.kubun'
);

$field = array(
		'id',
		'shindan',
		'shindan_sub',
		'photo_patient',
		'photo_header',
		'photo_first',
		'photo_mdl',
		'photo_end',
		'shiretsu',
		'basshi',
		'basshi_bui',
		'age',
		'sex',
		'souchi',
		'tantou',
		'case_num',
		'karte_num',
		'thisinfo',
		'kansou',
		'comment',
		'date',
		'shitagaki',
		'kubun'
);
	
	
	if($keyword && $s_con){
	$concat = <<<EOS
		concat(
		a.id,
		b.name,
		b.alias,
		g.shindan_sub,
		g.shindan_sub_alias,
		c.name,
		d.name,
		IFNULL(e.name,""),
		a.age,
		a.sex,
		IFNULL(g.souchi,""),
		IFNULL(g.tantou,""),
		a.case_num,
		a.karte_num,
		a.thisinfo,
		IFNULL(a.kansou,""),
		IFNULL(a.comment,"")) like 
EOS;
		foreach($keyword as $word){
			$sql_concat[] = $concat."'%".$word."%'";
		}
		$sql_concat_all = join(" {$s_con} ",$sql_concat);
	}else{
		$sql_direct = str_replace($field,$field_tmp,$sql_direct);
		$sql_concat_all = $sql_direct;
	}
	
	if(!$admin){
		$shitagaki = 'a.shitagaki = 0 and';
	}
	
	$sql = <<<EOS
		select 
		a.id,
		b.name as shindan,
		b.alias as shindan_alias,
		g.shindan_sub as shindan_sub,
		g.shindan_sub_alias as shindan_sub_alias,
		a.photo_patient,
		a.photo_header,
		a.photo_first,
		a.photo_mdl,
		a.photo_end,
		c.name as shiretsu,
		d.name as basshi,
		e.name as basshi_bui,
		a.age,
		a.sex,
		g.souchi as souchi,
		g.tantou as tantou,
		a.case_num,
		a.karte_num,
		a.thisinfo,
		a.kansou,
		a.comment,
		a.date,
		a.shitagaki,
		a.kubun
		from sh_main as a
		left join sh_shindan as b on a.shindan=b.id
		left join sh_shiretsu as c on a.shiretsu=c.id
		left join sh_basshi as d on a.basshi=d.id
		left join sh_basshi_bui as e on a.basshi_bui=e.id
		left join shindan_sub_tmp as g on a.id=g.id
		where
		{$shitagaki}
		{$sql_concat_all}
		order by id;
EOS;
return $sql;
}

//----------------------------------------------------
// テンポラリテーブルを削除
//----------------------------------------------------
function db_drop_tmptbl(){
	$conn = db_connect(_DSN);
	$sql = "drop table shindan_sub_tmp";
	execute_sql($conn,$sql);
}

//----------------------------------------------------
// 年齢による性別表記変換
//----------------------------------------------------
function sex_str($age,$sex){
	if($age <= 12){
		$sex_ex = "子";
	}else{
		$sex_ex = "性";
	}
	return $sex_ex;
}

//----------------------------------------------------
// 年齢セレクトボックス生成
//----------------------------------------------------
function age_option(){
	for($i=1; $i<101; $i++){
		$age_option[$i] = $i;
	}
	return $age_option;
}

//----------------------------------------------------
// 感想、コメントをマーク変換
//----------------------------------------------------
function set_mark($str){
	if($str) $str = '★';
	return $str;
}

//----------------------------------------------------
// 新規登録
//----------------------------------------------------

function db_regist($data,$conn){
	$data["photo_first"] = $data["photo_first"][0].','.$data["photo_first"][1].','.$data["photo_first"][2].','.$data["photo_first"][3];
	$data["photo_mdl"] = $data["photo_mdl"][0].','.$data["photo_mdl"][1].','.$data["photo_mdl"][2].','.$data["photo_mdl"][3];
	$data["photo_end"] = $data["photo_end"][0].','.$data["photo_end"][1].','.$data["photo_end"][2].','.$data["photo_end"][3];
	$sql = <<<EOS
	INSERT INTO sh_main 
	(id, shindan, shindan_sub, photo_patient, photo_header, photo_first, photo_mdl, photo_end, shiretsu, basshi, basshi_bui, age, sex, souchi, tantou, case_num, karte_num, thisinfo, kansou, comment, date, shitagaki, kubun )
	VALUES
	(
	NULL,
	'{$data['shindan']}',
	'{$data['shindan_sub']}',
	'{$data['photo_patient']}',
	'{$data['photo_header']}',
	'{$data['photo_first']}',
	'{$data['photo_mdl']}',
	'{$data['photo_end']}',
	'{$data['shiretsu']}',
	'{$data['basshi']}',
	'{$data['basshi_bui']}',
	'{$data['age']}',
	'{$data['sex']}',
	'{$data['souchi']}',
	'{$data['tantou']}',
	'{$data['case_num']}',
	'{$data['karte_num']}',
	'{$data['thisinfo']}',
	'{$data['kansou']}',
	'{$data['comment']}',
	now(),
	'{$data['shitagaki']}',
	'{$data['kubun']}'
	)
EOS;
	$result = execute_sql($conn, $sql);
	if(isset($result)){
		$db_msg = '「'.$data['age'].'歳・'.$data['sex'].sex_str($data['age'],$data['sex']).'」のデータを追加しました。';
	}
	return array($db_msg, mysql_insert_id());
}

//----------------------------------------------------
// 更新処理
//----------------------------------------------------

function db_update($data,$conn){
	$data["photo_first"] = join(",",$data["photo_first"]);
	$data["photo_mdl"] = join(",",$data["photo_mdl"]);
	$data["photo_end"] = join(",",$data["photo_end"]);
	$sql = <<<EOS
	UPDATE sh_main 
	SET 
	shindan = '{$data['shindan']}',
	shindan_sub = '{$data['shindan_sub']}',
	photo_patient = '{$data['photo_patient']}',
	photo_header = '{$data['photo_header']}',
	photo_first = '{$data['photo_first']}',
	photo_mdl = '{$data['photo_mdl']}',
	photo_end = '{$data['photo_end']}',
	shiretsu = '{$data['shiretsu']}',
	basshi = '{$data['basshi']}',
	basshi_bui = '{$data['basshi_bui']}',
	age = '{$data['age']}',
	sex = '{$data['sex']}',
	souchi = '{$data['souchi']}',
	tantou = '{$data['tantou']}',
	case_num = '{$data['case_num']}',
	karte_num = '{$data['karte_num']}',
	thisinfo = '{$data['thisinfo']}',
	kansou = '{$data['kansou']}',
	comment = '{$data['comment']}',
	date = now(), 
	shitagaki = '{$data['shitagaki']}',
	kubun = '{$data['kubun']}'
	WHERE 
	id = '{$data['edit_id']}'
EOS;
	$result = execute_sql($conn, $sql);
	if(isset($result)){
		$db_msg = 'ID：'.$data['edit_id'].'　のデータを更新しました。';
	}
	return array($db_msg, $data['edit_id']);
}

//----------------------------------------------------
// 削除処理
//----------------------------------------------------

function db_delete($id,$conn){
	foreach($id as $val){
		$sql = <<<EOS
			delete from sh_main where id = $val
EOS;
		 execute_sql($conn, $sql);
	}
	$db_msg = count($id).'件のデータを削除しました。';
	return $db_msg;
}


//----------------------------------------------------
// 分類項目　新規登録
//----------------------------------------------------

function db_bunrui_regist($data,$conn){
	$bid = $data["bid"];
	$others_tbl_name = "sh_".$bid;
	
	switch($bid){
	case 'shindan':
	$sql = <<<EOS
		INSERT INTO sh_shindan 
		(id, name, alias, dir, photo_header, explanation, explanation_short, related_title, related_url)
		VALUES
		(
		'{$data['id']}',
		'{$data['name']}',
		'{$data['alias']}',
		'{$data['dir']}',
		'{$data['photo_header']}',
		'{$data['explanation']}',
		'{$data['explanation_short']}',
		'{$data['related_title']}',
		'{$data['related_url']}'
		)
EOS;
	break;
	
	case 'nendai':
	$sql = <<<EOS
		INSERT INTO sh_nendai 
		(id, name, generation, explanation)
		VALUES
		(
		'{$data['id']}',
		'{$data['name']}',
		'{$data['generation']}',
		'{$data['explanation']}'
		)
EOS;
	break;
	
	default:
	$sql = <<<EOS
		INSERT INTO sh_{$bid} 
		(id, name, alias)
		VALUES
		(
		'{$data['id']}',
		'{$data['name']}',
		''
		)
EOS;
	}
	$result = execute_sql($conn, $sql);
	if(isset($result)){
		$bunrui_name = bunrui_name();
		$db_msg = $bunrui_name[$bid].'「'.$data['name'].'」を追加しました。';
	}
	return array($db_msg, $data['id']);
}


//----------------------------------------------------
// 分類項目　更新処理
//----------------------------------------------------

function db_bunrui_update($data,$conn){
	$bid = $data["bid"];
	
	switch($bid){
	case "shindan":
		$sql = <<<EOS
		UPDATE sh_shindan 
		SET 
		name = '{$data['name']}',
		alias = '{$data['alias']}',
		dir = '{$data['dir']}',
		photo_header = '{$data['photo_header']}',
		explanation = '{$data['explanation']}',
		explanation_short = '{$data['explanation_short']}',
		related_title = '{$data['related_title']}',
		related_url = '{$data['related_url']}'
		WHERE 
		id = '{$data['edit_id']}'
EOS;
	break;

	case "nendai":
		$sql = <<<EOS
		UPDATE sh_nendai 
		SET 
		name = '{$data['name']}',
		generation = '{$data['generation']}',
		explanation = '{$data['explanation']}'
		WHERE 
		id = '{$data['edit_id']}'
EOS;
	break;
	
	default:
		$sql = <<<EOS
		UPDATE sh_{$bid} 
		SET 
		name = '{$data['name']}'
		WHERE 
		id = '{$data['edit_id']}'
EOS;
	}
	
	$result = execute_sql($conn, $sql);
	if(isset($result)){
		$db_msg = 'ID：'.$data['edit_id'].'　のデータを更新しました。';
	}
	return array($db_msg, $data['edit_id']);
}

//----------------------------------------------------
// 分類項目　削除処理
//----------------------------------------------------

function db_bunrui_delete($id,$bid,$conn){
	
	$sql = 'delete from sh_'.$bid.' where id = '.$id;
	 execute_sql($conn, $sql);
	$db_msg = "ID：".$id.'を削除しました。';
	return $db_msg;
}


//----------------------------------------------------
// 性別、感想、コメント、日付を変換
//----------------------------------------------------
function change_listcolumn($data){
	for($i=0; $i<count($data); $i++){
		$data[$i]["sex_ex"] = sex_str($data[$i]["age"],$data[$i]["sex"]);
		$data[$i]["kansou"] = set_mark($data[$i]["kansou"]);
		$data[$i]["comment"] = set_mark($data[$i]["comment"]);
		$data[$i]["date"] = date('Y.m.d',strtotime($data[$i]["date"]));
	}
	return $data;
}

//----------------------------------------------------
// 症例画像の配列を生成
//----------------------------------------------------
function photo_array(){
	$photo[0]["title"]["name"] = "photo_first";
	$photo[1]["title"]["name"] = "photo_mdl";
	$photo[2]["title"]["name"] = "photo_end";
	$photo[0]["title"]["header"] = _PHOTO_FIRST;
	$photo[1]["title"]["header"] = _PHOTO_MDL;
	$photo[2]["title"]["header"] = _PHOTO_END;
	$photo[0]["nmb"] = explode(",","1,2,3,4");
	$photo[1]["nmb"] = explode(",","1,2,3,4");
	$photo[2]["nmb"] = explode(",","1,2,3,4");
	return $photo;
}

//----------------------------------------------------
// サムネイルを作成
//----------------------------------------------------
function thumbnail($tmp_file,$file_path,$key){
	$image = ImageCreateFromJPEG($tmp_file); 
	$width = ImageSX($image);
	$height = ImageSY($image);
	if($key == 'photo_header'){
		$new_width = _PHOTO_HEADER_THUMB_WIDTH;
	}else{
		$new_width = _PHOTO_THUMB_WIDTH;
	}
	$rate = $new_width / $width;
	$new_height = $rate * $height;
	$new_image = ImageCreateTrueColor($new_width, $new_height);
	ImageCopyResampled($new_image,$image,0,0,0,0,$new_width,$new_height,$width,$height);
	ImageJPEG($new_image,$file_path , 100);
	
	ImageDestroy($image);
	ImageDestroy($new_image);
}

//----------------------------------------------------
// 分類項目名を定義
//----------------------------------------------------
function bunrui_name(){
	$bunrui_name = array(
		"shindan" => "診断名",
		"nendai" => "年代",
		"shiretsu" => "歯列",
		"basshi" => "治療方針",
		"basshi_bui" => "抜歯部位",
		"souchi" => "装置",
		"tantou" => "担当医"
	);
		return $bunrui_name;
}

//----------------------------------------------------
// 分類項目IDを生成
//----------------------------------------------------
function bunrui_id($bunrui_name){
	$bunrui_id_options = array();
	$TABLE_DATA = relation_tables();
	for($i=1; $i<100; $i++){
		$flag = false;
		foreach($TABLE_DATA[$bunrui_name] as $tbl_value){
			if($tbl_value["id"] == $i){
				$flag = true;
				break;
			}
		}
		if(!$flag){
			$bunrui_id_options[] = '<option value="'.$i.'">'.$i.'</option>';
		}
	}
	return $bunrui_id_options;
}


?>