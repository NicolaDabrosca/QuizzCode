<?php
include_once '../connection/connection.php';
include_once '../function/function.php';

$response = array();

if(checkParameters(array('username'))) {
  $username = $_POST['username'];



  // checking if the user is already exist with this username or email
  $stmt = $conn->prepare("SELECT * FROM user WHERE username = ? ");
  $stmt->bind_param("s", $username);
  $stmt->execute();
  $stmt->store_result();

  //if the user already exist in the database
  if($stmt->num_rows > 0) {
    $response['error'] = true;
    $response['message'] = 'Utente già esistente con questo username o con questa email';
    $stmt->close();
  }
  else {
    //if user is new creating an insert query
    $stmt = $conn->prepare("INSERT INTO user(username) VALUES (?)");
    $stmt->bind_param("s", $username);

    //if the user is successfully added to the database
    if($stmt->execute()) {

      $response['error'] = false;
      $response['message'] = 'Utente registrato correttamente';
      $response['utente'] = $user;
    }
    else {
      $response['error'] = true;
      $response['message'] = 'Ops! Qualcosa è andato storto. Controlla i dati inseriti e riprova';
    }
  }

  $stmt = $conn->prepare("SELECT user,level,points,record,win,lose,
    GROUP_CONCAT(power SEPARATOR ', ') AS powers, GROUP_CONCAT(quantity SEPARATOR ', ') AS quantity
    FROM user JOIN bonus ON (username = user)  
    WHERE username = ?");
      $stmt->bind_param("s",$username);
      $stmt->execute();
      $stmt->bind_result($username, $points, $record, $win, $lose, $level, $power,$quantity);
      $stmt->fetch();
  $user = array(
      'username' => $username,
      'points' => $points,
      'record' => $record,
      'win' => $win,
      'lose' => $lose,
      'level' => $level,
      'power' => $power,
      'quantity' => $quantity

    );

    $response['utente'] = $user;
}



echo json_encode($response);
?>
