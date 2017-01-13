<?php
/**
 * Created by PhpStorm.
 * User: qkab78
 * Date: 12/01/2017
 * Time: 19:34
 */

//STEP 1 : Sécuriser les données
$sending_username_id = htmlentities($_REQUEST["sending_username_id"]);
$receiving_username_id = htmlentities($_REQUEST["receiving_username_id"]);
//Si le GET / POST est empty
if (empty($sending_username_id) || empty($receiving_username_id) ){
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
$result = $access->getAllMessages($sending_username_id, $receiving_username_id);

/*if ($result){
    $returnArray["status"] = "200";
    $returnArray["success"] = "Successfully retrieved";
    //$returnArray["sending_user_id"] = $result["sending_user_id"];
    //$returnArray["receiving_user_id"] = $result["receiving_user_id"];
}else{
    $returnArray["status"] = "400";
    $returnArray["message"] = "Could not retrieve messages with provided informations!";
}*/

//STEP 4 : Déconnecter la base
$access->disconnect();

//STEP 5 : JSON data
//echo json_encode($returnArray);

?>