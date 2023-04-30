<?php

// Cabeçalho para acesso
header('Access-Control-Allow-Origin: *');

// Conexão com banco de dados
$connect = new PDO("mysql:host=localhost;dbname=BANCODEDADOS", "USER", "SENHA");

// Obtém os dados do input e decodifica de json para um objeto php
$received_data = json_decode(file_get_contents("php://input"));

$data = array();	// Array vazio

if($received_data->query != '')	// Se não for vazio
{
	// Usa o parâmetro recebido para fazer a consulta no BD
	$query = "
	SELECT * FROM fatec_alunos 
	WHERE first_name LIKE '%".$received_data->query."%' 
	OR last_name LIKE '%".$received_data->query."%' 
	ORDER BY id DESC
	";
	// Ordenado por ID decrescente
}
else	// Se for vazia, retorna todos os alunos
{
	$query = "
	SELECT * FROM fatec_alunos 
	ORDER BY id DESC
	";
}

// Prepara e executa a query
$statement = $connect->prepare($query);
$statement->execute();

// Adiciona cada linha do resultado ao array $data[]
while($row = $statement->fetch(PDO::FETCH_ASSOC))
{
	$data[] = $row;
}

// Converte o array para json
echo json_encode($data);

?>