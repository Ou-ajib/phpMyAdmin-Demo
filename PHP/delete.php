<?php
require_once('db.php');
$id = $_POST['id'];
$db->query("delete from flutterTable where id = ".$id);