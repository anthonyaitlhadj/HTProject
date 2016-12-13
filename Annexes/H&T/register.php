<?php
/**
 * Created by PhpStorm.
 * User: qkab78
 * Date: 11/12/2016
 * Time: 14:22
 */

//STEP 1 : Sécuriser les données
$username = htmlentities($_REQUEST["username"]);
$password = htmlentities($_REQUEST["password"]);
$email = htmlentities($_REQUEST["email"]);
$firstname = htmlentities($_REQUEST["firstname"]);
$lastname = htmlentities($_REQUEST["lastname"]);

//Si le GET / POST est empty
if (empty($username) || empty($email) || empty($password) || empty($firstname) || empty($lastname)){
    $returnArray["status"] = "400";
    $returnArray["message"] = "Missing required informations";
    echo json_encode($returnArray);
}
//securiser le mot de passe
$salt = openssl_random_pseudo_bytes(20);
$secured_pass = sha1($password, $salt);

//STEP 2 : Get HT.ini file ==> Buil connection
$file = parse_ini_file("../../HT.ini");

$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

require("secure/access.php");
$access = new access($host, $user, $pass, $name);
$access->connect();



//STEP 3 : insert user infos
$result = $access->regiterUser($username, $secured_pass, $salt, $email, $firstname, $lastname);
if ($result){
    $user = $access->getUserInformations($username);

    $returnArray["status"] = "200";
    $returnArray["message"] = "Successfully inserted";
    $returnArray["id"] = $user["id"];
    $returnArray["username"] = $user["username"];
    $returnArray["email"] = $user["email"];
    $returnArray["firstname"] = $user["firstname"];
    $returnArray["lastname"] = $user["lastname"];
}else{
    $returnArray["status"] = "400";
    $returnArray["message"] = "Could not register with provided informations!";
}

//STEP 4 : Déconnecter la base
$access->disconnect();

//STEP 5 : JSON data
echo json_encode($returnArray);
?>