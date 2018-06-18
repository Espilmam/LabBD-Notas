create database AulasColevati
go
use AulasColevati

create table aluno (

ra int identity (10000, 1) primary key,
nome varchar(50) not null
)

select * from aluno

create table disciplinas (

codigo char (7) primary key,
nome varchar(50) not null,
sigla varchar(5) not null,
turno char(1) not null,
num_aulas int not null
)

insert into disciplinas values 

(4203010, 'Arquitetura e Organização de Computadores', 'AOC', 'T', 80),
(4203020, 'Arquitetura e Organização de Computadores', 'AOC', 'N', 80),
(4208010, 'Laboratório de Hardware', 'LabHd', 'T', 40),
(4213003, 'Sistemas Operacionais 1', 'SO1', 'T', 80),
(4213013, 'Sistemas Operacionais 1', 'SO1', 'N', 80),
(4226004, 'Banco de Dados', 'BD', 'T', 80),
(4233005, 'Laboratório de Banco de Dados', 'LabBD', 'T', 80),
(5005220, 'Métodos Para a Produção do Conhecimento', 'MPDC', 'T', 40)

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
primary key (codigo_avaliacao, codigo_disciplina, ra_aluno)
)

create table faltas (

data_falta date,
ra_aluno int foreign key references aluno (ra),
codigo_disciplina char (7) foreign key references disciplinas (codigo),
presenca int null
primary key (ra_aluno, data_falta, codigo_disciplina)
)

create procedure pr_inserirnotas (@aluno_ra int, @disciplina_cod int, @avaliacao_cod int, @nota decimal, @saida varchar (max) output)
as
begin
	insert notas values (@avaliacao_cod, @aluno_ra, @disciplina_cod, @nota)
	set @saida = 'Nota inserida com sucesso!'
end

create procedure pr_inserirfaltas (@aluno_ra int, @disciplina_cod int, @presenca int, @data date, @saida varchar (max) output)
as
begin
	insert faltas values (@data, @aluno_ra, @disciplina_cod, @presenca)
	set @saida = 'Nota inserida com sucesso!'
end

create procedure pr_inserirAluno (@nome varchar(50), @saida  varchar (max) output)
as 
begin
	insert aluno values (@nome)

	declare @ra varchar (15) = (select top(1) ra from aluno where nome = @nome)
	set @saida = 'Aluno cadastrado com sucesso, RA: ' + @ra
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
preexame decimal(7,2) default 0,
notap3 decimal(7,2) null,
Media decimal(7,2) default 0,
Situacao varchar(20))
as
begin
		declare @ra int,
				@cod_ava int
		DECLARE C_ALUNO CURSOR FOR SELECT RA_ALUNO FROM NOTAS GROUP BY RA_ALUNO ORDER BY RA_ALUNO
		OPEN C_ALUNO
		FETCH NEXT FROM C_ALUNO INTO @RA
		--SELECT @RA = RA_ALUNO FROM NOTAS
		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @nome varchar(50),
					@nota decimal(7,2),
					@situacao varchar(20),
					@avaliacao varchar(25),
					@nota1 decimal(7,2),
					@nota2 decimal(7,2),
					@nota3 decimal(7,2),
					@prexame decimal(7,2),
					@notaP3 decimal(7,2),
					@media decimal(7,2)

			set @prexame = -1
			set @notaP3 = -1
			set @nota1 = 0
			set @nota2 = 0
			set @nota3 = 0
			set @media = 0
			set @avaliacao = null
			DECLARE C_PROX_NT CURSOR FOR SELECT codigo_avaliacao FROM NOTAS WHERE ra_aluno = @RA
			OPEN C_PROX_NT
			FETCH NEXT FROM C_PROX_NT INTO @COD_AVA
			WHILE @@FETCH_STATUS = 0
			BEGIN
				select @ra = nt.ra_aluno, @nome = al.nome, @nota = nt.nota from notas nt
				--select @nome =  al.nome, @avaliacao = av.tipo from notas nt
				inner join aluno al
				on nt.ra_aluno = al.ra
				inner join avaliacao av
				on nt.codigo_avaliacao = av.codigo
				where ra_aluno = @ra and codigo_avaliacao = @cod_ava
				--order by ra_aluno

				select @avaliacao = tipo from avaliacao
				where codigo = @cod_ava

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
					if (@avaliacao = 'Exame')
					begin
						set @notaP3 = @nota
					end

					set @media = (@nota1 * 0.3) + (@nota2 * 0.5) + (@nota3 * 0.2)
					if (@notaP3 != -1)
					begin
						set @media = (((@nota1 + @nota2) / 2) + @notaP3 ) / 2
					end
					

					if (@media < 3)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					if (@media < 6)
					begin
						set @situacao = 'EXAME'						
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
					if (@avaliacao = 'Pré Exame')
					begin
						set @prexame = @nota
					end
					if (@avaliacao = 'Exame')
					begin
						set @notaP3 = @nota
					end

					set @media = (@nota1 * 0.35) + (@nota2 * 0.35) + (@nota3 * 0.3)
					if (@notaP3 != -1)
					begin
						set @media = (((@nota1 + @nota2) / 2) + @notaP3 ) / 2
					end

					if (@prexame != -1)
					begin
						set @media = (@nota1 * 0.3) + (@nota2 * 0.5) + (@nota3 * 0.2) + (@prexame)
					end

					if (@media < 3)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					if (@media < 6)
					begin
						set @situacao = 'EXAME'						
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
					if (@avaliacao = 'Exame')
					begin
						set @notaP3 = @nota
					end

					set @media = (@nota1 * 0.333) + (@nota2 * 0.333) + (@nota3 * 0.333)
					if (@notaP3 != -1)
					begin
						set @media = (((@nota1 + @nota2) / 2) + @notaP3 ) / 2
					end

					if (@media < 3)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					if (@media < 6)
					begin
						set @situacao = 'EXAME'					
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
					if (@avaliacao = 'Exame')
					begin
						set @notaP3 = @nota
					end

					set @media = (@nota1 * 0.2) + (@nota2 * 0.8)

					if (@notaP3 != -1)
					begin
						set @media = (((@nota1 + @nota2) / 2) + @notaP3 ) / 2
					end

					if (@media < 3)
					begin
						set @situacao = 'REPROVADO'
					end
					else
					if (@media < 6)
					begin
						set @situacao = 'EXAME'						
					end
					else
					begin
						set @situacao = 'APROVADO'
					end
				end

				FETCH NEXT FROM C_PROX_NT INTO @COD_AVA
			END

			if (@notaP3 != -1)
			begin
				if (@media < 6)
				begin
					set @situacao = 'REPROVADO'						
				end
				else
				begin
					set @situacao = 'APROVADO'
				end
			end

			if(@notaP3 = -1)
			begin
				set @notaP3 = null
			end
			if (@prexame = -1)
			begin
				set @prexame = null
			end
			
			insert into @tabela values (@ra, @nome, @nota1, @nota2, @nota3, @prexame, @notaP3, @media, @situacao)
			CLOSE C_PROX_NT
			DEALLOCATE C_PROX_NT
		FETCH NEXT FROM C_ALUNO INTO @RA
		END
	CLOSE C_ALUNO
	DEALLOCATE C_ALUNO
return
end

select * from fn_recebefaltas(4203010)

drop function fn_recebefaltas

create function fn_recebefaltas(@DISCIPLINA CHAR (7))
returns @faltas table(
ra int,
nome varchar (20),
total_faltas int,
aula1 int,
aula2 int,
aula3 int,
aula4 int,
aula5 int,
aula6 int,
aula7 int,
aula8 int,
aula9 int,
aula10 int,
aula11 int,
aula12 int,
aula13 int,
aula14 int,
aula15 int,
aula16 int,
aula17 int,
aula18 int,
aula19 int,
aula20 int
)
as
begin
	declare @ra int,
			@nome varchar(50),
			@datas date

	declare f_aluno cursor for select ra_aluno from faltas where codigo_disciplina = @DISCIPLINA group by ra_aluno 
	open f_aluno
	fetch next from f_aluno into @ra
	while @@FETCH_STATUS = 0
	begin
		select @nome = nome from aluno where ra = @ra
		declare @query varchar (50),
				@total_falta int = 0,
				@aulacont int = 1,
				@aula1 int,
				@aula2 int,
				@aula3 int,
				@aula4 int,
				@aula5 int,
				@aula6 int,
				@aula7 int,
				@aula8 int,
				@aula9 int,
				@aula10 int,
				@aula11 int,
				@aula12 int,
				@aula13 int,
				@aula14 int,
				@aula15 int,
				@aula16 int,
				@aula17 int,
				@aula18 int,
				@aula19 int,
				@aula20 int

		insert into @faltas (ra, nome) values (@ra, @nome)

		declare c_datas cursor for select data_falta from faltas where codigo_disciplina = @DISCIPLINA group by data_falta
		open c_datas
		fetch next from c_datas into @datas
		while @@FETCH_STATUS = 0
		begin
			declare @presenca int = null
			
			if ((select presenca from faltas where data_falta = @datas and ra_aluno = @ra and codigo_disciplina = @DISCIPLINA) is not null)
			begin
				select @presenca = presenca from faltas where data_falta = @datas and ra_aluno = @ra and codigo_disciplina = @DISCIPLINA
				set @total_falta = @total_falta + ((@presenca - 4) * - 1)
			end

			if (@aulacont = 1)
			begin
				update @faltas set aula1 = @presenca where ra = @ra
			end
			else if (@aulacont = 2)
			begin
				update @faltas set aula2 = @presenca where ra = @ra
			end
			else if (@aulacont = 3)
			begin
				update @faltas set aula3 = @presenca where ra = @ra
			end
			else if (@aulacont = 4)
			begin
				update @faltas set aula4 = @presenca where ra = @ra
			end
			else if (@aulacont = 5)
			begin
				update @faltas set aula5 = @presenca where ra = @ra
			end
			else if (@aulacont = 6)
			begin
				update @faltas set aula6 = @presenca where ra = @ra
			end
			else if (@aulacont = 7)
			begin
				update @faltas set aula7 = @presenca where ra = @ra
			end
			else if (@aulacont = 8)
			begin
				update @faltas set aula8 = @presenca where ra = @ra
			end
			else if (@aulacont = 9)
			begin
				update @faltas set aula9 = @presenca where ra = @ra
			end
			else if (@aulacont = 10)
			begin
				update @faltas set aula10 = @presenca where ra = @ra
			end
			else if (@aulacont = 11)
			begin
				update @faltas set aula11 = @presenca where ra = @ra
			end
			else if (@aulacont = 12)
			begin
				update @faltas set aula12 = @presenca where ra = @ra
			end
			else if (@aulacont = 13)
			begin
				update @faltas set aula13 = @presenca where ra = @ra
			end
			else if (@aulacont = 14)
			begin
				update @faltas set aula14 = @presenca where ra = @ra
			end
			else if (@aulacont = 15)
			begin
				update @faltas set aula15 = @presenca where ra = @ra
			end
			else if (@aulacont = 16)
			begin
				update @faltas set aula16 = @presenca where ra = @ra
			end
			else if (@aulacont = 17)
			begin
				update @faltas set aula17 = @presenca where ra = @ra
			end
			else if (@aulacont = 18)
			begin
				update @faltas set aula18 = @presenca where ra = @ra
			end
			else if (@aulacont = 19)
			begin
				update @faltas set aula19 = @presenca where ra = @ra
			end
			else if (@aulacont = 20)
			begin
				update @faltas set aula20 = @presenca where ra = @ra
			end

			set @aulacont = @aulacont + 1

			fetch next from c_datas into @datas
		end

		update @faltas set total_faltas = @total_falta where ra = @ra
		close c_datas
		deallocate c_datas

		fetch next from f_aluno into @ra
	end
	close f_aluno
	deallocate f_aluno
	return
end

