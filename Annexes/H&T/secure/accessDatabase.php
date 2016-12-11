<?php
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
}
?>