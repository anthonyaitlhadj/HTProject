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
    public function regiterUser($username, $password, $salt, $email, $firstname, $lastname){
        //Requête SQL
        $req = "INSERT INTO users SET username=?, password=?, salt=?, email=?, firstname=?, lastname=?";
        $statement = $this->conn->prepare($req);
        //S'il y a une erreur
        if (!$statement){
            throw new Exception($statement->error);
        }
        //Bind 5 params de type string et on les prépare à les mettredans notre table 'users'
        $statement->bind_param("ssssss", $username, $password, $salt, $email, $firstname, $lastname);
        $result = $statement->execute();
        return $result;
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
}
?>


