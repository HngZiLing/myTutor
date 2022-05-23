<?php
if(!isset($_post)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$name = $_post['userName'];
$email = $_post['userEmail'];
$password = sha1($_post['userPassword']);
$phone = $_post['userPhone'];
$address = $_post['userAddress'];
$base64image = $_POST['image'];

$sqlinsert = "INSERT INTO table_user (user_email, user_name, user_password,
user_phone, user_address) VALUES('$email', '$name', '$password', '$phone', '$address')";

if($conn->query($sqlinsert) === TRUE) {
    $response = array('status' => 'success', 'data' => null);
    $filename = mysqli_insert_id($conn);
    $decoded_string = base64_decode($image);
    $path = '../assets/images/users/'.$image.".jpg";
    $is_written = file_put_contents($path, $decoded_string);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>