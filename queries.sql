use Pizzaria;

show tables; -- Mostrar tabelas

select * from Clientes; -- Mostrar Clientes

select * from Pizzas; -- Mostrar Pizzas

select sum(quantidade) from Itens_Pedido where pedido_id = 3; -- Mostra as pizzas do pedido numero 3

select c.nome from pedidos p inner join clientes c on p.cliente_id = c.cliente_id where p.pedido_id = 3; -- Mostra o nome do cliente do pedido numero 3

select pz.nome from Pizzas pz inner join Itens_Pedido p on p.pizza_id = pz.pizza_id where p.pedido_id = 3; -- Mostrar os nomes das pizzas do pedido nº 3

-- Desafios

-- Desafio 1
select p.pedido_id, ip.quantidade, c.nome, pz.nome from pedidos p inner join Itens_Pedido ip on p.pedido_id = ip.pedido_id inner join clientes c on p.cliente_id = c.cliente_id inner join pizza pz on ip.pizza_id = pz.pizza_id; -- Relatório que mostra todos os pedidos, itens, nome dos clientes e nome das pizzas.

-- Desafio 2
create view vw_relatorio_pedidos as
select
    p.pedido_id,
    ip.quantidade,
    c.nome as nome_cliente,
    pz.nome as nome_pizza,
    pz.valor * ip.quantidade as subtotal
from pedidos p
inner join Itens_Pedido ip
on p.pedido_id = ip.pedido_id
inner join clientes c
on p.cliente_id = c.cliente_id
inner join Pizzas pz
on ip.pizza_id = pz.pizza_id;

select * from vw_relatorio_pedidos;

-- Desafio 3
select
    p.pedido_id,
    sum(pz.valor * ip.quantidade) as valor_total
from pedidos p
inner join Itens_Pedido ip
on p.pedido_id = ip.pedido_id
inner join Pizzas pz
on ip.pizza_id = pz.pizza_id
group by p.pedido_id;

-- Desafio 4
select
    p.pedido_id,
    count(ip.pizza_id) as quantidade_pizzas
from pedidos p
inner join Itens_Pedido ip
on p.pedido_id = ip.pedido_id
group by p.pedido_id;

-- DML Manipulando dados

insert into clientes (
    nome, logradouro, numero, bairro, referencia, telefone
) values (
    'Gaspar Oliveira',
    'Rua Lizandro Silva',
    21,
    'São Dimas',
    'Ao lado da igrejinha',
    '19 99898-1141'
);

insert into pedidos (cliente_id) values (10);

insert into Itens_Pedido (pedido_id, pizza_id, quantidade) values (15, 1, 1), (15, 2, 2);

-- acrescentando a pizza 


insert into pizzas (
    nome,
    descricao,
    valor
) values (
    'a moda do chef',
    'molho de tomate, palmito macio em rodelas, coberto com catupiry, frango desfiado, ovos, carne seca, oregano e azeitonas',
    41.90
);


insert into pedidos (cliente_id)
select cliente_id
from clientes
where nome = 'gaspar oliveira';



insert into itens_pedido (
    pedido_id,
    pizza_id,
    quantidade
)
select
    (select max(pedido_id) from pedidos),
    pizza_id,
    2
from pizzas
where nome = 'a moda do chef';


update itens_pedido
set quantidade = 3
where pedido_id = (
    select max(pedido_id) from pedidos
)
and pizza_id = (
    select pizza_id
    from pizzas
    where nome = 'a moda do chef'
);


insert into itens_pedido (
    pedido_id,
    pizza_id,
    quantidade
)
select
    (select max(pedido_id) from pedidos),
    pizza_id,
    1
from pizzas
where nome = 'margherita';

-- Para verificar tudo

select * from clientes
where nome like '%Gaspar%';

select * from pizzas
where nome like '%chef%';
