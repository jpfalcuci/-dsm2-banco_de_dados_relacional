CREATE TABLE `fatec_alunos` (
    `id` int(11) NOT NULL,
    `first_name` varchar(255) NOT NULL,
    `last_name` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `fatec_alunos` (`id`, `first_name`, `last_name`) VALUES
(1, 'John', 'Smith'),
(2, 'Peter', 'Parker'),
(3, 'Donna', 'Huber');

ALTER TABLE `fatec_alunos`
    ADD PRIMARY KEY (`id`);

ALTER TABLE `fatec_alunos`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;