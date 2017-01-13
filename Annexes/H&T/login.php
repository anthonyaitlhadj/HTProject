<?php

$username = htmlentities($_REQUEST["username"]);

if (empty($username)) 
{
    $returnArray["status"] = "400";
    $returnArray["message"] = "Missing required informations";
    echo json_encode($returnArray);
}

$file = parse_ini_file("../../HT.ini");

$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

require("secure/access.php");
$access = new access($host, $user, $pass, $name);
$access->connect();

$res = $access->getLoginInformations($username);

if ($res){
    $user = $access->getUserInformations($username);

    $returnArray["status"] = "200";
    $returnArray["message"] = "Connect";
}else{
    $returnArray["status"] = "400";
    $returnArray["message"] = "Error please check again!";
}

$access->disconnect();

echo json_encode($returnArray);
?>