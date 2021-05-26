<?php
require_once('../Controller/db.php');
require_once('../Models/Response.php');

try {
  $writeDB = DB::connectionWriteDB();
} catch (PDOException $ex) {
  error_log("connection Error: " . $ex, 0);
  $response = new Response();
  $response->setHttpStatusCode(500);
  $response->setSuccess(false);
  $response->addMessage('Database connection error');
  $response->send();
  exit;
}

if ($_SERVER['REQUEST_METHOD']  !== 'POST') {
  $response = new Response();
  $response->setHttpStatusCode(405);
  $response->setSuccess(false);
  $response->addMessage('Request method not allowed');
  $response->send();
  exit;
}

if ($_SERVER['CONTENT_TYPE'] !== 'application/json') {
  $response = new Response();
  $response->setHttpStatusCode(400);
  $response->setSuccess(false);
  $response->addMessage('Content Type header not json');
  $response->send();
  exit;
}

$rowPostData = file_get_contents('php://input');

if (!$jsonData = json_decode($rowPostData)) {

  $response = new Response();
  $response->setHttpStatusCode(400);
  $response->setSuccess(false);
  $response->addMessage('Request body is not valid json');
  $response->send();
  exit;
}

if (!isset($jsonData->name) || !isset($jsonData->email) || !isset($jsonData->company_personal_name) || !isset($jsonData->password)) {
  $response->setHttpStatusCode(400);
  $response->setSuccess(false);

  (!isset($jsonData->name) ?  $response->addMessage("Name not supplied") : false);
  (!isset($jsonData->email) ?  $response->addMessage("email not supplied") : false);
  (!isset($jsonData->company_personal_name) ?  $response->addMessage("company_personal_name not supplied") : false);
  (!isset($jsonData->password) ?  $response->addMessage("password not supplied") : false);

  $response->send();
  exit;
}

  if (
    strlen($jsonData->name) < 1 || strlen($jsonData->name) > 255 || strlen($jsonData->company_personal_name) < 1 || strlen($jsonData->company_personal_name > 255) || strlen($jsonData->password) < 1  || strlen($jsonData->password) > 255
    || strlen($jsonData->tel) < 1 || strlen($jsonData->tel) > 11
  ) {
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    (strlen($jsonData->name) < 1 ?  $response->addMessage("Name cannot be black") : false);
    (strlen($jsonData->name) > 255 ?  $response->addMessage("Name cannot be greater than 255 characters") : false);

    (strlen($jsonData->email) < 1 ?  $response->addMessage("Name cannot be black") : false);
    (strlen($jsonData->email) > 255 ?  $response->addMessage("Name cannot be greater than 255 characters") : false);


    (strlen($jsonData->company_personal_name) < 1 ?  $response->addMessage("Company or personal name cannot be black") : false);
    (strlen($jsonData->company_personal_name) > 255 ?  $response->addMessage("Company or personal name  cannot be greater than 255 characters") : false);


    (strlen($jsonData->password) < 1 ?  $response->addMessage("Password cannot be black") : false);
    (strlen($jsonData->password) > 255 ?  $response->addMessage("Password cannot be greater than 255 characters") : false);

    (strlen($jsonData->tel) < 1 ?  $response->addMessage("Tel cannot be black") : false);
    (strlen($jsonData->tel) > 255 ?  $response->addMessage("Tel cannot be greater than 11 characters") : false);


    $response->send();
    exit;
  
}


$name = trim($jsonData->name);
$email = trim($jsonData->email);
$password = $jsonData->password;
$company_personal_name = trim($jsonData->company_personal_name);
$tel = $jsonData->tel;
$create_at = date('Y-m-d h:i:sa');


try {

  $query = $writeDB->prepare('select id from users where name = :name');
  $query->bindParam(':name', $name, PDO::PARAM_STR);
  $query->execute();

  $rowCount = $query->rowCount();

  if ($rowCount !== 0) {
    $response = new Response();
    $response->setHttpStatusCode(409);
    $response->setSuccess(false);
    $response->addMessage('Name already exists');
    $response->send();
    exit;
  }

  $query = $writeDB->prepare('select id from users where email = :email');
  $query->bindParam(':email', $email, PDO::PARAM_STR);
  $query->execute();

  $rowCount = $query->rowCount();

  if ($rowCount !== 0) {
    $response = new Response();
    $response->setHttpStatusCode(409);
    $response->setSuccess(false);
    $response->addMessage('email already exists');
    $response->send();
    exit;
  }

    $hash_password = password_hash($password , PASSWORD_DEFAULT);

    $query = $writeDB->prepare('insert into users (name , email , password , company_personal_name , tel , hash_user , created_at , updated_at )
    VALUES (:name , :email , :password , :company_personal_name , :tel , :hash_user , :created_at , :updated_at )');

    $query->bindParam(':name', $name, PDO::PARAM_STR);
    $query->bindParam(':email', $email, PDO::PARAM_STR);
    $query->bindParam(':password', $hash_password, PDO::PARAM_STR);
    $query->bindParam(':company_personal_name', $company_personal_name, PDO::PARAM_STR);
    $query->bindParam(':tel', $tel, PDO::PARAM_STR);
    $query->bindParam(':created_at', $create_at, PDO::PARAM_STR);
    $query->bindParam(':updated_at', $create_at, PDO::PARAM_STR);

    $query->execute();
    $rowCount = $query->rowCount();

    if($rowCount === 0){
      $response = new Response();
      $response->setHttpStatusCode(500);
      $response->setSuccess(false);
      $response->addMessage('There was an issue creating user account - please try again');
      $response->send();
      exit;
    }
    
    $lastUserID = $writeDB->lastInsertId();
    $returnData = array();
    $returnData['user_id'] = $lastUserID;
    $returnData['email'] = $email;

    $response = new Response();
    $response->setHttpStatusCode(201);
    $response->setSuccess(true);
    $response->addMessage('User Created');
    $response->setData($returnData);
    $response->send();
    exit;


} catch (PDOException $ex) {
  error_log("Database query error: " . $ex, 0);
  $response = new Response();
  $response->setHttpStatusCode(500);
  $response->setSuccess(false);
  $response->addMessage('There was an issue creating user account - please try again' .$ex);
  $response->send();
  exit;
}
