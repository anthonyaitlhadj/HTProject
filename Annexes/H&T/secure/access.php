<?php
/**
 * Created by PhpStorm.
 * User: qkab78
 * Date: 11/12/2016
 * Time: 14:26
 */
class access{
    //global variables
    var $host = null;
    var $user = null;
    var $pass = null;
    var $name = null;
    var $conn = null;
    var $result = null;

    //constructeur
    function __construct($dbhost, $dbuser, $dbpass, $dbname)
    {
        $this->host = $dbhost;
        $this->user = $dbuser;
        $this->pass = $dbpass;
        $this->name = $dbname;
    }

    //connexion à la base de données
    public function connect(){
        //Etablissement de la connexion et on la store dans la variable 'conn'
        $this->conn = new mysqli($this->host, $this->user, $this->pass, $this->name);
        if (mysqli_connect_errno()){
            echo "Could not connect to the database";
        }
        //Supporte toutes les langues
        $this->conn->set_charset("utf8");

    }

    public function disconnect(){
        if($this->conn != null) {
            $this->conn->close();
        }
    }


    //Insérer un user
    public function registerUser($username, $password, $email, $firstname, $lastname){
        //Requête SQL
        $req = "INSERT INTO users SET username=?, password=?, email=?, firstname=?, lastname=?";
        $statement = $this->conn->prepare($req);
        //S'il y a une erreur
        if (!$statement){
            throw new Exception($statement->error);
        }
        //Bind 5 params de type string et on les prépare à les mettre dans notre table 'users'
        $statement->bind_param("sssss", $username, $password, $email, $firstname, $lastname);
        $result = $statement->execute();
        return $result;
    }

    public function loginUser($username, $password){
        //Requête à exécuter
        $req = "SELECT * from users WHERE username='".$username."' AND password='".$password."' ";
        //Execution de a requête grâce à 'query'
        $result = $this->conn->query($req);

        //Si on a au moins 1 résultat
        if ($result != null && (mysqli_num_rows($result) >= 1) ){
            $row = $result->fetch_array(MYSQLI_ASSOC);
            if (!empty($row)){
                $returnArray = $row;
            }
        }

        return $returnArray;
    }

    public function getUserInformations($username){
        //Requête à exécuter
        $req = "SELECT * from users WHERE username='".$username."' ";
        //Execution de a requête grâce à 'query'
        $result = $this->conn->query($req);

        //Si on a au moins 1 résultat
        if ($result != null && (mysqli_num_rows($result) >= 1) ){
            $row = $result->fetch_array(MYSQLI_ASSOC);
            if (!empty($row)){
                $returnArray = $row;
            }
        }

        return $returnArray;
    }


    public function insertMessage($username, $message){
        //Requête à effectuer
        $req =  "INSERT INTO messages SET username=?, message=?";
        $statement = $this->conn->prepare($req);

        //S'il y a une erreur
        if (!$statement){
            throw new Exception($statement->error);
        }
        //Bind 2 params de type string et on les prépare à les mettre dans notre table 'messages'
        $statement->bind_param("ss", $username, $message);
        $result = $statement->execute();
        return $result;
    }

    public function getAllMessages($username){
        //Requête à exécuter
        $req = "SELECT * from messages WHERE username='".$username."' ";
        //Execution de a requête grâce à 'query'
        $result = $this->conn->query($req);

        //Si on a au moins 1 résultat
        if ($result != null && (mysqli_num_rows($result) >= 1) ){
            $row = $result->fetch_array(MYSQLI_ASSOC);
            if (!empty($row)){
                $returnArray = $row;
            }
        }

        return $returnArray;
    }

    public function getAllUsers(){
        $req = "SELECT firstname, lastname, username from users";
        $result = $this->conn->query($req);

        if ($result != null && (mysqli_num_rows($result) >= 1) ){
            $returnArray = array();
            while ($row = $result->fetch_array(MYSQLI_ASSOC)){
                if (!empty($row)){
                    $returnArray[] = $row;
                }
            }
                    //echo json_encode($returnArray);
        }
        echo '{"users": '.json_encode($returnArray).'}';
    }
}
?>


