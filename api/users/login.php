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

if ((!isset($jsonData->name) && !isset($jsonData->password)) || (!isset($jsonData->email) && !isset($jsonData->password))) {
    $response = new Response();
    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    if (!isset($jsonData->name) && !isset($jsonData->email)) {
        $response->addMessage("Name not supplied or Email not supplied");
    } else {
        false;
    }
    (!isset($jsonData->password) ?  $response->addMessage("password not supplied") : false);

    $response->send();
    exit;
}

if (

    $jsonData->name != null && (strlen($jsonData->name) < 1  || strlen($jsonData->name) > 255) ||  $jsonData->email != null && (strlen($jsonData->email) < 1  || strlen($jsonData->email) > 255) || strlen($jsonData->password) < 1  || strlen($jsonData->password) > 255
) {
    $response = new Response();

    $response->setHttpStatusCode(400);
    $response->setSuccess(false);

    if (isset($jsonData->name)  && !isset($jsonData->email)) {
        (strlen($jsonData->name) < 1 ?  $response->addMessage("Name cannot be black") : false);
        (strlen($jsonData->name) > 255 ?  $response->addMessage("Name cannot be greater than 255 characters") : false);
    }
    if (!isset($jsonData->email) && !isset($jsonData->name)) {
        (strlen($jsonData->email) < 1 ?  $response->addMessage("Email cannot be black") : false);
        (strlen($jsonData->email) > 255 ?  $response->addMessage("Email cannot be greater than 255 characters") : false);
    }
    (strlen($jsonData->password) < 1 ?  $response->addMessage("Password cannot be black") : false);
    (strlen($jsonData->password) > 255 ?  $response->addMessage("Password cannot be greater than 255 characters") : false);

    $response->send();
    exit;
}

$name =  ($jsonData->name != null) ? trim($jsonData->name) : false;
$email = ($jsonData->email != null) ? trim($jsonData->email) : false;
$password = ($jsonData->password != null) ? $jsonData->password : false;

try {

    $query = ($name) ? $writeDB->prepare('select * from users where name =:name ')
        : $writeDB->prepare('select * from users where email =:email ');

    ($name) ?
        $query->bindParam(':name', $name, PDO::PARAM_STR)
        :
        $query->bindParam(':email', $email, PDO::PARAM_STR);

    $query->execute();

    $rowCount = $query->rowCount();

    if ($rowCount === 0) {
        $response = new Response();
        $response->setHttpStatusCode(401);
        $response->setSuccess(false);
        $response->addMessage("Check your data (Email or username or password) is incorrect");
        $response->send();
        exit;
    }

    $row = $query->fetch(PDO::FETCH_ASSOC);
    $returned_id = $row['id'];
    $returned_name = $row['name'];
    $returned_email = $row['email'];
    $returned_email_verified_at =  $row['email_verified_at'];
    $returned_tel = $row['tel'];
    $returned_password = $row['password'];
    $returned_role_id = $row['role_id'];

    if ($returned_email_verified_at === null) {
        $response = new Response();
        $response->setHttpStatusCode(401);
        $response->setSuccess(false);
        $response->addMessage("User Not Active");
        $response->send();
        exit;
    }
    if (!password_verify($password, $returned_password)) {
        $response = new Response();
        $response->setHttpStatusCode(401);
        $response->setSuccess(false);
        $response->addMessage("Check your data (Email or username or password) is incorrect" );
        $response->send();
        exit;
    } else {
       
   
        try {
            $remember_token = bin2hex(random_bytes(20));
    
            $query = $writeDB->prepare('update users set hash_user=? , code_rest_pass=? , remember_token=? WHERE id="'.$returned_id.'" ');
            $query->execute(["", "", $remember_token]);

          
            $returnData = array();
            $returnData['id'] = $returned_id;
            $returnData['email'] = $returned_email;
            $returnData['tel'] = $returned_tel;
            $returnData['remember_token'] = $remember_token;
            $returnData['role_id'] = $returned_role_id;

            $response = new Response();
            $response->setHttpStatusCode(201);
            $response->setSuccess(true);
            $response->setData($returnData);
            $response->send();
            exit;

        } catch (PDOException $ex) {
            $response = new Response();
            $response->setHttpStatusCode(500);
            $response->setSuccess(false);
            $response->addMessage("There was an issue Query " . $ex);
            $response->send();
            exit;
        }
    }
} catch (PDOException $ex) {
    $response = new Response();
    $response->setHttpStatusCode(500);
    $response->setSuccess(false);
    $response->addMessage("There was an issue logging in ");
    $response->send();
    exit;
}
