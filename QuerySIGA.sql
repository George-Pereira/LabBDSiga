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
	primary key(ra_aluno,codigo_disciplina, dia),
	foreign key (ra_aluno) references aluno(ra),
	foreign key (codigo_disciplina) references disciplina(codigo))

-- NOTA: fazer a validação se é 0 <= nota <= 10 no JAVA
create table notas (
	ra_aluno varchar(13),
	codigo_disciplina varchar(8),
	codigo_avaliacao int,
	nota decimal (4,2),
	primary key(ra_aluno, codigo_disciplina, codigo_avaliacao),
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

-- PROCEDURE PARA INSERIR NOTA COM O PESO
create procedure sp_insereNota (@ra_aluno varchar(13), @codigo_disciplina varchar(8), @codigo_avaliacao int, @nota decimal(4,2))
AS
BEGIN
	IF (@ra_aluno IS NULL OR @codigo_disciplina IS NULL OR @codigo_avaliacao IS NULL OR @nota IS NULL)
	BEGIN
		RAISERROR('Valores Inválidos!',16,1)
	END
	ELSE
	BEGIN
		INSERT INTO notas VALUES (@ra_aluno, @codigo_disciplina, @codigo_avaliacao, @nota)
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


insert into aluno values
('1110481812042', 'Fellipe Alves')

select * from notas

delete notas