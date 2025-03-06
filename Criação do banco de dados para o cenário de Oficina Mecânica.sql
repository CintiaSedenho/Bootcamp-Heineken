CREATE DATABASE OFICINA;
USE OFICINA;

-- Tabela Cliente
CREATE TABLE Cliente (
	ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
	Nome VARCHAR(100) not null,
    Endereco VARCHAR(200) not null,
    Telefone INT(20) not null,
    Email VARCHAR(45) not null
);

-- Tabela Veículo
CREATE TABLE Veiculo (
    ID_Veiculo INT PRIMARY KEY AUTO_INCREMENT,
    Placa VARCHAR(7) not null,
    Modelo VARCHAR(50) not null,
    Marca VARCHAR(50) not null,
    Ano YEAR not null,
    ID_Cliente INT not null,
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Mecânico
CREATE TABLE Mecanico (
    ID_Mecanico INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) not null,
    Endereco VARCHAR(200) not null,
    Especialidade VARCHAR(45)
);

-- Tabela Equipe
CREATE TABLE Equipe (
    ID_Equipe INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(20) not null,
	Especialidade VARCHAR(45) not null,	
	Turno VARCHAR(45)
);

-- Tabela Mecanico por Equipe (para N:M)
CREATE TABLE Mecanico_por_Equipe (
    ID_Equipe INT,
    ID_Mecanico INT,
    PRIMARY KEY (ID_Equipe, ID_Mecanico),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe),
    FOREIGN KEY (ID_Mecanico) REFERENCES Mecanico(ID_Mecanico)
);

-- Tabela Ordem de Serviço
CREATE TABLE OrdemServico( 
	ID_OrdemDeServico INT PRIMARY KEY AUTO_INCREMENT,   
	Numero_OS INT(10) not null,
	Tipo VARCHAR(45) not null,
	Data_Emissao DATE,
	Valor_Total DECIMAL(10,2),
	Status ENUM("Em andamento", "Concluida", "Cancelada"),
	Data_Conclusao DATE,
	ID_Veiculo INT,
    ID_Equipe INT,
    ID_Cliente INT,
    FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
    FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe),
    FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabela Serviço
CREATE TABLE Servico (
   	ID_Servico INT PRIMARY KEY AUTO_INCREMENT,
   	Descricao TEXT not null,
   	Valor DECIMAL(10,2) not null,
	Especialidade VARCHAR(50) not null,
	ID_OrdemDeServico INT,
	ID_Veiculo INT,
	ID_Cliente INT,
	ID_Equipe INT,
	FOREIGN KEY (ID_OrdemDeServico) REFERENCES OrdemDeServico(ID_OrdemDeServico),
	FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
   	FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
   	FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Tabela Peça
CREATE TABLE Peca (
   	ID_Peca INT PRIMARY KEY AUTO_INCREMENT,
   	Nome VARCHAR(45) not null,
   	Descricao TEXT not null,
   	Valor DECIMAL(10,2) not null,
   	ID_Servico INT,
	ID_OrdemDeServico INT,
	ID_Veiculo INT,
	ID_Cliente INT,
	ID_Equipe INT,
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico),
	FOREIGN KEY (ID_OrdemDeServico) REFERENCES OrdemDeServico(ID_OrdemDeServico),
	FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
   	FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
   	FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);

-- Tabela Mão de Obra
CREATE TABLE MaoDeObra (
   	ID_Mao_Obra INT PRIMARY KEY AUTO_INCREMENT,
   	Tipo VARCHAR(20),
   	Valor_Hora DECIMAL(10,2),
	ID_OrdemDeServico INT,
	ID_Veiculo INT,
	ID_Cliente INT,
	ID_Equipe INT,
	FOREIGN KEY (ID_OrdemDeServico) REFERENCES OrdemDeServico(ID_OrdemDeServico),
	FOREIGN KEY (ID_Veiculo) REFERENCES Veiculo(ID_Veiculo),
   	FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
   	FOREIGN KEY (ID_Equipe) REFERENCES Equipe(ID_Equipe)
);