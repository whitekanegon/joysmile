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

$delete_key = $_POST["delete"];

if($delete_key == 'photo_header' || $delete_key == 'photo_patient'){
	if($_SESSION[$delete_key]){
		$_SESSION[$delete_key] = '';
		$data["filepath"] = _PHOTO_HEADER_DUMMY;
		$data["msg"] = "画像を削除しました。";
	}else{
		$data["filepath"] = '';
		$data["msg"] = "";
	}
}else{
	list($name,$nmb) = explode("-",$delete_key);
	if($_SESSION[$name][$nmb]){
		$_SESSION[$name][$nmb] = '';
		$data["filepath"] = _PHOTO_DUMMY;
		$data["msg"] = "画像を削除しました。";
	}else{
		$data["filepath"] = '';
		$data["msg"] = "";
	}
}


	header('Content-type: text/html');
	echo json_encode($data);

?>