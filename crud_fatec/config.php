<?php

$host = "localhost"; // nome do servidor MySQL
$user = "USUARIO"; // usuário do MySQL
$pass = "SENHA"; // senha do MySQL
$dbname = "BANCODEDADOS"; // nome do banco de dados

// Conexão com o banco de dados MySQL
$conn = mysqli_connect($host, $user, $pass, $dbname);

// Verifica se houve erro na conexão
if (!$conn) {
    die("Falha na conexão: " . mysqli_connect_error());
}
