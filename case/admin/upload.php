<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

if($_POST["session_name"]){
	$session_name = $_POST["session_name"];
}else{
	$session_name = _SESSION_DEFAULT;
}

session_name($session_name);
session_start();

//リレーショナルテーブル読込
/*
$TABLE_DATA = relation_tables();

foreach($TABLE_DATA["shindan"] as $val){
	if($val["id"] == $_POST["shindan"]){
		$category_dir = $val["dir"];
	}
}
*/

$ext = array("jpg","jpeg");
$file_ok = false;

if($_FILES){
	foreach($_FILES as $key => $val){
		$tmp_file = $_FILES[$key]["tmp_name"];
		
		if (is_uploaded_file($tmp_file)) {

			list($file_name,$file_type) = explode(".",$_FILES[$key]["name"]);
			
			//拡張子チェック
			$file_type = strtolower($file_type);
			foreach($ext as $val){
				if($file_type == $val){
					$file_ok = true;
					if($val == 'jpeg') $file_type = 'jpg';
					break;
				}
			}
			
			if($file_ok){

				//ファイルパスを定義
				$file_name_date = date("Ymd-His");
				if($_POST["updir"]){
					$upload_dir = _UPIMAGE_DIR.$_POST["updir"]."/";
				}else{
					$upload_dir = _UPIMAGE_DIR;
				}
				if(!is_dir($upload_dir)){
					mkdir($upload_dir);
				}
				$file_path_in_db = $upload_dir.$key."_".$file_name_date;
				$file_path = "../".$file_path_in_db.".".$file_type;
				
				thumbnail($tmp_file,"../".$file_path_in_db.'_thumb'.'.'.$file_type,$key);
				
				if (move_uploaded_file($tmp_file, $file_path)) {
					chmod($file_path, 0644);
					$data["msg"] = "画像をアップロードしました。";
					$data["filepath"] = $file_path;
					if($key == 'photo_header' || $key == 'photo_patient'){
						$_SESSION[$key] = $file_path_in_db;
					}else{
						list($name,$nmb) = explode("-",$key);
						$_SESSION[$name][$nmb] = $file_path_in_db;
					}
				}else{
					$data["msg"] = "画像をアップロードできません。";
					$data["filepath"] = "error";
				}
			
			}else{
				$data["msg"] = "JPEG画像を選択して下さい。";
				$data["filepath"] = "error";
			}
		}
	}
}
	header('Content-type: text/html');
	echo json_encode($data);

?>