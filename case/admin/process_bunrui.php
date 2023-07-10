<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_BUNRUI);
session_start();

$conn = db_connect(_DSN);

//分類項目登録
if($_SESSION['mode'] == 'regist_bunrui'){
	list($db_msg, $insert_id) = db_bunrui_regist($_SESSION,$conn);
	$_SESSION['db_msg'] = $db_msg;
	$_SESSION['insert_id'] = $insert_id;
	header("location: bunrui_index.php?bid=".$_SESSION['bid']);
	exit;
}

//分類項目更新
if($_SESSION['mode'] == 'update_bunrui'){
	list($db_msg, $insert_id) = db_bunrui_update($_SESSION,$conn);
	$_SESSION['db_msg'] = $db_msg;
	$_SESSION['insert_id'] = $insert_id;
	header("location: bunrui_index.php?bid=".$_SESSION['bid']);
	exit;
}

//分類項目削除
if($_POST['mode'] == 'delete_bunrui'){
	$db_msg = db_bunrui_delete($_POST["id"],$_SESSION['bid'],$conn);
	$_SESSION['db_msg'] = $db_msg;
	header("location: bunrui_index.php?bid=".$_SESSION['bid']);
	exit;
}


?>

