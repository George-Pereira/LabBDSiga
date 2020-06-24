create database db_SIGA
go
use db_SIGA

-- DROP DE TODAS AS TABELAS
drop table aluno
drop table disciplina
drop table avaliacao
drop table faltas
drop table notas


-- ACREDITO QUE NAO PRECISE FAZER VALIDAÇÂO DO RA
create table aluno (
	ra varchar(13) primary key,
	nome varchar(100))


-- FORMATO DO CODIGO: XXXX-XXX
-- SIGLA: SSSXXX (S - caractere) - TEMOS QUE PERGUNTAR AS SIGLAS DAS MATERIAS.
-- TURNO: M, N, T
create table disciplina (
	codigo varchar(8) primary key,
	nome varchar(100),
	sigla char(6),
	turno char(1),
	num_aulas int)

-- TIPO: P1, P2, P3
create table avaliacao (
	codigo int primary key,
	tipo varchar(20))

-- Avaliacao de cada disciplina
create table disciplina_avaliacao (
	cod_disciplina varchar(8),
	cod_avaliacao int,
	CONSTRAINT pk_discAvaliacao primary key(cod_disciplina, cod_avaliacao),
	foreign key (cod_disciplina) references disciplina(codigo),
	foreign key (cod_avaliacao) references avaliacao(codigo))
	
	
-- MATRICULA DO ALUNO EM UMA MATERIA
create table matricula (
	ra_aluno varchar(13),
	codigo_disciplina varchar(8),
	CONSTRAINT pk_MATRICULA primary key (ra_aluno, codigo_disciplina),
	foreign key(ra_aluno) references aluno(ra),
	foreign key(codigo_disciplina) references disciplina(codigo))

-- PRESENCAS: 0 para nenhuma FALTA
--			  1 para UMA falta na aula
--			  2 para DUAS faltas na aula
--			  3 para TRES faltas na aula
--			  4 para QUATRO faltas na aula
-- DATA: tive de nomear como DIA pois 'data' é uma palavra reservada
create table faltas (
	ra_aluno varchar(13),
	codigo_disciplina varchar(8),
	dia Date,
	presencas int,
	CONSTRAINT pk_FALTA primary key(ra_aluno,codigo_disciplina, dia),
	foreign key (ra_aluno) references aluno(ra),
	foreign key (codigo_disciplina) references disciplina(codigo))

-- NOTA: fazer a validação se é 0 <= nota <= 10 no JAVA
create table notas (
	ra_aluno varchar(13),
	codigo_disciplina varchar(8),
	codigo_avaliacao int,
	nota decimal (4,2),
	peso decimal (4,2),
	CONSTRAINT pk_NOTA primary key(ra_aluno, codigo_disciplina, codigo_avaliacao),
	foreign key (ra_aluno) references aluno(ra),
	foreign key (codigo_disciplina) references disciplina(codigo),
	foreign key (codigo_avaliacao) references avaliacao(codigo))


select * from disciplina
-- TODAS AS DISCIPLINAS
insert into disciplina values
('4203-010', 'Arquitetura e Organização de Computadores', 'AOC001', 'T', 80),
('4203-020', 'Arquitetura e Organização de Computadores', 'AOC001', 'N', 80),
('4208-010', 'Laboratório de Hardware', 'LHW001', 'T', 40),
('4226-004', 'Banco de Dados', 'BDD001', 'T', 80),
('4213-003', 'Sistemas Operacionais I', 'SOP001', 'T', 80),
('4213-013', 'Sistemas Operacionais I', 'SOP001', 'N', 80),
('4233-005', 'Laboratório de Banco de Dados', 'LBD001', 'T', 80),
('5005-220', 'Métodos Para a Produção do Conhecimento', 'MPC001' , 'M', 80)


select * from avaliacao
-- TODAS AS AVALIACOES
insert into avaliacao values
(1,'P1'),
(2,'P2'),
(3,'P3'),
(4,'T'),
(5,'Exame Final'),
(6,'Pré-Exame'),
(7,'Monografia Completa'),
(8,'Monografia Resumida')



insert into disciplina_avaliacao values
('4203-010', 1),
('4203-010', 2),
('4203-010', 4),
('4203-010', 5),
('4203-020', 1),
('4203-020', 2),
('4203-020', 4),
('4203-020', 5),
('4208-010', 1),
('4208-010', 2),
('4208-010', 4),
('4208-010', 5),
('4226-004', 1),
('4226-004', 2),
('4226-004', 4),
('4226-004', 5),
('4213-003', 1),
('4213-003', 2),
('4213-003', 4),
('4213-003', 5),
('4213-003', 6),
('4233-005', 1),
('4233-005', 2),
('4233-005', 3),
('4233-005', 5),
('5005-220', 7),
('5005-220', 8),
('5005-220', 5)

select a.codigo, a.tipo from avaliacao a inner join disciplina_avaliacao da on da.cod_avaliacao = a.codigo
										 inner join disciplina d on d.codigo = da.cod_disciplina 
										 where da.cod_disciplina = '4213-003'


-- ALUNOS
insert into aluno values
('1110481812042', 'Fellipe Alves Andrade'),
('1110481812043', 'Fernando George Pereira'),
('1110481812034', 'Rafael Antonio Ferreira Borges'),
('1110481812022', 'João Vitor Sardinha de Arruda'),
('1110481812012', 'José Luis dos Santos'),
('1110481812033', 'Jonathas Moreira de Amorim Lopes'),
('1110481812031', 'Leandro Colevati dos Santos')

INSERT INTO matricula (ra_aluno, codigo_disciplina) VALUES
('1110481812034', '4203-010'),
('1110481812022', '4203-010'),
('1110481812012', '4203-010'),
('1110481812033', '4203-010'),
('1110481812031', '4203-010')

-- PROCEDURE PARA INSERIR NOTA COM O PESO
create procedure sp_insereNota (@ra_aluno varchar(13), @codigo_disciplina varchar(8), @codigo_avaliacao int, @nota decimal(4,2), @peso decimal(4,2))
AS
BEGIN
	IF (@ra_aluno IS NULL OR @codigo_disciplina IS NULL OR @codigo_avaliacao IS NULL OR @nota IS NULL OR @peso IS NULL)
	BEGIN
		RAISERROR('Valores Inválidos!',16,1)
	END
	ELSE
	BEGIN
		INSERT INTO notas VALUES (@ra_aluno, @codigo_disciplina, @codigo_avaliacao, @nota, @peso)
	END
END


-- PROCEDURE PARA INSERIR AS FALTAS DO ALUNO
create procedure sp_insereFaltas (@ra_aluno varchar(13), @codigo_disciplina varchar(8), @dia Date, @presencas int)
AS
BEGIN
	IF (@ra_aluno IS NULL OR @codigo_disciplina IS NULL OR @dia IS NULL)
	BEGIN
		RAISERROR('Valores Inválidos!',16,1)
	END
	ELSE
	BEGIN
		IF (@presencas IS NULL)
		BEGIN
			SET @presencas = 0
		END
		INSERT INTO faltas VALUES (@ra_aluno, @codigo_disciplina, @dia, @presencas)
	END
END


CREATE FUNCTION fn_listachamada(@cod_disc VARCHAR(8))
RETURNS @tabela TABLE(
ra_aluno		VARCHAR(13),
nome_aluno		VARCHAR(100))
AS
BEGIN
	DECLARE @pos INT
	INSERT @tabela(ra_aluno, nome_aluno)
		SELECT a.ra, a.nome FROM aluno a INNER JOIN faltas flt ON a.ra = flt.ra_aluno INNER JOIN disciplina disc ON flt.codigo_disciplina = disc.codigo WHERE disc.codigo = @cod_disc Order by a.nome
	RETURN
END
SELECT * FROM fn_listachamada('4203-010')

INSERT INTO matricula (ra_aluno, codigo_disciplina) VALUES
('1110481812042', '4203-010'),
('1110481812034', '4203-020'),
('1110481812043', '4203-010'),
('1110481812033', '4203-020')

---- G
CREATE TRIGGER t_protegerDisciplinas ON disciplina
FOR UPDATE, DELETE
AS
	DECLARE @contexto INT
	SELECT @contexto = (SELECT COUNT(codigo) FROM deleted)
	IF(@contexto <> 0)
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR('Não é permitido alterar/deletar nenhum registro de Disciplinas', 16, 1)
	END

---- UDF COM CURSOR - GERAR MEDIAS ----
---- C
CREATE FUNCTION fn_Notas(@codDisciplina varchar(10))
RETURNS @tabela table(RA_Aluno varchar(13),
					  Nome_Aluno varchar(100),
					  P1 decimal(4,2),
					  P2 decimal(4,2),
					  P3 decimal(4,2),
					  T decimal(4,2),
					  EF decimal(4,2),
					  PE decimal(4,2),
					  MC decimal(4,2),
					  MR decimal(4,2),
					  Media_Final decimal(4,2),
					  Situacao varchar(20),
					  Nome_Disciplina varchar(150),
					  SP1 decimal(7,2),
					  SP2 decimal(7,2),
					  SP3 decimal(7,2),
					  ST decimal(7,2),
					  SEF decimal(7,2),
					  SPE decimal(7,2),
					  SMC decimal(7,2),
					  SMR decimal(7,2))
as
BEGIN
	DECLARE @ra varchar(20),
			@nome_aluno varchar(150),
			@Media_Final decimal(7,2)
	DECLARE cur_Media CURSOR FOR
		SELECT a.ra, a.nome from aluno a inner join matricula mat on mat.ra_aluno = a.ra where mat.codigo_disciplina = @codDisciplina
	OPEN cur_Media
	FETCH NEXT FROM cur_Media INTO @ra, @nome_aluno
	While @@FETCH_STATUS = 0
	BEGIN
		SET @Media_Final = (select CONVERT(decimal(7,1), SUM(n.nota*n.peso)) 
			from notas n inner join disciplina d on d.codigo = n.codigo_disciplina 
			inner join aluno a on a.ra = n.ra_aluno where d.codigo = @codDisciplina AND n.ra_aluno = @ra AND n.codigo_avaliacao != 5 AND n.codigo_avaliacao != 6)
		INSERT INTO @tabela(RA_Aluno, Nome_Aluno, Media_Final) VALUES (@ra, @nome_aluno, @Media_Final)
		DECLARE @nota decimal(7,2),
				@codigo_avaliacao int
		DECLARE cur_Notas CURSOR FOR
			SELECT n.nota, n.codigo_avaliacao FROM notas n where n.ra_aluno = @ra and n.codigo_disciplina = @codDisciplina order by codigo_avaliacao
		OPEN cur_Notas
		FETCH NEXT FROM cur_Notas into @nota, @codigo_avaliacao
		WHILE @@FETCH_STATUS = 0
		BEGIN
			------------------------- COLOCA A SITUAÇÂO E VERIFICA SE FEZ O EXAME FINAL OU PRE EXAME
			DECLARE @preExame decimal(7,2),
					@ExameFinal decimal(7,2),
					@pesoExam decimal(7,2)
			IF (@codigo_avaliacao = 6)
			BEGIN
				SELECT @preExame = n.nota, @pesoExam = n.peso from notas n where n.ra_aluno = @ra AND n.codigo_disciplina = @codDisciplina AND n.codigo_avaliacao = 6
				UPDATE @tabela SET Media_Final = Media_Final + (@preExame * @pesoExam) where RA_Aluno = @ra
			END	
			ELSE
			BEGIN
				IF(@codigo_avaliacao = 5)
				BEGIN
					SELECT @ExameFinal = n.nota, @pesoExam = n.peso from notas n where n.ra_aluno = @ra AND n.codigo_disciplina = @codDisciplina AND n.codigo_avaliacao = 5
					UPDATE @tabela SET Media_Final = (Media_Final + @ExameFinal) / 2 where RA_Aluno = @ra
				END
			END
			UPDATE @tabela SET Situacao = 'APROVADO' WHERE Media_Final >= 6
			UPDATE @tabela SET Situacao = 'REPROVADO' WHERE Media_Final < 6
	------------------------------------------- PREENCHE AS COLUNAS
			UPDATE @tabela SET P1 = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 1
			UPDATE @tabela SET P2 = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 2
			UPDATE @tabela SET P3 = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 3
			UPDATE @tabela SET T = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 4
			UPDATE @tabela SET EF = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 5
			UPDATE @tabela SET PE = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 6
			UPDATE @tabela SET MC = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 7
			UPDATE @tabela SET MR = @nota WHERE RA_Aluno = @ra AND @codigo_avaliacao = 8
			FETCH NEXT FROM cur_Notas into @nota, @codigo_avaliacao
		END
		CLOSE cur_Notas
		DEALLOCATE cur_Notas
		FETCH NEXT FROM cur_Media INTO @ra, @nome_aluno
	END
	CLOSE cur_Media
	DEALLOCATE cur_Media
	UPDATE @tabela SET Nome_Disciplina = (SELECT nome+' - '+turno from disciplina where codigo = @codDisciplina)
	UPDATE @tabela SET SP1 = (SELECT SUM(P1) from @tabela),
					   SP2 = (SELECT SUM(P2) from @tabela),
					   SP3 = (SELECT SUM(P3) from @tabela),
					   ST = (SELECT SUM(T) from @tabela),
					   SEF = (SELECT SUM(EF) from @tabela),
					   SPE = (SELECT SUM(PE) from @tabela),
					   SMC = (SELECT SUM(MC) from @tabela),
					   SMR = (SELECT SUM(MR) from @tabela)
	RETURN
END

CREATE FUNCTION fn_relatorioFaltas(@cod_disc VARCHAR(8))
RETURNS @tabela TABLE
(
	nome_aluno		VARCHAR(100),
	ra_aluno		VARCHAR(13),
	presencas1		CHAR(4),
	presencas2		CHAR(4),
	presencas3		CHAR(4),
	presencas4		CHAR(4),
	presencas5		CHAR(4),
	presencas6		CHAR(4),
	presencas7		CHAR(4),
	presencas8		CHAR(4),
	presencas9		CHAR(4),
	presencas10		CHAR(4),
	presencas11		CHAR(4),
	presencas12		CHAR(4),
	presencas13		CHAR(4),
	presencas14		CHAR(4),
	presencas15		CHAR(4),
	presencas16		CHAR(4),
	presencas17		CHAR(4),
	presencas18		CHAR(4),
	presencas19		CHAR(4),
	presencas20		CHAR(4),
	aula1			DATE,
	aula2			DATE,
	aula3			DATE,
	aula4			DATE,
	aula5			DATE,
	aula6			DATE,
	aula7			DATE,
	aula8			DATE,
	aula9			DATE,
	aula10			DATE,
	aula11			DATE,
	aula12			DATE,
	aula13			DATE,
	aula14			DATE,
	aula15			DATE,
	aula16			DATE,
	aula17			DATE,
	aula18			DATE,
	aula19			DATE,
	aula20			DATE,
	tot_faltas		INT,
	nome_disc		VARCHAR(100)
)
AS
BEGIN
	DECLARE @ra_aluno		VARCHAR(13),
			@nome_aluno		VARCHAR(100),
			@presenca		INT,
			@dia_presenca   DATE,
			@coluna			INT,
			@totFaltas		INT
	DECLARE c_alunos CURSOR FOR SELECT a.ra, a.nome FROM aluno a INNER JOIN matricula mt ON a.ra = mt.ra_aluno INNER JOIN disciplina disc ON mt.codigo_disciplina = disc.codigo WHERE disc.codigo = @cod_disc
	OPEN c_alunos
	FETCH NEXT FROM c_alunos INTO @ra_aluno, @nome_aluno
	WHILE(@@FETCH_STATUS = 0)
	BEGIN
		INSERT INTO @tabela(nome_aluno, ra_aluno) VALUES
		(@nome_aluno, @ra_aluno)
		DECLARE c_presencas CURSOR FOR SELECT presencas, dia FROM faltas ft INNER JOIN aluno a ON a.ra = ft.ra_aluno WHERE a.ra = @ra_aluno ORDER BY ft.dia
		OPEN c_presencas
		FETCH NEXT FROM c_presencas INTO @presenca, @dia_presenca
		SET @coluna = 1
			WHILE(@@FETCH_STATUS = 0)
			BEGIN
				UPDATE @tabela SET presencas1 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 1 AND presencas1 IS NULL
				UPDATE @tabela SET presencas2 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 2 AND presencas2 IS NULL
				UPDATE @tabela SET presencas3 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 3 AND presencas3 IS NULL
				UPDATE @tabela SET presencas4 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 4 AND presencas4 IS NULL
				UPDATE @tabela SET presencas5 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 5 AND presencas5 IS NULL
				UPDATE @tabela SET presencas6 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 6 AND presencas6 IS NULL
				UPDATE @tabela SET presencas7 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 7 AND presencas7 IS NULL
				UPDATE @tabela SET presencas8 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 8 AND presencas8 IS NULL
				UPDATE @tabela SET presencas9 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 9 AND presencas9 IS NULL
				UPDATE @tabela SET presencas10 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 10 AND presencas10 IS NULL
				UPDATE @tabela SET presencas11 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 11 AND presencas11 IS NULL
				UPDATE @tabela SET presencas12 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 12 AND presencas12 IS NULL
				UPDATE @tabela SET presencas13 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 13 AND presencas13 IS NULL
				UPDATE @tabela SET presencas14 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 14 AND presencas14 IS NULL
				UPDATE @tabela SET presencas15 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 15 AND presencas15 IS NULL
				UPDATE @tabela SET presencas16 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 16 AND presencas16 IS NULL
				UPDATE @tabela SET presencas17 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 17 AND presencas17 IS NULL
				UPDATE @tabela SET presencas18 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 18 AND presencas18 IS NULL
				UPDATE @tabela SET presencas19 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 19 AND presencas19 IS NULL
				UPDATE @tabela SET presencas20 = CASE WHEN @presenca = 1 THEN 'PPPF' WHEN  @presenca = 2 THEN 'PPFF' WHEN @presenca = 3 THEN 'PFFF' WHEN @presenca = 4 THEN 'FFFF' WHEN @presenca = 0 THEN 'PPPP' END WHERE ra_aluno = @ra_aluno AND @coluna = 20 AND presencas20 IS NULL
				UPDATE @tabela SET aula1 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 1 AND aula1 IS NULL
				UPDATE @tabela SET aula2 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 2 AND aula2 IS NULL
				UPDATE @tabela SET aula3 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 3 AND aula3 IS NULL
				UPDATE @tabela SET aula4 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 4 AND aula4 IS NULL
				UPDATE @tabela SET aula5 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 5 AND aula5 IS NULL
				UPDATE @tabela SET aula6 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 6 AND aula6 IS NULL
				UPDATE @tabela SET aula7 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 7 AND aula7 IS NULL
				UPDATE @tabela SET aula8 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 8 AND aula8 IS NULL
				UPDATE @tabela SET aula9 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 9 AND aula9 IS NULL
				UPDATE @tabela SET aula10 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 10 AND aula10 IS NULL
				UPDATE @tabela SET aula11 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 11 AND aula11 IS NULL
				UPDATE @tabela SET aula12 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 12 AND aula12 IS NULL
				UPDATE @tabela SET aula13 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 13 AND aula13 IS NULL
				UPDATE @tabela SET aula14 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 14 AND aula14 IS NULL
				UPDATE @tabela SET aula15 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 15 AND aula15 IS NULL
				UPDATE @tabela SET aula16 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 16 AND aula16 IS NULL
				UPDATE @tabela SET aula17 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 17 AND aula17 IS NULL
				UPDATE @tabela SET aula18 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 18 AND aula18 IS NULL
				UPDATE @tabela SET aula19 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 19 AND aula19 IS NULL
				UPDATE @tabela SET aula20 = (CONVERT(DATE, @dia_presenca, 103)) WHERE ra_aluno = @ra_aluno AND @coluna = 20 AND aula20 IS NULL
				UPDATE @tabela SET tot_faltas = 0 WHERE ra_aluno = @ra_aluno AND tot_faltas IS NULL
				UPDATE @tabela SET tot_faltas = tot_faltas + @presenca WHERE ra_aluno = @ra_aluno
				SET @coluna = @coluna + 1
				FETCH NEXT FROM c_presencas INTO @presenca, @dia_presenca
			END
		CLOSE c_presencas
		DEALLOCATE c_presencas
		FETCH NEXT FROM c_alunos INTO @ra_aluno, @nome_aluno
	END
	CLOSE c_alunos
	DEALLOCATE c_alunos
	UPDATE @tabela SET nome_disc = (SELECT nome + ' - ' + CASE WHEN turno = 'T' THEN 'TARDE' WHEN turno = 'N' THEN 'NOITE' END FROM disciplina WHERE codigo = @cod_disc)
	RETURN
END
SELECT * FROM fn_relatorioFaltas('4203-010')
SELECT * FROM faltas
--------- TESTES ------------

SELECT * from fn_Notas('4208-010') order by Nome_Aluno


