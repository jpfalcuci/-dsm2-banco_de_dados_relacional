<?php
// Cabeçalho para acesso
header('Access-Control-Allow-Origin: *');

// Conexão com banco de dados
$connect = new PDO("mysql:host=localhost;dbname=BANCODEDADOS", "USER", "SENHA");

// Obtém os dados do input e decodifica de json para um objeto php
$received_data = json_decode(file_get_contents("php://input"));

$data = array();    // Array vazio

// Se a ação for "fetchall" seleciona tudo da tabela fatec_professores
if ($received_data->action == 'fetchall') {
    $query = "
 SELECT * FROM fatec_professores 
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

// Se a ação for "insert", faz um insert na tabela fatec_professores
if ($received_data->action == 'insert') {
    $data = array(
        ':nome' => $received_data->nome,
        ':endereco' => $received_data->endereco,
        ':curso' => $received_data->curso,
        ':salario' => $received_data->salario
    );

    $query = "
 INSERT INTO fatec_professores 
 (nome, endereco, curso, salario) 
 VALUES (:nome, :endereco, :curso, :salario)
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute($data);

    // Mensagem indicando que o professor foi adicionado
    $output = array(
        'message' => 'Professor Adicionado'
    );
    // Retorna $output em formato json
    echo json_encode($output);
}

// Se a ação for "fetchSingle", faz um select do ID do registro de "received_data" na tabela fatec_professores
if ($received_data->action == 'fetchSingle') {
    $query = "
 SELECT * FROM fatec_professores 
 WHERE id = '" . $received_data->id . "'
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute();

    $result = $statement->fetchAll();

    // Itera e retorna os dados do resultado em formato json
    foreach ($result as $row) {
        $data['id'] = $row['id'];
        $data['nome'] = $row['nome'];
        $data['endereco'] = $row['endereco'];
        $data['curso'] = $row['curso'];
        $data['salario'] = $row['salario'];
    }
    // Retorna $data em formato json
    echo json_encode($data);
}

// Se a ação for "update", faz um update na tabela fatec_professores
if ($received_data->action == 'update') {
    $data = array(
        ':nome' => $received_data->nome,
        ':endereco' => $received_data->endereco,
        ':curso' => $received_data->curso,
        ':salario' => $received_data->salario,
        ':id' => $received_data->hiddenId
    );

    $query = "
 UPDATE fatec_professores 
 SET nome = :nome, 
 endereco = :endereco,
 curso = :curso,
 salario = :salario 
 WHERE id = :id
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute($data);

    // Mensagem indicando que o professor foi atualizado
    $output = array(
        'message' => 'Professor Atualizado'
    );
    // Retorna $output em formato json
    echo json_encode($output);
}

// Se a ação for "delete", faz um delete na tabela fatec_professores
if ($received_data->action == 'delete') {
    $query = "
 DELETE FROM fatec_professores 
 WHERE id = '" . $received_data->id . "'
 ";

    // Prepara e executa a query
    $statement = $connect->prepare($query);
    $statement->execute();

    // Mensagem indicando que o professor foi deletado
    $output = array(
        'message' => 'Professor Deletado'
    );
    // Retorna $data em formato json
    echo json_encode($output);
}

?>