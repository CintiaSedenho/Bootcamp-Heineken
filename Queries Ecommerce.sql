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

SELECT 
    idClient, 
    NomeCliente, 
    SobrenomeCliente, 
    DATEDIFF(CURDATE(), NascimentoCliente) / 365 AS IdadeCliente
FROM 
    cliente;

SELECT 
    p.idPedido, 
    p.DataPedido, 
    p.DescricaoDoPedido, 
    p.ValorPedido 
FROM 
    pedido p
ORDER BY 
    p.ValorPedido DESC;

SELECT 
    p.idCliente, 
    COUNT(p.idPedido) AS NumeroPedidos
FROM 
    pedido p
GROUP BY 
    p.idCliente
HAVING 
    COUNT(p.idPedido) > 5;

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

DELETE FROM pedido
WHERE idPedido IN (
    SELECT idPedido
    FROM StatusPedido
    WHERE Cancelado = 1 AND Entregue IS NULL
);

UPDATE StatusPedido
SET Entregue = 1, Enviado = 0
WHERE idPedido = 1001;

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
    
    

