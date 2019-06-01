<?php
require_once('db.php');
$title = $_POST['title'];
$subtitle = $_POST['subtitle'];
$db->query("insert into flutterTable (title, subtitle) values ('".$title."','".$subtitle."')");

