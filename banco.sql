create database AulasColevati
go
use AulasColevati

create table aluno (

ra int primary key,
nome varchar(50) not null
)
create table disciplinas (

codigo char (7) primary key,
nome varchar(50) not null,
sigla varchar(5) not null,
turno char(1) not null,
num_aulas int not null
)

insert into disciplinas values 

(4203010, 'Arquitetura e Organiza��o de Computadores', 'AOC', 'T', 0),
(4203020, 'Arquitetura e Organiza��o de Computadores', 'AOC', 'N', 0),
(4208010, 'Laborat�rio de Hardware', 'LabHard', 'T', 0),
(4213003, 'Sistemas Operacionais 1', 'SO1', 'T', 0),
(4213013, 'Sistemas Operacionais 1', 'SO1', 'N', 0),
(4226004, 'Banco de Dados', 'BD', 'T', 0),
(4233005, 'Laborat�rio de Banco de Dados', 'LabBD', 'T', 0),
(5005220, 'M�todos Para a Produ��o do Conhecimento', 'MPAPDC', 'T', 0)

create table avaliacao (

codigo int primary key,
tipo varchar (10) not null
)

insert into avaliacao values
(1, 'P1'),
(2, 'P2'),
(3, 'P3'),
(4, 'T'),
(5, 'Monografia Completa'),
(6, 'Monografia Resumida')

create table notas (

codigo_avaliacao int foreign key references avaliacao (codigo),
ra_aluno int foreign key references aluno (ra),
codigo_disciplina char (7) foreign key references disciplinas (codigo),
nota decimal(7,2) default 0
)

create table faltas (

data_falta date primary key,
ra_aluno int foreign key references aluno (ra),
codigo_disciplina char (7) foreign key references disciplinas (codigo),
presenca int default 0
)

create procedure pr_inserirnotas (@aluno_ra int, @disciplina_cod int, @avalicao_cod int, @nota decimal)
as
begin
insert notas (@avaliacao_cod, @aluno_ra, @disciplina_cod, @nota)
end

create procedure pr_inserirfaltas (@aluno_ra int, @disciplina_cod int, @presenca int, @data date)
as
begin
	insert faltas (@data, @aluno_ra, @disciplina_cod, @presenca)
end