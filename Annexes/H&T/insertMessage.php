<?php
/**
 * Created by PhpStorm.
 * User: qkab78
 * Date: 13/12/2016
 * Time: 14:15
 */
//STEP 1 : Sécuriser les données
$sending_username_id = htmlentities($_REQUEST["sending_username_id"]);
$message = htmlentities($_REQUEST["message"]);
$receiving_username_id = htmlentities($_REQUEST["receiving_username_id"]);
//Si le GET / POST est empty
if (empty($sending_username_id) || empty($message) || empty($receiving_username_id) ){
    $returnArray["status"] = "400";
    $returnArray["message"] = "Missing required informations";
    echo json_encode($returnArray);
    return 0;
}

//STEP 2 : Get HT.ini file ==> Buil connection
$file = parse_ini_file("../../HT.ini");

$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

require("secure/access.php");
$access = new access($host, $user, $pass, $name);
$access->connect();



//STEP 3 : insert message infos
$result = $access->insertMessage($sending_username_id, $message, $receiving_username_id);
if ($result){
    $userMessage = $access->getLastMessage($sending_username_id, $receiving_username_id);

    $returnArray["status"] = "200";
    $returnArray["success"] = "Successfully inserted";
    $returnArray["sending_user_id"] = $userMessage["sending_user_id"];
    $returnArray["receiving_user_id"] = $userMessage["receiving_user_id"];
    $returnArray["message"] = $userMessage["message"];
}else{
    $returnArray["status"] = "400";
    $returnArray["message"] = "Could not send message with provided informations!";
}

//STEP 4 : Déconnecter la base
$access->disconnect();

//STEP 5 : JSON data
echo json_encode($returnArray);
?>