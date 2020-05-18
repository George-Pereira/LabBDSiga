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
	codigo int identity primary key,
	tipo char(2))

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
('P1'),
('P2'),
('P3')

-- ALUNOS
insert into aluno values
('1110481812042', 'Fellipe Alves Andrade'),
('1110481812043', 'Fernando George Pereira'),
('1110481812034', 'Rafael Antonio Ferreira Borges'),
('1110481812022', 'João Vitor Sardinha de Arruda'),
('1110481812012', 'José Luis dos Santos'),
('1110481812033', 'Jonathas Moreira de Amorim Lopes'),
('1110481812031', 'Leandro Colevati dos Santos')

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
/*CREATE FUNCTION fn_listaNotas(@cod_disc VARCHAR(8))
RETURNS @tabela TABLE(
ra_aluno		VARCHAR(13),
nome_aluno		VARCHAR(100),
N1		DECIMAL(4,2),
N2		DECIMAL(4,2),
N3		DECIMAL(4,2)
)
DECLARE	@*/

--------- TESTES ------------

delete aluno
select * from aluno

delete notas

