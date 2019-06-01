<?php
require_once('db.php');
$id = $_POST['id'];
$title = $_POST['title'];
$subtitle = $_POST['subtitle'];
$db->query("update flutterTable set title = '".$title."', subtitle = '".$subtitle."' where id = ".$id);