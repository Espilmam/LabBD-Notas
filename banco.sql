create database AulasColevati
go
use AulasColevati

create table aluno (

ra int primary key,
nome varchar(50) not null
)

insert into aluno values

('000001','Holofontina'),
('000002','Karolayne'),
('000003','Kamilla'),
('000004','Thyagho'),
('000005','Athos')

create table disciplinas (

codigo char (7) primary key,
nome varchar(50) not null,
sigla varchar(5) not null,
turno char(1) not null,
num_aulas int not null
)

insert into disciplinas values 

(4203010, 'Arquitetura e Organização de Computadores', 'AOC', 'T', 0),
(4203020, 'Arquitetura e Organização de Computadores', 'AOC', 'N', 0),
(4208010, 'Laboratório de Hardware', 'LabHd', 'T', 0),
(4213003, 'Sistemas Operacionais 1', 'SO1', 'T', 0),
(4213013, 'Sistemas Operacionais 1', 'SO1', 'N', 0),
(4226004, 'Banco de Dados', 'BD', 'T', 0),
(4233005, 'Laboratório de Banco de Dados', 'LabBD', 'T', 0),
(5005220, 'Métodos Para a Produção do Conhecimento', 'MPDC', 'T', 0)

create table avaliacao (

codigo int primary key,
tipo varchar (25) not null
)

insert into avaliacao values
(1, 'P1'),
(2, 'P2'),
(3, 'P3'),
(4, 'T'),
(5, 'Monografia Completa'),
(6, 'Monografia Resumida'),
(7, 'Pré Exame'),
(8, 'Exame')

create table notas (

codigo_avaliacao int foreign key references avaliacao (codigo),
ra_aluno int foreign key references aluno (ra),
codigo_disciplina char (7) foreign key references disciplinas (codigo),
nota decimal(7,2) default 0
)

insert into notas values

(1,'000001',4203010, 7),
(2,'000001',4203010, 6),
(4,'000001',4203010, 2),
(1,'000002',4203010, 8),
(2,'000002',4203010, 8),
(4,'000002',4203010, 8),
(1,'000003',4203010, 5),
(2,'000003',4203010, 5),
(4,'000003',4203010, 5),
(1,'000004',4203010, 6),
(2,'000004',4203010, 6),
(4,'000004',4203010, 6),
(1,'000005',4203010, 2),
(2,'000005',4203010, 2),
(4,'000005',4203010, 2)

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

/*
Apresentar em tela, a saída de uma UDF, com cursor, que apresenta um quadro com as notas da turma:
(RA_Aluno, Nome_Aluno, Nota1, Nota2, ..., Média_Final, Situação(Aprovado ou Reprovado))
*/

select * from fn_recebenotas(4203010)

drop function fn_recebenotas

create function fn_recebenotas (@DISCIPLINA CHAR (7))
returns @tabela table (
RA int,
Nome varchar(50),
Nota1 decimal(7,2) default 0,
Nota2 decimal(7,2) default 0,
Nota3 decimal(7,2) default 0,
Media decimal(7,2) default 0,
Situacao varchar(20))
as
begin
declare @ra int = 5,
		@nome varchar(50),
		@nota decimal(7,2),
		@nota1 decimal(7,2),
		@nota2 decimal(7,2),
		@nota3 decimal(7,2),
		@media decimal(7,2),
		@situacao varchar(20),
		@avaliacao varchar(25),
		@cod_ava int
	
		DECLARE C_ALUNO CURSOR FOR SELECT RA_ALUNO FROM NOTAS GROUP BY RA_ALUNO ORDER BY RA_ALUNO
		OPEN C_ALUNO
		FETCH NEXT FROM C_ALUNO INTO @RA
		SELECT @RA = RA_ALUNO FROM NOTAS
		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE C_PROX_NT CURSOR FOR SELECT codigo_avaliacao FROM NOTAS
			OPEN C_PROX_NT
			FETCH NEXT FROM C_PROX_NT INTO @COD_AVA
			WHILE @@FETCH_STATUS = 0
			BEGIN
				select @ra = nt.ra_aluno, @nome = al.nome, @nota = nt.nota, @avaliacao = av.tipo from notas nt
				--select @nome =  al.nome, @avaliacao = av.tipo from notas nt
				inner join aluno al
				on nt.ra_aluno = al.ra
				inner join avaliacao av
				on nt.codigo_avaliacao = av.codigo
				where ra_aluno = @ra
				--order by ra_aluno

				-- AOC / LAB HARDWARE
				if (@DISCIPLINA = '4203010' OR @DISCIPLINA = '4203020' or @DISCIPLINA = '4208010' OR @DISCIPLINA = '4226004')
				begin
					if (@avaliacao = 'P1')
					begin
						set @nota1 = @nota
					end
					if (@avaliacao = 'P2')
					begin
						set @nota2 = @nota
					end
					if (@avaliacao = 'T')
					begin
						set @nota3 = @nota
					end

					set @media = (@nota1 * 0.3) + (@nota2 * 0.5) + (@nota3 * 0.2)

					if((@nota1 != 0 and @nota2 != 0 and @nota3 != 0) and @media < 6)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					begin
						set @situacao = 'APROVADO'
					end
				end
				-- SO I
				if (@DISCIPLINA = '4213003' OR @DISCIPLINA = '4213013')
				begin
					if (@avaliacao = 'P1')
					begin
						set @nota1 = @nota
					end
					if (@avaliacao = 'P2')
					begin
						set @nota2 = @nota
					end
					if (@avaliacao = 'T')
					begin
						set @nota3 = @nota
					end

					set @media = (@nota1 * 0.35) + (@nota2 * 0.35) + (@nota3 * 0.3)

					if((@nota1 != 0 and @nota2 != 0 and @nota3 != 0) and @media < 6)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					begin
						set @situacao = 'APROVADO'
					end
				end
				-- LAB BD
				if (@DISCIPLINA = '4233005')
				begin
					if (@avaliacao = 'P1')
					begin
						set @nota1 = @nota
					end
					if (@avaliacao = 'P2')
					begin
						set @nota2 = @nota
					end
					if (@avaliacao = 'P3')
					begin
						set @nota3 = @nota
					end

					set @media = (@nota1 * 0.333) + (@nota2 * 0.333) + (@nota3 * 0.333)

					if((@nota1 != 0 and @nota2 != 0 and @nota3 != 0) and @media < 6)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					begin
						set @situacao = 'APROVADO'
					end
				end
				-- MPPC
				if (@DISCIPLINA = '5005220')
				begin
					if (@avaliacao = 'Monografia Resumida')
					begin
						set @nota1 = @nota
					end
					if (@avaliacao = 'Monografia Completa')
					begin
						set @nota2 = @nota
					end

					set @media = (@nota1 * 0.2) + (@nota2 * 0.8)

					if((@nota1 != 0 and @nota2 != 0) and @media < 6)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					begin
						set @situacao = 'APROVADO'
					end
				end

				FETCH NEXT FROM C_PROX_NT INTO @COD_AVA
			END
			insert into @tabela values (@ra, @nome, @nota1, @nota2, @nota3, @media, @situacao)
			CLOSE C_PROX_NT
			DEALLOCATE C_PROX_NT
		FETCH NEXT FROM C_ALUNO INTO @RA
		END
	CLOSE C_ALUNO
	DEALLOCATE C_ALUNO
return
end


