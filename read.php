<?php
// http://localhost/reactjs-php/api/products/read.php
// required headers
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
 
// include database and object files
include_once '../database.php';
include_once '../objects/products.php';
 
// instantiate database and ui_app object
$database = new Database();
$db = $database->getConnection();
 
// initialize object
$Products = new Products($db);
 
// query products
$stmt = $Products->read();
$num = $stmt->rowCount();

 
// check if more than 0 record found
if($num>0){
    $result=array();
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        if (!isset($result[$row['user_id']])) {
			$result[$row['user_id']] = array(
				'UserId' => $row['user_id'],
				'UserName' => $row['user_name']
			);
		}
		$result[$row['user_id']]['product_id'][] = array(
			'ProductId' => $row['product_id'],
			'ProductName' => $row['product_name']
		);
		$result[$row['user_id']]['product_id']['product_img_id'][] = array(
			'img_id' => $row['product_img_id'],
			'img_path' => $row['product_img_path']
		);
		 
		 
		$result = array_values($result);
    }
	
	echo json_encode($result);
}
 
else{
    echo json_encode(
        array("message" => "No products found.")
    );
}
?>