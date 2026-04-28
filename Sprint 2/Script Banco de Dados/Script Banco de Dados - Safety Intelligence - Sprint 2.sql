CREATE DATABASE if not exists safety_intelligence;
 -- drop database if exists safety_intelligence;
USE safety_intelligence;

-- =====================
-- TABELA ESTADO
-- =====================
CREATE TABLE estado (
    idEstado INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    sigla CHAR(2)
);

-- =====================
-- TABELA USUARIO
-- =====================
CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    senha VARCHAR(255),
    email VARCHAR(100)
);

-- =====================
-- TABELA FAVORITOS
-- =====================
CREATE TABLE favoritos (
    idFavoritos INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuarios INT,
    nomeEstado VARCHAR(45),
    idhGeral decimal(5,1),
    FOREIGN KEY (fkUsuarios) REFERENCES usuario(idUsuario)
);

-- =====================
-- TABELA MUNICIPIO
-- =====================
CREATE TABLE `municipio` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `idhm_geral` decimal(5,3) NOT NULL,
  `renda` decimal(12,2) NOT NULL,
  `educacao` decimal(5,3) NOT NULL,
  `longevidade` decimal(5,3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_municipio` (`nome`),
  KEY `idx_idhm` (`idhm_geral` DESC,`renda` DESC)
) ENGINE=InnoDB AUTO_INCREMENT=646 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- =====================
-- TABELA CRIMINALIDADE
-- =====================
CREATE TABLE criminalidade (
    idIbge INT PRIMARY KEY,
    totalLatrocinio INT,
    totalRouboVeiculo INT,
    totalFurto INT,
    fkMunicipio INT,
    FOREIGN KEY (fkMunicipio) REFERENCES municipio(idMunicipio)
);

-- =====================
-- TABELA IDHM
-- =====================
CREATE TABLE idhm (
    idIdhm INT PRIMARY KEY AUTO_INCREMENT,
    fkMunicipio INT,
    longevidade decimal(5,1),
    renda decimal(5,1),
    educacao decimal(5,1),
    FOREIGN KEY (fkMunicipio) REFERENCES municipio(idMunicipio)
);

-- =====================
-- TABELA HISTORICO
-- =====================
CREATE TABLE historico (
    idHistorico INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(45),
    descricao TEXT,
    tipo VARCHAR(45),
    fkUsuario INT,
    dataHora DATETIME(3),
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- =====================
-- TABELA ATIVIDADE
-- =====================
CREATE TABLE atividade (
    idAcesso INT PRIMARY KEY AUTO_INCREMENT,
    fkHistorico INT,
    tipo VARCHAR(45),
    FOREIGN KEY (fkHistorico) REFERENCES historico(idHistorico)
);

-- =====================
-- TABELA SLACK
-- =====================
CREATE TABLE slack (
    idSlack INT PRIMARY KEY AUTO_INCREMENT,
    fkUsuario INT,
    FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);


-- =====================
-- LOG
-- =====================
CREATE TABLE `log_sistema` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nivel` varchar(50) DEFAULT NULL,
  `mensagem` text,
  `data_hora` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- =====================
-- ESTADO
-- =====================
INSERT INTO estado (nome, sigla) VALUES
('São Paulo', 'SP'),
('Rio de Janeiro', 'RJ');

-- =====================
-- USUARIO
-- =====================
INSERT INTO usuario (senha, email) VALUES
('123456', 'user1@email.com'),
('abcdef', 'user2@email.com');




-- =====================
-- FAVORITOS
-- =====================
INSERT INTO favoritos (fkUsuarios, nomeEstado, idhGeral) VALUES
(1, 'São Paulo', 0.800),
(2, 'Rio de Janeiro', 0.700);

-- =====================
-- MUNICIPIO
-- =====================
INSERT INTO municipio (nome, fkUsuario, fkFavoritos, Npopulacional) VALUES
('Osasco', 1, 1, 700000),
('Niterói', 2, 2, 500000);

-- =====================
-- CRIMINALIDADE
-- =====================
INSERT INTO criminalidade (idIbge, totalLatrocinio, totalRouboVeiculo, totalFurto, fkMunicipio) VALUES
(1001, 50, 200, 500, 1),
(1002, 40, 180, 450, 2);

-- =====================
-- IDHM
-- =====================
INSERT INTO idhm (fkMunicipio, longevidade, renda, educacao) VALUES
(1, 0.8, 0.7, 0.75),
(2, 0.82, 0.72, 0.78);

-- =====================
-- HISTORICO
-- =====================
INSERT INTO historico (titulo, descricao, tipo, fkUsuario, dataHora) VALUES
('Consulta SP', 'Buscou dados de SP', 'consulta', 1, NOW()),
('Favoritou RJ', 'Adicionou RJ aos favoritos', 'acao', 2, NOW());

-- =====================
-- ATIVIDADE
-- =====================
INSERT INTO atividade (fkHistorico, tipo) VALUES
(1, 'consulta'),
(2, 'favorito');

-- =====================
-- SLACK
-- =====================
INSERT INTO slack (fkUsuario) VALUES
(1),
(2);