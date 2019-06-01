<?php
require_once('db.php');
$query = 'SELECT * FROM flutterTable';
$stm = $db->prepare($query);
$stm->execute();
$json_array = array();
// $row = $stm->fetch(PDO::FETCH_ASSOC);
while ($row = $stm->fetch(PDO::FETCH_ASSOC)){
	// echo json_encode($row);
	// $row = $stm->fetch(PDO::FETCH_ASSOC);
	$json_array[] = $row;
}
// print_r($json_array);
echo json_encode($json_array);