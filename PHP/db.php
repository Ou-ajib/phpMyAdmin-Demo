<?php
$dns = 'mysql:host=localhost;dbname=flutterDB';
$user = 'root';
// $pass = 'Aissam123';

try{
	$db = new PDO($dns, $user);
	// echo 'connected';
}catch(PDOException $e){
	echo $e->getMessage();
}