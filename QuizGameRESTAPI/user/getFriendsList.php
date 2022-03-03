<?php
include_once '../connection/connection.php';

// getting values
$username = $_POST['username'];

//creating the query
$stmt = $conn->prepare("(
SELECT username
FROM user LEFT JOIN friendship ON username = user2
WHERE user1 = ?)
UNION
(SELECT GROUP_CONCAT(username SEPARATOR ',')
FROM user LEFT JOIN friendship ON username = user1
WHERE user2 = ?)");
$stmt->bind_param("ss",$username, $username);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
  $stmt->bind_result($username);

  $user = array();
  while ($stmt->fetch()) {
    $user[] = array('username' => $username);
  }

$response['error'] = false;
$response['message'] = 'Lista amici caricata correttamente';
$response['amici'] = $user;
}
else {
  //if friends list is empty
  $response['error'] = true;
  $response['message'] = 'Non hai nessun amico';
}
$stmt->close();
echo json_encode($response);
?>
