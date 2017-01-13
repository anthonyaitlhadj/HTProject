<?php
/**
 * Created by PhpStorm.
 * User: qkab78
 * Date: 24/12/2016
 * Time: 16:45
 */

$file = parse_ini_file("../../HT.ini");

$host = trim($file["dbhost"]);
$user = trim($file["dbuser"]);
$pass = trim($file["dbpass"]);
$name = trim($file["dbname"]);

require("secure/access.php");
$access = new access($host, $user, $pass, $name);
$access->connect();

$res = $access->getAllUsers();

if ($res){

    $returnArray["status"] = "200";
    $returnArray["message"] = "All users printed!";

}else{
    $returnArray["status"] = "400";
    $returnArray["message"] = "Users not found!";
}

$access->disconnect();

?>