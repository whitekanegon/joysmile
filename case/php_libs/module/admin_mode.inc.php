<?php

session_name("admin_mode");
session_start();

if(isset($_POST['admin_mode'])){
	$_SESSION["admin_mode"] = addslashes($_POST['admin_mode']);
}

$smarty -> assign('admin_mode',$_SESSION["admin_mode"]);


?>