<?php
include_once '../connection/connection.php';


$language = $_POST['language'];
//creating the query
$stmt = $conn->prepare("SELECT id,category,text,
                        wrongs->'$.r1' AS r1,
                        wrongs->'$.r2' AS r2,
                        wrongs->'$.r3' AS r3,
                        answer FROM question
                        WHERE language = ?
                        ");
$stmt->bind_param("s",$language);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {

  $stmt->bind_result($id, $category, $text,$r1,$r2,$r3,$answer);


  $question = array();
  while ($stmt->fetch()) {
    $question[] = array(
      'id' => $id,
      'category' => $category,
      'text' => $text,
      'r1' => $r1,
      'r2' => $r2,
      'r3' => $r3,
      'answer' => $answer
    );
  }

$response['error'] = false;
$response['message'] = 'Domande caricate correttamente';
$response['question'] = $question;
}
else {
  //if friends list is empty
  $response['error'] = true;
  $response['message'] = 'Non hai nessun amico';
}
$stmt->close();
echo json_encode($response);
?>
