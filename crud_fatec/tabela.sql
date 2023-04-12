CREATE TABLE `fatec_professores` (
    `id` int(11) NOT NULL,
    `nome` varchar(255) NOT NULL,
    `endereco` varchar(255) NOT NULL,
    `curso` varchar(100) NOT NULL, 
    `salario` decimal(7,2) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

ALTER TABLE `fatec_professores`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `fatec_professores`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;