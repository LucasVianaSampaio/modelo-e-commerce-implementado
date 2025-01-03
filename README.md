# Projeto Lógico de Banco de Dados para E-commerce
Este repositório contém o projeto lógico de banco de dados para um sistema de e-commerce. Ele foi desenvolvido para modelar e implementar um esquema de banco de dados que atende aos requisitos específicos de gerenciamento de clientes, pedidos, produtos, fornecedores, pagamentos e entregas.

## Descrição do Projeto
O objetivo deste projeto é criar um banco de dados relacional para armazenar e organizar os dados de um e-commerce, permitindo consultas complexas para análise de dados e suporte às operações da aplicação.

O banco de dados foi modelado seguindo as melhores práticas de normalização e incorpora constraints para garantir integridade referencial, além de relacionamentos mapeados de forma eficiente para cenários reais de comércio eletrônico.

## Modelagem do Banco de Dados
O modelo lógico foi construído para atender aos seguintes requisitos:

- Clientes: Podem ser Pessoa Física (PF) ou Pessoa Jurídica (PJ). Não é permitido que uma conta tenha ambas as informações simultaneamente.
- Produtos: Cadastro de produtos com informações detalhadas e controle de estoque.
- Fornecedores: Relacionamento com produtos para identificar a origem.
- Pedidos: Cada pedido é relacionado a um cliente e pode conter múltiplos itens.
- Pagamentos: Cada pedido pode ter uma ou mais formas de pagamento.
- Entrega: Gerenciamento do status e código de rastreamento dos pedidos.
