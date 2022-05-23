<?php
if(!isset($_post)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");
$email = $post['email'];
$password = $sha1($_post['password']);
$sqllogin = "SELECT * FROM table_user WHERE user_email = '$email' AND user_password = '$password'";
$result = $conn->query($sqllogin);
$numrow = $result->num_rows;

if($num_rows >0) {
    while ($row = $result->fetch_assoc()) {
        $userlist['id'] = $row['user_id'];
        $userlist['name'] = $row['user_name'];
        $userlist['email'] = $row['user_email'];
        $userlist['phone'] = $row['user_phone'];
        $userlist['address'] = $row['user_address'];
    }
    $response = array('status' => 'success', 'data' => $admin);
    sendJsonResponse($response);
} else {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>