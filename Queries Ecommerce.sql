
-- Recuperações de dados com SELECT Statement
/* Objetivo: Recuperar todos os dados de um cliente e suas informações de endereço. */
SELECT 
    c.idClient, 
    c.NomeCliente, 
    c.SobrenomeCliente, 
    c.EmailCliente, 
    e.Logradouro, 
    e.Cidade, 
    e.UF
FROM 
    cliente c
JOIN 
    endereco e ON c.idClient = e.idClient;

-- Filtro com WHERE Statement
/* Objetivo: Recuperar todos os clientes que possuem um status "Ativo" e que são do tipo "Pessoa Jurídica" (PJ). */
SELECT 
    idClient, 
    NomeCliente, 
    SobrenomeCliente, 
    IdentificacaoCliente 
FROM 
    cliente
WHERE 
    StatusCliente = 'Ativo' 
    AND IdentificacaoCliente = 'PJ';

-- Ordenações dos dados com ORDER BY
/* Objetivo: Listar todos os pedidos ordenados pelo valor do pedido em ordem decrescente. */
SELECT 
    p.idPedido, 
    p.DataPedido, 
    p.DescricaoDoPedido, 
    p.ValorPedido 
FROM 
    pedido p
ORDER BY 
    p.ValorPedido DESC;

-- Condições de filtros aos grupos – HAVING Statement
/* Objetivo: Encontrar clientes que realizaram mais de 5 pedidos, filtrando pela quantidade de pedidos feitos. */
SELECT 
    p.idCliente, 
    COUNT(p.idPedido) AS NumeroPedidos
FROM 
    pedido p
GROUP BY 
    p.idCliente
HAVING 
    COUNT(p.idPedido) > 5;

-- Criar um relacionamento entre cliente e pagamentos 
/* Objetivo: Listar clientes que têm mais de uma forma de pagamento registrada para seus pedidos. */
SELECT 
    c.idClient, 
    c.NomeCliente, 
    COUNT(DISTINCT pa.Tipo) AS NumeroFormasPagamento
FROM 
    cliente c
JOIN 
    pedido p ON c.idClient = p.idCliente
JOIN 
    pagamento pa ON p.idPedido = pa.idPedido
GROUP BY 
    c.idClient
HAVING 
    COUNT(DISTINCT pa.Tipo) > 1;

-- Junções entre tabelas
/*Objetivo: Mostrar informações de pedidos com os respectivos clientes, incluindo os métodos de pagamento utilizados e o status da entrega.*/
SELECT 
    p.idPedido, 
    p.DataPedido, 
    p.DescricaoDoPedido, 
    c.NomeCliente, 
    c.SobrenomeCliente, 
    pa.Forma AS MetodoPagamento, 
    e.DataEntrega, 
    sp.Aprovado AS StatusPedido
FROM 
    pedido p
JOIN 
    cliente c ON p.idCliente = c.idClient
JOIN 
    pagamento pa ON p.idPedido = pa.idPedido
JOIN 
    entrega e ON p.idPedido = e.idPedido
JOIN 
    StatusPedido sp ON p.idPedido = sp.idPedido
WHERE 
    sp.Aprovado = 1
ORDER BY 
    p.DataPedido DESC;

/* Objetivo: Recuperar todas as entregas com o status e código de rastreio. */
SELECT 
    e.idEntrega, 
    e.DataEntrega, 
    sp.AguardandoAprovacao, 
    sp.Aprovado, 
    sp.Separado, 
    sp.Enviado, 
    sp.Entregue, 
    e.CodigoRastreio
FROM 
    Entrega e
JOIN 
    StatusPedido sp ON e.idPedido = sp.idPedido
WHERE 
    e.DataEntrega IS NOT NULL;

-- Excluir Dados de Pedidos Cancelados
/* Objetivo: Excluir os pedidos que foram marcados como "Cancelado" e cujas entregas não foram realizadas. */
DELETE FROM pedido
WHERE idPedido IN (
    SELECT idPedido
    FROM StatusPedido
    WHERE Cancelado = 1 AND Entregue IS NULL
);

-- Atualizar Status de Entrega
 /* Objetivo: Atualizar o status de entrega para um pedido específico, alterando o status para "Entregue". */
UPDATE StatusPedido
SET Entregue = 1, Enviado = 0
WHERE idPedido = 1001;


-- Consultar Pedidos com Mais de uma Forma de Pagamento e Status de Entrega
 /* Objetivo: Mostrar todos os pedidos com múltiplas formas de pagamento e suas respectivas informações de entrega.*/
SELECT 
    p.idPedido, 
    p.DataPedido, 
    pa.Forma AS MetodoPagamento, 
    e.DataEntrega, 
    sp.Aprovado, 
    sp.Entregue
FROM 
    pedido p
JOIN 
    pagamento pa ON p.idPedido = pa.idPedido
JOIN 
    entrega e ON p.idPedido = e.idPedido
JOIN 
    StatusPedido sp ON p.idPedido = sp.idPedido
GROUP BY 
    p.idPedido
HAVING 
    COUNT(DISTINCT pa.Tipo) > 1
ORDER BY 
    p.DataPedido DESC;