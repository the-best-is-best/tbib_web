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


if ($_SERVER['REQUEST_METHOD']  !== 'GET') {
    $response = new Response();
    $response->setHttpStatusCode(405);
    $response->setSuccess(false);
    $response->addMessage('Request method not allowed');
    $response->send();
    exit;
}


$query =  $writeDB->prepare('select * from header_content');
$query->execute();

$rowCount = $query->rowCount();

if ($rowCount === 0) {
    $response = new Response();
    $response->setHttpStatusCode(401);
    $response->setSuccess(false);
    $response->addMessage("No Data");
    $response->send();
    exit;
}


$row = $query->fetch(PDO::FETCH_ASSOC);

$returned = array();

$returned['bg'] = $row['bg'];
$returned['title'] = $row['title'];
$returned['content'] = $row['content'];
$returned['des'] =$row['des'];
$returned['btn_active'] = $row['btn_active'];
$returned['btn_title'] = $row['btn_title'];

$response = new Response();
$response->setHttpStatusCode(201);
$response->setSuccess(true);
$response->setData($returned);
$response->send();
exit;


