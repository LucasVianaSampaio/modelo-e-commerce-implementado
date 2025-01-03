CREATE DATABASE ECommerce;
USE ECommerce;

-- Tabela Clientes
CREATE TABLE Clientes (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    TipoCliente ENUM('PJ', 'PF') NOT NULL,
    CPF_CNPJ VARCHAR(14) UNIQUE NOT NULL
);

-- Tabela Produtos
CREATE TABLE Produtos (
    ProdutoID INT AUTO_INCREMENT PRIMARY KEY,
    NomeProduto VARCHAR(100) NOT NULL,
    Descricao TEXT,
    Preco DECIMAL(10, 2) NOT NULL,
    Estoque INT NOT NULL
);

-- Tabela Fornecedores
CREATE TABLE Fornecedores (
    FornecedorID INT AUTO_INCREMENT PRIMARY KEY,
    NomeFornecedor VARCHAR(100) NOT NULL,
    Contato VARCHAR(100)
);

-- Tabela Pedidos
CREATE TABLE Pedidos (
    PedidoID INT AUTO_INCREMENT PRIMARY KEY,
    ClienteID INT NOT NULL,
    DataPedido DATE NOT NULL,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

-- Tabela ItensPedido
CREATE TABLE ItensPedido (
    ItemPedidoID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT NOT NULL,
    ProdutoID INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);

-- Tabela Pagamentos
CREATE TABLE Pagamentos (
    PagamentoID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT NOT NULL,
    FormaPagamento ENUM('Cartão', 'Boleto', 'Pix') NOT NULL,
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);

-- Tabela Entrega
CREATE TABLE Entrega (
    EntregaID INT AUTO_INCREMENT PRIMARY KEY,
    PedidoID INT NOT NULL,
    StatusEntrega ENUM('Em preparação', 'Enviado', 'Entregue') NOT NULL,
    CodigoRastreamento VARCHAR(50),
    FOREIGN KEY (PedidoID) REFERENCES Pedidos(PedidoID)
);


-- Inserir Clientes
INSERT INTO Clientes (Nome, TipoCliente, CPF_CNPJ) VALUES 
('Empresa ABC', 'PJ', '12345678000199'),
('João Silva', 'PF', '12345678901');

-- Inserir Produtos
INSERT INTO Produtos (NomeProduto, Descricao, Preco, Estoque) VALUES 
('Notebook', 'Notebook Intel i5', 3500.00, 10),
('Mouse', 'Mouse Óptico', 50.00, 200);

-- Inserir Fornecedores
INSERT INTO Fornecedores (NomeFornecedor, Contato) VALUES 
('Tech Supplies', 'tech@supplies.com');

-- Inserir Pedidos
INSERT INTO Pedidos (ClienteID, DataPedido) VALUES 
(1, '2025-01-01'), 
(2, '2025-01-02');

-- Inserir ItensPedido
INSERT INTO ItensPedido (PedidoID, ProdutoID, Quantidade, PrecoTotal) VALUES 
(1, 1, 1, 3500.00),
(2, 2, 2, 100.00);

-- Inserir Pagamentos
INSERT INTO Pagamentos (PedidoID, FormaPagamento) VALUES 
(1, 'Cartão'),
(2, 'Pix');

-- Inserir Entrega
INSERT INTO Entrega (PedidoID, StatusEntrega, CodigoRastreamento) VALUES 
(1, 'Enviado', 'R12345BR'),
(2, 'Entregue', 'R54321BR');

SELECT c.Nome, COUNT(p.PedidoID) AS TotalPedidos
FROM Clientes c
LEFT JOIN Pedidos p ON c.ClienteID = p.ClienteID
GROUP BY c.Nome;

SELECT c.Nome AS Vendedor, f.NomeFornecedor AS Fornecedor
FROM Clientes c
JOIN Fornecedores f ON c.Nome = f.NomeFornecedor;

SELECT p.NomeProduto, f.NomeFornecedor, p.Estoque
FROM Produtos p
LEFT JOIN Fornecedores f ON f.FornecedorID = p.ProdutoID;

SELECT p.NomeProduto, SUM(i.Quantidade) AS TotalVendido
FROM ItensPedido i
JOIN Produtos p ON i.ProdutoID = p.ProdutoID
GROUP BY p.NomeProduto
ORDER BY TotalVendido DESC;

SELECT p.PedidoID, c.Nome, SUM(i.PrecoTotal) AS ValorTotal
FROM Pedidos p
JOIN Clientes c ON p.ClienteID = c.ClienteID
JOIN ItensPedido i ON p.PedidoID = i.PedidoID
GROUP BY p.PedidoID, c.Nome
HAVING SUM(i.PrecoTotal) > 500;

