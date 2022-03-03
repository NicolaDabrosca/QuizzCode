<?php
include_once '../connection/connection.php';
include_once '../function/function.php';


$response = array();

if(checkParameters(array('username','points','record','win','lose','level','break','if_else','loop','return'))) {
$username = $_POST['username'];
$points = $_POST['points'];
$record = $_POST['record'];
$win = $_POST['win'];
$lose = $_POST['lose'];
$level = $_POST['level'];
$break = $_POST['break'];
$if_else = $_POST['if_else'];
$loop = $_POST['loop'];
$return = $_POST['return'];


  // checking if the user is already exist with this username or email
  $stmt = $conn->prepare("UPDATE user
                          SET points = points + ?,record = ?,
                              win = ?,lose = ?,level = ?
                          WHERE username =  ? ");
  $stmt->bind_param("iiiiis",$points,$record,$win,$lose,$level, $username);

if($stmt->execute()){


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

    $stmt = $conn->prepare("SELECT user,points,record,win,lose,level,
      GROUP_CONCAT(power SEPARATOR ', ') AS powers,
      GROUP_CONCAT(quantity SEPARATOR ', ') AS quantity
      FROM user JOIN bonus ON (username = user)
      WHERE username = ?");
        $stmt->bind_param("s",$username);
        $stmt->execute();
        $stmt->bind_result($username, $points, $record, $win,
                           $lose, $level, $power, $quantity);
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
      $response['error'] = false;
      $response['message'] = 'Statistiche aggiornate correttamente';

      $response['utente'] = $user;
      $stmt->close();


}
  else {
    $response['error'] = true;
    $response['message'] = 'Statistiche non aggiornate';
    $stmt->close();


}

}else{
  $response['error'] = true;
  $response['message'] = 'Passaggio di parametri errato';
  $parametri = array(
      'username' => $username,
      'points' => $points,
      'record' => $record,
      'win' => $win,
      'lose' => $lose,
      'level' => $level,
      'break' => $break,
      'if else' => $if_else,
      'loop' => $loop,
      'return' => $return

    );
    $response['parametri'] = $parametri;
}






echo json_encode($response);
?>
