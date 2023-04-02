<?php
// Cabeçalho para acesso
header('Access-Control-Allow-Origin: *');

// Conexão com banco de dados
$connect = new PDO("mysql:host=localhost;dbname=BANCODEDADOS", "USER", "SENHA");

// Obtém os dados do input e decodifica de json para um objeto php
$received_data = json_decode(file_get_contents("php://input"));

$data = array();    // Array vazio

// Se a ação for "fetchall" seleciona tudo da tabela fatec_alunos
if ($received_data->action == 'fetchall') {
    $query = "
 SELECT * FROM fatec_alunos 
 ORDER BY id DESC
 ";
    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute();
    
    // Adiciona os registros retornados em $data[]
    while ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
        $data[] = $row;
    }
    // Retorna $data em formato json
    echo json_encode($data);
}

// Se a ação for "insert", faz um insert na tabela fatec_alunos
if ($received_data->action == 'insert') {
    $data = array(
        ':first_name' => $received_data->firstName,
        ':last_name' => $received_data->lastName
    );

    $query = "
 INSERT INTO fatec_alunos 
 (first_name, last_name) 
 VALUES (:first_name, :last_name)
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute($data);

    // Mensagem indicando que o aluno foi adicionado
    $output = array(
        'message' => 'Aluno Adicionado'
    );
    // Retorna $output em formato json
    echo json_encode($output);
}

// Se a ação for "fetchSingle", faz um select do ID do registro de "received_data" na tabela fatec_alunos
if ($received_data->action == 'fetchSingle') {
    $query = "
 SELECT * FROM fatec_alunos 
 WHERE id = '" . $received_data->id . "'
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute();

    $result = $statement->fetchAll();

    // Itera e retorna os dados do resultado em formato json
    foreach ($result as $row) {
        $data['id'] = $row['id'];
        $data['first_name'] = $row['first_name'];
        $data['last_name'] = $row['last_name'];
    }
    // Retorna $data em formato json
    echo json_encode($data);
}

// Se a ação for "update", faz um update na tabela fatec_alunos
if ($received_data->action == 'update') {
    $data = array(
        ':first_name' => $received_data->firstName,
        ':last_name' => $received_data->lastName,
        ':id' => $received_data->hiddenId
    );

    $query = "
 UPDATE fatec_alunos 
 SET first_name = :first_name, 
 last_name = :last_name 
 WHERE id = :id
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute($data);

    // Mensagem indicando que o aluno foi atualizado
    $output = array(
        'message' => 'Aluno Atualizado'
    );
    // Retorna $output em formato json
    echo json_encode($output);
}

// Se a ação for "delete", faz um delete na tabela fatec_alunos
if ($received_data->action == 'delete') {
    $query = "
 DELETE FROM fatec_alunos 
 WHERE id = '" . $received_data->id . "'
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute();

    // Mensagem indicando que o aluno foi deletado
    $output = array(
        'message' => 'Aluno Deletado'
    );
    // Retorna $data em formato json
    echo json_encode($output);
}

?>