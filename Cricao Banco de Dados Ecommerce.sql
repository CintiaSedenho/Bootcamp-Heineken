-- Criação do banco de dados para o cenário de E-commerce
CREATE DATABASE Ecommerce;
USE Ecommerce;

-- Criar tabela cliente
CREATE TABLE Cliente (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    StatusCliente ENUM('Ativo', 'Inativo') NOT NULL,
    DataCriacaoCliente DATE NOT NULL,
    DataAtualizacaoCliente DATE NOT NULL,
    UltimoAcesso DATETIME NOT NULL,
    NomeCliente VARCHAR(15) NOT NULL,
    SobrenomeCliente VARCHAR(45) NOT NULL,
    EmailCliente VARCHAR(50) NOT NULL,
    IdentificacaoCliente ENUM('PF', 'PJ') NOT NULL,
    CPFCliente CHAR(11) NOT NULL UNIQUE,
    CNPJCliente CHAR(14) NOT NULL UNIQUE,
    NascimentoCliente DATE NOT NULL
);

-- Criar tabela endereço
CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    idClient INT,
    TipoEndereco VARCHAR(15) NOT NULL,
    CEP CHAR(8) NOT NULL,    
    Logradouro VARCHAR(100) NOT NULL,
    Numero INT(5) NOT NULL,
    Complemento VARCHAR(45),
    Bairro VARCHAR(45) NOT NULL,
    Cidade VARCHAR(45) NOT NULL,
    UF CHAR(2) NOT NULL,
    FOREIGN KEY (idClient) REFERENCES cliente(idClient)
);

-- Criar tabela pedido
CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    DataPedido DATE NOT NULL,
    DescricaoDoPedido VARCHAR(45) NOT NULL,
    ValorPedido FLOAT NOT NULL,
    Frete FLOAT NOT NULL,
    FOREIGN KEY (idCliente) REFERENCES cliente(idClient)
);

-- Criar tabela pagamento
CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idCliente INT NOT NULL,
    Forma ENUM('A VISTA', 'PARCELADO') NOT NULL,
    Tipo ENUM('DEBITO', 'CREDITO', 'BOLETO', 'PIX', 'CRIPTO') NOT NULL,
    QuantParcelas INT NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idCliente) REFERENCES cliente(idClient)
);

-- Criar tabela StatusPedido
CREATE TABLE StatusPedido (
    idStatusPedido INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idCliente INT NOT NULL,
    AguardandoAprovacao TINYINT,
    Aprovado TINYINT,
    Separado TINYINT,
    Enviado TINYINT,
    Entregue TINYINT,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idCliente) REFERENCES cliente(idClient)
);

-- Criar tabela entrega
CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idStatusPedido INT NOT NULL,
    DataEntrega DATE NOT NULL,
    CodigoRastreio VARCHAR(30), 
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idStatusPedido) REFERENCES StatusPedido(idStatusPedido)
);

-- Criar tabela devolução
CREATE TABLE Devolucao (
    idDevolucao INT AUTO_INCREMENT PRIMARY KEY,
    idPedido INT NOT NULL,
    idProduto INT NOT NULL,
    idEntrega INT NOT NULL,
    DataDevolucao DATE NOT NULL,
    Motivo VARCHAR(45) NOT NULL,
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idEntrega) REFERENCES Entrega(idEntrega)
);

-- Criar tabela produto
CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    idCategoria INT NOT NULL,
    DescricaoProduto VARCHAR(45) NOT NULL,
    ValorProduto FLOAT NOT NULL,
    FOREIGN KEY (idCategoria) REFERENCES CategoriaProduto(idCategoria)
);

-- Criar tabela Quantidade de Produto
CREATE TABLE QuantidadeProduto (
    idProduto INT NOT NULL,
    idPedido INT NOT NULL,
    QuantidadeProduto INT NOT NULL,
    UnidadeMedida ENUM('g', 'kg', 'L', 'ml', 'unid') NOT NULL,
    PRIMARY KEY (idProduto, idPedido),
    FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (idPedido) REFERENCES pedido(idPedido)
);

-- Criar tabela Categoria de Produto
CREATE TABLE CategoriaProduto ( 
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    NomeCategoria VARCHAR(15) NOT NULL
);

-- Criar tabela estoque
CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Local VARCHAR(45) NOT NULL
);

-- Criar tabela fornecedor
CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    DataCriacaoFornecedor DATE NOT NULL,
    DataAtualizacaoFornecedor DATE NOT NULL,
    NomeFantasia VARCHAR(50) NOT NULL,
    RazaoSocial VARCHAR(50) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Endereco VARCHAR(45) NOT NULL,
    Numero INT(5) NOT NULL,
    Complemento VARCHAR(15),
    CEP CHAR(8) NOT NULL,
    Cidade VARCHAR(20) NOT NULL,
    UF CHAR(2) NOT NULL
);

-- Criar tabela terceiros
CREATE TABLE Terceiro (
    idTerceiro INT AUTO_INCREMENT PRIMARY KEY,
    DataCriacaoTerceiro DATE NOT NULL,
    DataAtualizacaoTerceiro DATE NOT NULL,
    RazaoSocial VARCHAR(50) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    Endereco VARCHAR(45) NOT NULL,
    Numero INT(5) NOT NULL,
    Complemento VARCHAR(15),
    CEP CHAR(8) NOT NULL,
    Cidade VARCHAR(20) NOT NULL,
    UF CHAR(2) NOT NULL
);
    