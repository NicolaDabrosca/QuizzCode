<?php
include_once '../connection/connection.php';
include_once '../function/function.php';


$response = array();

if(checkParameters(array('username','break','if_else','loop','return'))) {

$username = $_POST['username'];
$break = $_POST['break'];
$if_else = $_POST['if_else'];
$loop = $_POST['loop'];
$return = $_POST['return'];

  $stmt = $conn->prepare("UPDATE bonus SET quantity = ? WHERE (power = 'break' and user = ?)" );
  $stmt->bind_param("is",$break,$username);
  if($stmt->execute()){}

  $stmt = $conn->prepare("UPDATE bonus SET quantity = ? WHERE (power = 'if else' and user = ?)" );
  $stmt->bind_param("is",$if_else,$username);
  if($stmt->execute()){}

  $stmt = $conn->prepare("UPDATE bonus SET quantity = ? WHERE (power = 'loop' and user = ?)" );
  $stmt->bind_param("is",$loop,$username);
  if($stmt->execute()){}

  $stmt = $conn->prepare("UPDATE bonus SET quantity = ? WHERE (power = 'return' and user = ?)" );
  $stmt->bind_param("is",$return,$username);
  if($stmt->execute()){}

  //if the user already exist in the database



      $response['error'] = false;
      $response['message'] = 'Statistiche aggiornate correttamente';

      $stmt->close();


}else{
  $response['error'] = true;
  $response['message'] = 'Passaggio di parametri errato';

}






echo json_encode($response);
?>
