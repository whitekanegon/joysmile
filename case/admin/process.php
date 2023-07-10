<?php

require_once("../php_libs/config/config.inc.php");
require_once(_MODULE_DIR."MYDB.inc.php");

session_name(_SESSION_DEFAULT);
session_start();

$conn = db_connect(_DSN);

//記事登録
if($_SESSION['mode'] == 'regist'){
	list($db_msg, $insert_id) = db_regist($_SESSION,$conn);
	$_SESSION['db_msg'] = $db_msg;
	$_SESSION['insert_id'] = $insert_id;
	header("location: index.php");
	exit;
}

//記事更新
if($_SESSION['mode'] == 'update'){
	list($db_msg, $insert_id) = db_update($_SESSION,$conn);
	$_SESSION['db_msg'] = $db_msg;
	$_SESSION['insert_id'] = $insert_id;
	header("location: index.php");
	exit;
}

//記事削除
if($_POST['mode'] == 'delete' && is_array($_POST["id"])){
	$db_msg = db_delete($_POST["id"],$conn);
	$_SESSION['db_msg'] = $db_msg;
	if($_POST['ikkatsu']){
		header("location: kiji_delelte.php");
	}else{
		header("location: index.php");
	}
	exit;
}else{
	if($_POST['ikkatsu']){
		header("location: kiji_delelte.php");
	}else{
		header("location: index.php");
	}
	exit;
}


?>

