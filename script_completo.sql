DROP TABLE IF EXISTS exame_solicitado_realizado CASCADE; 
DROP TABLE IF EXISTS profissional_saude_recomendado CASCADE;
DROP TABLE IF EXISTS medidas_aferidas CASCADE; 
DROP TABLE IF EXISTS exame_coberto CASCADE;
DROP TABLE IF EXISTS paciente_cuidador_especial CASCADE; 
DROP TABLE IF EXISTS paciente_cuidador CASCADE;
DROP TABLE IF EXISTS medico_conveniado CASCADE; 
DROP TABLE IF EXISTS medicamento_disponivel CASCADE;
DROP TABLE IF EXISTS interacao_medicamentosa CASCADE; 
DROP TABLE IF EXISTS atendimento_clinica_hospital CASCADE;
DROP TABLE IF EXISTS funcionario_clinica_hospital CASCADE; 
DROP TABLE IF EXISTS funcionario_laboratorio CASCADE;
DROP TABLE IF EXISTS anamnese CASCADE;
DROP TABLE IF EXISTS familiar CASCADE;
DROP TABLE IF EXISTS exame CASCADE;
DROP TABLE IF EXISTS composicao_medicamento CASCADE;
DROP TABLE IF EXISTS principio_ativo CASCADE;
DROP TABLE IF EXISTS agenda_medicamento CASCADE;
DROP TABLE IF EXISTS medicamento_receitado CASCADE;
DROP TABLE IF EXISTS consulta CASCADE;
DROP TABLE IF EXISTS nota_fiscal CASCADE;
DROP TABLE IF EXISTS paciente_conveniado CASCADE;
DROP TABLE IF EXISTS medicamento CASCADE;
DROP TABLE IF EXISTS plano_saude CASCADE;
DROP TABLE IF EXISTS operadora CASCADE;
DROP TABLE IF EXISTS laboratorio_farmacologico CASCADE; 
DROP TABLE IF EXISTS laboratorio_exame CASCADE; 
DROP TABLE IF EXISTS farmacia CASCADE; 
DROP TABLE IF EXISTS clinica_hospital CASCADE; 
DROP TABLE IF EXISTS com_instantaneo_pj CASCADE; 
DROP TABLE IF EXISTS telefone_pj CASCADE; 
DROP TABLE IF EXISTS email_pj CASCADE; 
DROP TABLE IF EXISTS farmaceutico CASCADE; 
DROP TABLE IF EXISTS medico CASCADE; 
DROP TABLE IF EXISTS cuidador_especial CASCADE; 
DROP TABLE IF EXISTS certificado_ps CASCADE; 
DROP TABLE IF EXISTS diploma_ps CASCADE; 
DROP TABLE IF EXISTS especialidade_ps CASCADE; 
DROP TABLE IF EXISTS profissional_saude CASCADE; 
DROP TABLE IF EXISTS cuidador CASCADE; 
DROP TABLE IF EXISTS laboratorista CASCADE; 
DROP TABLE IF EXISTS paciente CASCADE; 
DROP TABLE IF EXISTS com_instantaneo_pf CASCADE; 
DROP TABLE IF EXISTS email_pf CASCADE; 
DROP TABLE IF EXISTS telefone_pf CASCADE; 
DROP TABLE IF EXISTS pessoa_juridica CASCADE; 
DROP TABLE IF EXISTS pessoa_fisica;
create table pessoa_fisica
(
	cpf char(11) not null
		constraint pessoa_cpf_pk
			primary key,
	prenome varchar(30) not null,
	meionome varchar(50),
	sobrenome varchar(30) not null,
	end_logradouro varchar(20),
	end_numero integer not null,
	end_complemento varchar(30),
	end_bairro varchar(20) not null,
	end_cidade varchar(20) not null,
	end_cep char(8) not null,
	end_estado char(2),
	end_pais varchar(20) not null,
	data_nascimento date
)
;

create table pessoa_juridica
(
	cnpj char(14) not null
		constraint pessoa_juridica_cnpj_pk
			primary key,
	registro_profissional varchar(20),
	razao_social varchar(30) not null,
	nome_fantasia varchar(30) not null,
	end_logradouro varchar(20) not null,
	end_numero integer not null,
	end_complemento varchar(30),
	end_bairro varchar(20) not null,
	end_cidade varchar(20) not null,
	end_cep char(8) not null,
	end_estado char(2) not null,
	end_pais varchar(20) not null,
	website varchar(50)
)
;

create table telefone_pf
(
	cpf char(11) not null
		constraint telefone_pf_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade,
	ddi varchar(4) default '+55'::character varying not null,
	ddd varchar(3) not null,
	numero varchar(10) not null,
	tipo varchar(10) not null,
	constraint telefone_pf_cpf_ddi_ddd_numero_tipo_pk
		primary key (cpf, ddi, ddd, numero, tipo)
)
;

create table email_pf
(
	cpf char(11) not null
		constraint email_pf_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade,
	email varchar(30) not null,
	constraint email_pf_cpf_email_pk
		primary key (cpf, email)
)
;

create table com_instantaneo_pf
(
	cpf char(11) not null
		constraint com_instantaneo_pf_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade,
	tipo varchar(20) not null,
	usuario varchar(20) not null,
	constraint com_instantaneo_pf_cpf_tipo_usuario_pk
		primary key (cpf, tipo, usuario)
)
;

create table paciente
(
	cpf char(11) not null
		constraint paciente_pkey1
			primary key
		constraint paciente_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade
)
;

create table laboratorista
(
	cpf char(11) not null
		constraint laboratorista_pkey
			primary key
		constraint laboratorista_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade
)
;

create table cuidador
(
	cpf char(11) not null
		constraint cuidador_pkey
			primary key
		constraint cuidador_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade
)
;

create table profissional_saude
(
	cpf char(11) not null
		constraint profissional_saude_pkey
			primary key
		constraint profissional_saude_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade,
	cod_inscricao_profissional varchar(10)
)
;

create table especialidade_ps
(
	cpf char(11) not null
		constraint especialidade_ps_profissional_saude_cpf_fk
			references profissional_saude on delete cascade,
	especialidade varchar(20) not null,
	constraint especialidade_ps_cpf_especialidade_pk
		primary key (cpf, especialidade)
)
;

create table diploma_ps
(
	cpf char(11) not null
		constraint diploma_ps_profissional_saude_cpf_fk
			references profissional_saude on delete cascade,
	diploma bytea not null,
	constraint diploma_ps_cpf_diploma_pk
		primary key (cpf, diploma)
)
;

create table certificado_ps
(
	cpf char(11) not null
		constraint certificado_ps_profissional_saude_cpf_fk
			references profissional_saude on delete cascade,
	certificado bytea not null,
	constraint certificado_ps_cpf_certificado_pk
		primary key (cpf, certificado)
)
;

create table cuidador_especial
(
	cpf char(11) not null
		constraint cuidador_especial_pkey
			primary key
		constraint cuidador_especial_profissional_saude_cpf_fk
			references profissional_saude on delete cascade
)
;

create table medico
(
	cpf char(11) not null
		constraint medico_pkey
			primary key
		constraint medico_profissional_saude_cpf_fk
			references profissional_saude on delete cascade
)
;

create table farmaceutico
(
	cpf char(11) not null
		constraint farmaceutico_pkey
			primary key
		constraint farmaceutico_profissional_saude_cpf_fk
			references profissional_saude on delete cascade
)
;

create table email_pj
(
	cnpj char(14) not null
		constraint email_pj_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade,
	email varchar(30) not null,
	constraint email_pj_cnpj_email_pk
		primary key (cnpj, email)
)
;

create table telefone_pj
(
	cnpj char(14) not null
		constraint telefone_pj_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade,
	ddi varchar(4) not null,
	ddd varchar(3) not null,
	tipo varchar(10) not null,
	numero varchar(10) not null,
	constraint telefone_pj_cnpj_ddi_ddd_tipo_numero_pk
		primary key (cnpj, ddi, ddd, tipo, numero)
)
;

create table com_instantaneo_pj
(
	cnpj char(14) not null
		constraint com_instantaneo_pj_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade,
	tipo varchar(20) not null,
	usuario varchar(20) not null,
	constraint com_instantaneo_pj_cnpj_tipo_usuario_pk
		primary key (cnpj, tipo, usuario)
)
;

create table clinica_hospital
(
	cnpj char(14) not null
		constraint clinica_hospital_pkey
			primary key
		constraint clinica_hospital_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade
)
;

create table farmacia
(
	cnpj char(14) not null
		constraint farmacia_pkey
			primary key
		constraint farmacia_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade,
	cpf char(11) not null
		constraint farmacia_farmaceutico_cpf_fk
			references farmaceutico on delete restrict
)
;

create table laboratorio_exame
(
	cnpj char(14) not null
		constraint laboratorio_exame_pkey
			primary key
		constraint laboratorio_exame_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade
)
;

create table laboratorio_farmacologico
(
	cnpj char(14) not null
		constraint laboratorio_farmacologico_pkey
			primary key
		constraint laboratorio_farmacologico_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade
)
;

create table operadora
(
	cnpj char(14) not null
		constraint operadora_pkey
			primary key
		constraint operadora_pessoa_juridica_cnpj_fk
			references pessoa_juridica on delete cascade
)
;

create table plano_saude
(
	cnpj char(14) not null
		constraint plano_saude_operadora_cnpj_fk
			references operadora on delete cascade,
	tipo_plano varchar(20) not null,
	abrangencia varchar(20),
	acomodacao varchar(20),
	servicos varchar(50),
	carencia integer,
	data_ultimo_reajuste date,
	valor real not null,
	constraint plano_saude_cnpj_tipo_plano_pk
		primary key (cnpj, tipo_plano)
)
;

create table medicamento
(
	id integer not null
		constraint medicamento2_pkey
			primary key,
	nome_comercial varchar(30),
	forma varchar(30),
	contra_indicacao varchar(50),
	cnpj char(14) not null
		constraint medicamento_laboratorio_farmacologico_cnpj_fk
			references laboratorio_farmacologico on delete restrict
)
;

create table paciente_conveniado
(
	cpf char(11) not null
		constraint paciente_conveniado_paciente_cpf_fk
			references paciente on delete cascade,
	cnpj char(14) not null,
	tipo_plano varchar(20) not null,
	numero_conveniado varchar(30),
	data_contratacao date,
	termino_carencia date,
	valor_contratacao real,
	id serial not null
		constraint paciente_conveniado_id_pk
			primary key,
	constraint paciente_conveniado_plano_saude_cnpj_tipo_plano_fk
		foreign key (cnpj, tipo_plano) references plano_saude on delete restrict
)
;

create table nota_fiscal
(
	cod varchar(40) not null
		constraint nota_fiscal_pkey
			primary key,
	data_emissao date not null,
	hora_emissao time not null,
	valor_total real not null
)
;

create table consulta
(
	cpf_paciente char(11) not null
		constraint consulta_paciente_cpf_fk
			references paciente on delete restrict,
	cpf_medico char(11) not null
		constraint consulta_medico_cpf_fk
			references medico on delete restrict,
	cnpj_hospital char(14) not null
		constraint consulta_clinica_hospital_cnpj_fk
			references clinica_hospital on delete restrict,
	data_hora timestamp not null,
	tipo varchar(1), -- P para particular e C para convenio
	valor real,
	recibo bytea,
	cod_nota_fiscal varchar(40)
		constraint consulta_nota_fiscal_cod_fk
			references nota_fiscal on delete cascade,
	id serial not null
		constraint consulta_id_pk
			primary key,
	id_paciente_conveniado integer
		constraint consulta_paciente_conveniado_id_fk
			references paciente_conveniado
)
;

create table medicamento_receitado
(
	id_consulta integer not null
		constraint medicamento_receitado_consulta_id_fk
			references consulta on delete cascade,
	id_medicamento integer not null
		constraint medicamento_receitado_medicamento_id_fk
			references medicamento on delete cascade,
	cnpj_farmacia char(14)
		constraint medicamento_receitado_farmacia_cnpj_fk
			references farmacia,
	periodo varchar(20) not null,
	dosagem varchar(20) not null,
	constraint medicamento_receitado_id_consulta_id_medicamento_pk
		primary key (id_consulta, id_medicamento)
)
;

create table agenda_medicamento
(
	id_consulta integer not null,
	id_medicamento integer not null,
	horario time not null,
	posologia varchar(20) not null,
	seg boolean,
	ter boolean,
	qua boolean,
	qui boolean,
	sex boolean,
	sab boolean,
	dom boolean,
	constraint agenda_medicamento_id_consulta_id_medicamento_horario_pk
		primary key (id_consulta, id_medicamento, horario),
	constraint agenda_medicamento_medicamento_receitado_id_consulta_id_medicam
		foreign key (id_consulta, id_medicamento) references medicamento_receitado
)
;

create table principio_ativo
(
	id integer not null
		constraint principio_ativo2_pkey
			primary key,
	nome varchar(20),
	concentracao real not null,
	unidade varchar(10) not null
)
;

create table composicao_medicamento
(
	id_medicamento integer not null
		constraint composicao_medicamento_medicamento_id_fk
			references medicamento on delete cascade,
	id_principio_ativo integer not null
		constraint composicao_medicamento_principio_ativo_id_fk
			references principio_ativo on delete cascade,
	constraint composicao_medicamento_id_medicamento_id_principio_ativo_pk
		primary key (id_medicamento, id_principio_ativo)
)
;

create table exame
(
	id serial not null
		constraint exame_pkey
			primary key,
	nome varchar(20)
)
;

create table familiar
(
	cpf_paciente char(11) not null
		constraint familiar_paciente_cpf_fk
			references paciente on delete cascade,
	cpf_pessoa_fisica char(11) not null
		constraint familiar_pessoa_fisica_cpf_fk
			references pessoa_fisica on delete cascade,
	autorizacao boolean,
	cosanguineo boolean,
	grau_parentesco varchar(20),
	constraint familiar_cpf_paciente_cpf_pessoa_fisica_pk
		primary key (cpf_paciente, cpf_pessoa_fisica)
)
;

create table anamnese
(
	cpf_paciente char(11) not null
		constraint anamnese_paciente_cpf_fk
			references paciente on delete cascade,
	data_hora timestamp not null,
	pergunta varchar(300),
	resposta varchar(300),
	constraint anamnese_cpf_paciente_data_hora_pk
		primary key (cpf_paciente, data_hora)
)
;

create table funcionario_laboratorio
(
	cpf_laboratorista char(11) not null
		constraint funcionario_laboratorio_laboratorista_cpf_fk
			references laboratorista on delete cascade,
	cnpj_laboratorio_exame char(14) not null
		constraint funcionario_laboratorio_laboratorio_exame_cnpj_fk
			references laboratorio_exame on delete cascade,
	constraint funcionario_laboratorio_cpf_laboratorista_cnpj_laboratorio_exam
		primary key (cpf_laboratorista, cnpj_laboratorio_exame)
)
;

create table funcionario_clinica_hospital
(
	cpf_profissional_saude char(11) not null
		constraint funcionario_clinica_hospital_profissional_saude_cpf_fk
			references profissional_saude on delete cascade,
	cnpj_clinica_hospital char(14) not null
		constraint funcionario_clinica_hospital_clinica_hospital_cnpj_fk
			references clinica_hospital on delete cascade,
	constraint funcionario_clinica_hospital_cpf_profissional_saude_cnpj_clinic
		primary key (cpf_profissional_saude, cnpj_clinica_hospital)
)
;

create table atendimento_clinica_hospital
(
	cpf_profissional_saude char(11) not null
		constraint atendimento_clinica_hospital_profissional_saude_cpf_fk
			references profissional_saude on delete restrict,
	cnpj_clinica_hospital char(14) not null
		constraint atendimento_clinica_hospital_clinica_hospital_cnpj_fk
			references clinica_hospital on delete cascade,
	data_hora_inicio timestamp not null,
	data_hota_fim timestamp not null,
	setor varchar(20) not null,
	constraint atendimento_clinica_hospital_cpf_profissional_saude_cnpj_clinic
		primary key (cpf_profissional_saude, cnpj_clinica_hospital, data_hora_inicio, data_hota_fim, setor)
)
;

create table interacao_medicamentosa
(
	id_medicamento_1 integer not null
		constraint interacao_medicamentosa_medicamento_id_fk_1
			references medicamento on delete cascade,
	id_medicamento_2 integer not null
		constraint interacao_medicamentosa_medicamento_id_fk_2
			references medicamento on delete cascade,
	efeito varchar(100),
	constraint interacao_medicamentosa_id_medicamento_1_id_medicamento_2_pk
		primary key (id_medicamento_1, id_medicamento_2)
)
;

create table medicamento_disponivel
(
	id_medicamento integer not null
		constraint medicamento_disponivel_medicamento_id_fk
			references medicamento on delete cascade,
	cnpj_farmacia char(14) not null
		constraint medicamento_disponivel_farmacia_cnpj_fk
			references farmacia on delete cascade,
	estoque integer,
	constraint medicamento_disponivel_id_medicamento_cnpj_farmacia_pk
		primary key (id_medicamento, cnpj_farmacia)
)
;

create table medico_conveniado
(
	cpf_medico char(11) not null
		constraint medico_conveniado_medico_cpf_fk
			references medico on delete cascade,
	cnpj_operadora char(14) not null
		constraint medico_conveniado_operadora_cnpj_fk
			references operadora on delete cascade,
	data_adesao date,
	constraint medico_conveniado_cpf_medico_cnpj_operadora_pk
		primary key (cpf_medico, cnpj_operadora)
)
;

create table paciente_cuidador
(
	cpf_paciente char(11) not null
		constraint paciente_cuidador_paciente_cpf_fk
			references paciente on delete cascade,
	cpf_cuidador char(11) not null
		constraint paciente_cuidador_cuidador_cpf_fk
			references cuidador on delete cascade,
	periodicidade varchar(20) not null,
	data_inicio date,
	data_fim date,
	constraint paciente_cuidador_cpf_paciente_cpf_cuidador_pk
		primary key (cpf_paciente, cpf_cuidador)
)
;

create table paciente_cuidador_especial
(
	cpf_paciente char(11) not null
		constraint paciente_cuidador_especial_paciente_cpf_fk
			references paciente on delete cascade,
	cpf_cuidador_especial char(11) not null
		constraint paciente_cuidador_especial_cuidador_especial_cpf_fk
			references cuidador_especial on delete cascade,
	periodicidade varchar(20) not null,
	data_inicio date,
	data_fim date,
	constraint paciente_cuidador_especial_cpf_paciente_cpf_cuidador_especial
		primary key (cpf_paciente, cpf_cuidador_especial)
)
;

create table exame_coberto
(
	cnpj_plano_saude char(14) not null,
	tipo_plano_plano_saude varchar(20) not null,
	id_exame integer not null
		constraint exame_coberto_exame_id_fk
			references exame on delete cascade,
	constraint exame_coberto_cnpj_plano_saude_tipo_plano_plano_saude_id_exame_
		primary key (cnpj_plano_saude, tipo_plano_plano_saude, id_exame),
	constraint exame_coberto_plano_saude_cnpj_tipo_plano_fk
		foreign key (cnpj_plano_saude, tipo_plano_plano_saude) references plano_saude on delete cascade
)
;

create table medidas_aferidas
(
	id_consulta integer not null
		constraint medidas_aferidas_consulta_id_fk
			references consulta on delete cascade,
	data_hora timestamp not null,
	instrumento varchar(20),
	tipo varchar(20),
	medicao varchar(20),
	constraint medidas_aferidas_id_consulta_data_hora_pk
		primary key (id_consulta, data_hora)
)
;

create table profissional_saude_recomendado
(
	id_consulta integer not null
		constraint profissional_saude_recomendado_consulta_id_fk
			references consulta on delete cascade,
	cpf_profissional_saude char(11) not null
		constraint profissional_saude_recomendado_profissional_saude_cpf_fk
			references profissional_saude on delete cascade,
	recomendacao varchar(50),
	constraint profissional_saude_recomendado_id_consulta_cpf_profissional_saude
		primary key (id_consulta, cpf_profissional_saude)
)
;

create table exame_solicitado_realizado
(
	id_consulta integer not null
		constraint exame_solicitado_realizado_consulta_id_fk
			references consulta on delete cascade,
	id_exame integer not null
		constraint exame_solicitado_realizado_exame_id_fk
			references exame on delete cascade ,
	cnpj_laboratorio_exame char(14)
		constraint exame_solicitado_realizado_laboratorio_exame_cnpj_fk
			references laboratorio_exame on delete cascade,
	cpf_laboratorista char(11)
		constraint exame_solicitado_realizado_laboratorista_cpf_fk
			references laboratorista on delete cascade,
	realizado_na_consulta boolean,
	id_paciente_conveniado integer
		constraint exame_solicitado_realizado_paciente_conveniado_id_fk
			references paciente_conveniado on delete cascade,
	percentual_cobertura real,
	laudo varchar(300) not null,
	valor real,
	recibo bytea,
	data_hora_agendamento timestamp,
	cod_nota_fiscal varchar(40)
		constraint exame_solicitado_realizado_nota_fiscal_cod_fk
			references nota_fiscal on delete cascade,
	constraint exame_solicitado_realizado_id_consulta_id_exame_pk
		primary key (id_consulta, id_exame)
)
;

INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('66788827850', 'Tulio', 'Dias', 'Silva', 'Rua Brasil', 300, 'Ap 17', 'Centro', 'Sao Paulo', '01311-33', 'SP', 'Brasil', '1960-08-17');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('88655726970', 'Maria', 'Mercedes', 'Silva', 'Rua Brasil', 300, 'Ap 17', 'Centro', 'Sao Paulo', '01311-33', 'SP', 'Brasil', '1965-02-20');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('95482399900', 'Amanda', 'Dias', 'Silva', 'Rua Brasil', 300, 'Ap 17', 'Centro', 'Sao Paulo', '01311-33', 'SP', 'Brasil', '1990-11-27');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('80070022266', 'Marcos', 'Nogueira', 'Prado', 'Rua Candido Portinar', 1450, 'Ap 04', 'Jardim Estrela', 'Sao Paulo', '01322-22', 'SP', 'Brasil', '1985-04-03');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('12345678910', 'Isabella', 'Pereira', 'Souza', 'Rua Dinamarca', 701, 'Casa 7', 'Residencial Oliveira', 'Sao Paulo', '11222-11', 'SP', 'Brasil', '1999-07-17');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('11111111111', 'David', 'Jose', 'Cortez', 'Av Vargas', 1010, 'Ap 13', 'Europa', 'São Paulo', '22333-10', 'SP', 'Brasil', '1998-01-01');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('22222222222', 'Pedro', 'Furtado', 'Medeiros', 'Rua Maria Madalena', 100, 'Ap 10', 'Nova Esperança', 'São Paulo', '444888-1', 'SP', 'Brasil', '1950-01-01');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('21212121212', 'Joana', 'Nascimento', 'Medeiros', 'Rua Maria Madalena', 100, 'Ap 10', 'Nova Esperança', 'São Paulo', '444888-1', 'SP', 'Brasil', '1950-02-02');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('32323232323', 'Bianca', 'Nascimento', 'Medeiros', 'Rua Tiradentes', 201, '', 'Centro', 'São Paulo', '444999-1', 'SP', 'Brasil', '1980-03-03');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('33333333333', 'Marcela', 'Nascimento', 'Medeiros', 'Rua Holanda', 987, '', 'Centro', 'São Paulo', '444990-1', 'SP', 'Brasil', '1982-04-04');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('44444444444', 'Cesar', 'Jose', 'Caetano', 'Rua da Cunha', 111, 'Casa 11', 'Estrela Vermelha', 'São Paulo', '114990-1', 'SP', 'Brasil', '1984-05-04');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('66666666666', 'Emerson', 'Felipe', 'Medeiros', 'Av Central', 222, 'Ap 38', 'x', 'São Paulo', '224990-1', 'SP', 'Brasil', '1992-10-10');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('88888888888', 'Augusto', 'Cesar', 'Sato', 'Av Disney', 333, 'Casa 03', 'Centro', 'São Paulo', '334990-1', 'SP', 'Brasil', '1995-11-11');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('11111111110', 'Emily', 'Boreti', 'Naroshi', 'Rua Italia', 444, 'Ap 1', 'Dona Eugenia', 'São Paulo', '554990-1', 'SP', 'Brasil', '1963-02-04');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('13333333332', 'Marcia', 'Sales', 'Venancio', 'Rua da Saudade', 555, '', 'Parque Fehr', 'São Paulo', '664990-1', 'SP', 'Brasil', '1995-12-23');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('23333333332', 'Amélia', 'Ferreira', 'Jacinto', 'Rua Helena Vieira', 700, '33F', 'Jardim das Palmeiras', 'São Paulo', '665550-1', 'SP', 'Brasil', '1980-09-20');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('11100011122', 'Joaquim', 'Viriato', 'Afonso', 'Rua Oscar Freire', 10, '4B', 'Jardim Sao Luis', 'São Paulo', '12345-00', 'SP', 'Brasil', '1980-04-01');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('22200011122', 'Taissa', 'Mauricio', 'Valerio', 'Rua do Ouvidor', 20, '5B', 'Vila Marina', 'São Paulo', '12345-00', 'SP', 'Brasil', '1981-07-02');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('33300011122', 'Leonardo', 'Maura', 'Salazar', 'Rua Padre João Manue', 30, 'Casa 03', 'Liberdade', 'São Paulo', '12345-00', 'SP', 'Brasil', '1982-05-04');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('44400011122', 'Aline', 'Constanca', 'Custodio', 'Rua Paulistânia', 40, 'Ap 04', 'Jardim São João Bati', 'São Paulo', '12345-00', 'SP', 'Brasil', '1983-06-06');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('55500011122', 'Helena', 'Fernanda', 'Martinho', 'Rua Pedro Doll', 50, 'Ap 22', 'Parque Belvedere', 'São Paulo', '12345-00', 'SP', 'Brasil', '1984-02-08');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('66600011122', 'Adriano', 'Flora', 'Rebocho', 'Rua Pedroso Alvareng', 60, '', 'Vila São Gabriel', 'São Paulo', '12345-00', 'SP', 'Brasil', '1985-12-09');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('77700011122', 'Lina', 'Leonor', 'Andrada', 'Rua Peixoto Gomide', 70, '', 'Moema', 'São Paulo', '12345-00', 'SP', 'Brasil', '1986-02-11');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('88811111122', 'Juliano', 'Tatiana', 'Colaco', 'Ladeira Porto Geral', 80, 'Fundo', 'Morumbi', 'São Paulo', '12345-00', 'SP', 'Brasil', '1987-02-13');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('99922211122', 'Neuza', 'Iara', 'Chamusa', 'Rua Michel Milan', 90, '', 'Vila Caetano', 'São Paulo', '12345-00', 'SP', 'Brasil', '1988-11-15');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('11103331112', 'Candido', 'Judite', 'Fagundes', 'Rua Palestra Itália', 100, 'Ap 10', 'Vila Max', 'São Paulo', '12345-01', 'SP', 'Brasil', '1989-01-16');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('12214441112', 'Eusebio', 'Adriano', 'Bandeira', 'Rua Santa Ifigênia', 110, 'Ap 11', 'Vila Laura', 'São Paulo', '12345-01', 'SP', 'Brasil', '1990-03-18');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('13325551112', 'Ema', 'Luiza', 'Viveiros', 'Rua Tuiuti', 120, 'Ap 22', 'Kartódromo', 'São Paulo', '12345-01', 'SP', 'Brasil', '1991-02-20');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('14436661112', 'Greice', 'Rosalina', 'Morais', 'Rua Turiaçu', 130, 'Ap 23', 'Jardim Paulistano', 'São Paulo', '12345-01', 'SP', 'Brasil', '1992-06-22');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('15547771112', 'Celina', 'Leira', 'Girao', 'Rua Teodoro Sampaio', 140, 'Ap 04', 'Santa Cecilia', 'São Paulo', '12345-01', 'SP', 'Brasil', '1993-08-23');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('16658881112', 'Sandra', 'Basilio', 'Carneiro', 'Rua São Bento', 150, '', 'Vila Jacobucci', 'São Paulo', '12345-01', 'SP', 'Brasil', '1994-02-25');
INSERT INTO public.pessoa_fisica (cpf, prenome, meionome, sobrenome, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, data_nascimento) VALUES ('17769991112', 'Alda', 'Amaro', 'Assis', 'Rua Estados Unidos', 160, '', 'Vila São José', 'São Paulo', '12345-01', 'SP', 'Brasil', '1995-10-27');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('44444444444', '10101010');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('66666666666', '20202020');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('88888888888', '30303030');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('11111111110', '40404040');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('13333333332', '50505050');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('23333333332', '60606060');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('11100011122', '70707070');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('22200011122', '80808080');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('33300011122', '90909090');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('44400011122', '90909001');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('55500011122', '90909002');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('66600011122', '90909003');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('77700011122', '90909004');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('88811111122', '90909005');
INSERT INTO public.profissional_saude (cpf, cod_inscricao_profissional) VALUES ('99922211122', '90909006');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('44444444444', 'Massagista');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('66666666666', 'Fisioterapeuta');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('88888888888', 'Cardiologista');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('11111111110', 'Ortopedista');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('13333333332', 'Ginecologista');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('23333333332', 'Homeopatia');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('11100011122', 'Antibióticos');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('22200011122', 'Manipulacao');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('33300011122', 'Manipulacao');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('44400011122', 'Homeopatia');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('55500011122', 'Endocrinologista');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('66600011122', 'Otorrinolaringologis');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('77700011122', 'Nutricionista');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('88811111122', 'Psicologo');
INSERT INTO public.especialidade_ps (cpf, especialidade) VALUES ('99922211122', 'Terapeuta Ocupaciona');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('44444444444', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('66666666666', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('88888888888', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('11111111110', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('13333333332', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('23333333332', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('11100011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('22200011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('33300011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('44400011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('55500011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('66600011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('77700011122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('88811111122', '3e');
INSERT INTO public.diploma_ps (cpf, diploma) VALUES ('99922211122', '3e');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('44444444444', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('66666666666', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('88888888888', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('11111111110', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('13333333332', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('23333333332', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('11100011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('22200011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('33300011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('44400011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('55500011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('66600011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('77700011122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('88811111122', '2f');
INSERT INTO public.certificado_ps (cpf, certificado) VALUES ('99922211122', '2f');
INSERT INTO public.cuidador_especial (cpf) VALUES ('44444444444');
INSERT INTO public.cuidador_especial (cpf) VALUES ('66666666666');
INSERT INTO public.cuidador_especial (cpf) VALUES ('77700011122');
INSERT INTO public.cuidador_especial (cpf) VALUES ('88811111122');
INSERT INTO public.cuidador_especial (cpf) VALUES ('99922211122');
INSERT INTO public.medico (cpf) VALUES ('88888888888');
INSERT INTO public.medico (cpf) VALUES ('11111111110');
INSERT INTO public.medico (cpf) VALUES ('13333333332');
INSERT INTO public.medico (cpf) VALUES ('55500011122');
INSERT INTO public.medico (cpf) VALUES ('66600011122');
INSERT INTO public.farmaceutico (cpf) VALUES ('23333333332');
INSERT INTO public.farmaceutico (cpf) VALUES ('11100011122');
INSERT INTO public.farmaceutico (cpf) VALUES ('22200011122');
INSERT INTO public.farmaceutico (cpf) VALUES ('33300011122');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802010', '501', 'Hospital Albert Einstein', 'Hospital Albert Einstein', 'Av Albert Einstein', 1090, '', 'Morumbi', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'hospitalalberteinstein.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802011', '510', 'Hospital Bandeirantes', 'Hospital Bandeirantes', 'Rua Diogo Cabrera', 1130, '', 'Imirin', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'hospitalbandeirantes.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802012', '519', 'Hospital Central', 'Hospital Central', 'Rua Brigadeiro Gavia', 1170, '', 'Sao Jose', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'hospitalcentral.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802013', '528', 'Hospital Cruz Azul', 'Hospital Cruz Azul', 'Av Gabriel Resende', 1210, '', 'Centro', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'hospitalcruzazul.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802014', '537', 'Hospital  Assuncao', 'Hospital  Assuncao', 'Rua Padre Adelino', 1250, '', 'Liberdade', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'hospitalassuncao.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802015', '546', 'Farmacia Jardins', 'Farmacia Jardins', 'Rua do Oratorio', 1290, 'Loja 4', 'Guarulhos', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'farmaciajardins.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802016', '555', 'Farmacia Leforte', 'Farmacia Leforte', 'Rua Barao de Iguape', 1330, 'Loja 3', 'Mooca', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'farmacialeforte.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802017', '564', 'Farmacia Montreal', 'Farmacia Montreal', 'Rua Manoel Coelho', 1370, '', 'Vila Marina', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'farmaciamontreal.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802018', '573', 'Farmacia Paulista', 'Farmacia Paulista', 'Rua Cabo Jose Teixei', 1410, 'Loja 2', 'Vila Celina', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'farmaciapaulista.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802019', '582', 'Farmacia Portinari', 'Farmacia Portinari', 'Av. Lins', 1450, '', 'Santo Amaro', 'Sao Paulo', '10850001', 'SP', 'Brasil', 'farmaciaportinari.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802020', '591', 'Laboratorio Pedro I', 'Laboratorio Pedro I', 'v. Dr. Dante', 1490, 'Loja 21', 'Lapa', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'laboratoriopedroi.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802021', '600', 'Laboratorio Alves', 'Laboratorio Alves', 'Rua Dona Antonia', 1530, 'Loja 12', 'Centro', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'laboratorioalves.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802022', '609', 'Laboratorio Vidas', 'Laboratorio Vidas', 'Rua Tres Irmaos', 1570, '', 'Liberdade', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'laboratoriovidas.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802023', '618', 'Laboratorio Stella', 'Laboratorio Stella', 'Rua Conselheiro', 1610, '', 'Itaquera', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'laboratoriostella.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802024', '627', 'Laboratorio Brasil', 'Laboratorio Brasil', 'Rua Padre Damaso', 1650, '', 'Belem', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'laboratoriobrasil.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802025', '636', 'Farmacologico Uniao', 'Farmacologico Uniao', 'Parque Novo Mundo', 1690, '', 'Brooklin Paulista', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'farmacologicouniao.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802026', '645', 'Farmacologico Estrela', 'Farmacologico Estrela', 'Rua Nossa Senhora', 1730, '', 'Centro', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'farmacologicoestrela.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802027', '654', 'Farmacologico Luz', 'Farmacologico Luz', 'Rua Peixoto', 1770, '', 'Morumbi', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'farmacologicoluz.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802028', '663', 'Farmacologico Jose', 'Farmacologico Jose', 'Rua Santa Cruz', 1810, '', 'Liberdade', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'farmacologicojose.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802029', '672', 'Farmacologico Texas', 'Farmacologico Texas', 'Rua Bresser', 1850, '', 'Estacao Norte', 'Sao Paulo', '10850002', 'SP', 'Brasil', 'farmacologicotexas.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802030', '681', 'Unimed', 'Unimed', 'Avenida Santa Catari', 1890, '', 'Centro', 'Sao Paulo', '10850003', 'SP', 'Brasil', 'unimed.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802031', '690', 'Ampara', 'Ampara', 'Av Santo Amaro', 1930, '', 'Vila Mariana', 'Sao Paulo', '10850003', 'SP', 'Brasil', 'ampara.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802032', '699', 'Viver Bem', 'Viver Bem', 'Rua Marechal Rondon', 1970, '', 'Vila Japonesa', 'Sao Paulo', '10850003', 'SP', 'Brasil', 'viverbem.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802033', '708', 'Med Service', 'Med Service', 'Rua Adolfo Jose', 2010, '', 'Centro', 'Sao Paulo', '10850003', 'SP', 'Brasil', 'medservice.com');
INSERT INTO public.pessoa_juridica (cnpj, registro_profissional, razao_social, nome_fantasia, end_logradouro, end_numero, end_complemento, end_bairro, end_cidade, end_cep, end_estado, end_pais, website) VALUES ('72100888802034', '717', 'Vitallis', 'Vitallis', 'Av Central', 2050, '', 'Centro', 'Sao Paulo', '10850003', 'SP', 'Brasil', 'vitallis.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802010', 'hospitalalberteinstein@gmail');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802011', 'hospitalbandeirantes@gmail.co');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802012', 'hospitalcentral@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802013', 'hospitalcruzazul@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802014', 'hospitalassuncao@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802015', 'farmaciajardins@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802016', 'farmacialeforte@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802017', 'farmaciamontreal@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802018', 'farmaciapaulista@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802019', 'farmaciaportinari@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802020', 'laboratoriopedro i@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802021', 'laboratorioalves@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802022', 'laboratoriovidas@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802023', 'laboratoriostella@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802024', 'laboratoriobrasil@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802025', 'farmacologicouniao@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802026', 'farmacologicoestrela@gmail.co');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802027', 'farmacologicoluz@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802028', 'farmacologicojose@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802029', 'farmacologicotexas@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802030', 'unimed@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802031', 'ampara@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802032', 'viverbem@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802033', 'medservice@gmail.com');
INSERT INTO public.email_pj (cnpj, email) VALUES ('72100888802034', 'vitallis@gmail.com');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802010', '55', '11', 'Fixo', '12115061');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802011', '55', '11', 'Fixo', '12115062');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802012', '55', '11', 'Fixo', '12115063');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802013', '55', '11', 'Fixo', '12115064');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802014', '55', '11', 'Fixo', '12115065');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802015', '55', '11', 'Fixo', '12115066');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802016', '55', '11', 'Fixo', '12115067');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802017', '55', '11', 'Fixo', '12115068');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802018', '55', '11', 'Fixo', '12115069');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802019', '55', '11', 'Fixo', '12115070');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802020', '55', '11', 'Fixo', '12115071');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802021', '55', '11', 'Fixo', '12115072');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802022', '55', '11', 'Fixo', '12115073');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802023', '55', '11', 'Fixo', '12115074');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802024', '55', '11', 'Fixo', '12115075');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802025', '55', '11', 'Fixo', '12115076');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802026', '55', '11', 'Fixo', '12115077');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802027', '55', '11', 'Fixo', '12115078');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802028', '55', '11', 'Fixo', '12115079');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802029', '55', '11', 'Fixo', '12115080');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802030', '55', '11', 'Fixo', '12115081');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802031', '55', '11', 'Fixo', '12115082');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802032', '55', '11', 'Fixo', '12115083');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802033', '55', '11', 'Fixo', '12115084');
INSERT INTO public.telefone_pj (cnpj, ddi, ddd, tipo, numero) VALUES ('72100888802034', '55', '11', 'Fixo', '12115085');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802010', 'Facebook', 'hospitalalberteins');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802011', 'Facebook', 'hospitalbandeirante');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802012', 'Instagram', 'hospitalcentral');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802013', 'Facebook', 'hospitalcruzazul');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802014', 'Facebook', 'hospitalassuncao');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802015', 'Facebook', 'farmaciajardins');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802016', 'Instagram', 'farmacialeforte');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802017', 'Facebook', 'farmaciamontreal');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802018', 'Facebook', 'farmaciapaulista');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802019', 'Facebook', 'farmaciaportinari');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802020', 'Instagram', 'laboratoriopedroi');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802021', 'Facebook', 'laboratorioalves');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802022', 'Facebook', 'laboratoriovidas');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802023', 'Facebook', 'laboratoriostella');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802024', 'Instagram', 'laboratoriobrasil');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802025', 'Facebook', 'farmacologicouniao');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802026', 'Facebook', 'farmacologicoestrel');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802027', 'Facebook', 'farmacologicoluz');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802028', 'Instagram', 'farmacologicojose');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802029', 'Facebook', 'farmacologicotexas');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802030', 'Facebook', 'unimed');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802031', 'Facebook', 'ampara');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802032', 'Instagram', 'viverbem');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802033', 'Facebook', 'medservice');
INSERT INTO public.com_instantaneo_pj (cnpj, tipo, usuario) VALUES ('72100888802034', 'Facebook', 'vitallis');
INSERT INTO public.clinica_hospital (cnpj) VALUES ('72100888802010');
INSERT INTO public.clinica_hospital (cnpj) VALUES ('72100888802011');
INSERT INTO public.clinica_hospital (cnpj) VALUES ('72100888802012');
INSERT INTO public.clinica_hospital (cnpj) VALUES ('72100888802013');
INSERT INTO public.clinica_hospital (cnpj) VALUES ('72100888802014');
INSERT INTO public.farmacia (cnpj, cpf) VALUES ('72100888802015', '23333333332');
INSERT INTO public.farmacia (cnpj, cpf) VALUES ('72100888802016', '23333333332');
INSERT INTO public.farmacia (cnpj, cpf) VALUES ('72100888802017', '11100011122');
INSERT INTO public.farmacia (cnpj, cpf) VALUES ('72100888802018', '22200011122');
INSERT INTO public.farmacia (cnpj, cpf) VALUES ('72100888802019', '33300011122');
INSERT INTO public.laboratorio_exame (cnpj) VALUES ('72100888802020');
INSERT INTO public.laboratorio_exame (cnpj) VALUES ('72100888802021');
INSERT INTO public.laboratorio_exame (cnpj) VALUES ('72100888802022');
INSERT INTO public.laboratorio_exame (cnpj) VALUES ('72100888802023');
INSERT INTO public.laboratorio_exame (cnpj) VALUES ('72100888802024');
INSERT INTO public.laboratorio_farmacologico (cnpj) VALUES ('72100888802025');
INSERT INTO public.laboratorio_farmacologico (cnpj) VALUES ('72100888802026');
INSERT INTO public.laboratorio_farmacologico (cnpj) VALUES ('72100888802027');
INSERT INTO public.laboratorio_farmacologico (cnpj) VALUES ('72100888802028');
INSERT INTO public.laboratorio_farmacologico (cnpj) VALUES ('72100888802029');
INSERT INTO public.operadora (cnpj) VALUES ('72100888802030');
INSERT INTO public.operadora (cnpj) VALUES ('72100888802031');
INSERT INTO public.operadora (cnpj) VALUES ('72100888802032');
INSERT INTO public.operadora (cnpj) VALUES ('72100888802033');
INSERT INTO public.operadora (cnpj) VALUES ('72100888802034');
INSERT INTO public.plano_saude (cnpj, tipo_plano, abrangencia, acomodacao, servicos, carencia, data_ultimo_reajuste, valor) VALUES ('72100888802030', 'familiar', 'nacional', 'apartamento', '', 180, '2017-01-01', 1800);
INSERT INTO public.plano_saude (cnpj, tipo_plano, abrangencia, acomodacao, servicos, carencia, data_ultimo_reajuste, valor) VALUES ('72100888802031', 'individual', 'estadual', 'enfermaria', '', 30, '2016-06-01', 800);
INSERT INTO public.plano_saude (cnpj, tipo_plano, abrangencia, acomodacao, servicos, carencia, data_ultimo_reajuste, valor) VALUES ('72100888802032', 'familiar', 'estadual', 'apartamento', '', 180, '2016-01-01', 1000);
INSERT INTO public.plano_saude (cnpj, tipo_plano, abrangencia, acomodacao, servicos, carencia, data_ultimo_reajuste, valor) VALUES ('72100888802033', 'empresarial', 'municipal', 'enfermaria', '', 60, '2017-07-01', 600);
INSERT INTO public.plano_saude (cnpj, tipo_plano, abrangencia, acomodacao, servicos, carencia, data_ultimo_reajuste, valor) VALUES ('72100888802034', 'individual', 'nacional', 'enfermaria', '', 180, '2016-12-31', 1000);
INSERT INTO public.medicamento (id, nome_comercial, forma, contra_indicacao, cnpj) VALUES (10, 'Tylenol', 'comprimido', '', '72100888802025');
INSERT INTO public.medicamento (id, nome_comercial, forma, contra_indicacao, cnpj) VALUES (20, 'Magnopyrol', 'gotas', 'dengue', '72100888802026');
INSERT INTO public.medicamento (id, nome_comercial, forma, contra_indicacao, cnpj) VALUES (30, 'Aspirina', 'comprimido', 'dengue', '72100888802027');
INSERT INTO public.medicamento (id, nome_comercial, forma, contra_indicacao, cnpj) VALUES (40, 'Resfenol', 'cápsula', 'cardíacos', '72100888802028');
INSERT INTO public.medicamento (id, nome_comercial, forma, contra_indicacao, cnpj) VALUES (50, 'Neosaldina', 'comprimido', 'crianças', '72100888802029');
INSERT INTO public.paciente (cpf) VALUES ('66788827850');
INSERT INTO public.paciente (cpf) VALUES ('88655726970');
INSERT INTO public.paciente (cpf) VALUES ('95482399900');
INSERT INTO public.paciente (cpf) VALUES ('22222222222');
INSERT INTO public.paciente (cpf) VALUES ('21212121212');
INSERT INTO public.paciente (cpf) VALUES ('32323232323');
INSERT INTO public.paciente (cpf) VALUES ('33333333333');
INSERT INTO public.paciente_conveniado (cpf, cnpj, tipo_plano, numero_conveniado, data_contratacao, termino_carencia, valor_contratacao, id) VALUES ('95482399900', '72100888802032', 'familiar', '30003000', '1998-08-12', '1998-09-12', 1000, 33);
INSERT INTO public.paciente_conveniado (cpf, cnpj, tipo_plano, numero_conveniado, data_contratacao, termino_carencia, valor_contratacao, id) VALUES ('22222222222', '72100888802033', 'empresarial', '40004000', '2001-03-16', '2001-04-16', 600, 34);
INSERT INTO public.paciente_conveniado (cpf, cnpj, tipo_plano, numero_conveniado, data_contratacao, termino_carencia, valor_contratacao, id) VALUES ('21212121212', '72100888802034', 'individual', '50005000', '2016-07-19', '2016-09-19', 1000, 35);
INSERT INTO public.paciente_conveniado (cpf, cnpj, tipo_plano, numero_conveniado, data_contratacao, termino_carencia, valor_contratacao, id) VALUES ('66788827850', '72100888802030', 'familiar', '10001000', '2007-06-21', '2007-12-21', 1800, 38);
INSERT INTO public.paciente_conveniado (cpf, cnpj, tipo_plano, numero_conveniado, data_contratacao, termino_carencia, valor_contratacao, id) VALUES ('88655726970', '72100888802031', 'individual', '20002000', '2012-12-06', '2013-06-06', 800, 39);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('12121212', '2016-08-16', '15:30:00', 200);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('23232323', '2015-12-21', '17:30:00', 300);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('34343434', '2017-01-07', '13:30:00', 450);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('45454545', '2016-04-02', '12:00:00', 150);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('56565656', '2016-02-08', '12:30:00', 850);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('99998888', '2016-12-19', '08:30:00', 200);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('77776666', '2015-09-20', '19:30:00', 300);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('55554444', '2015-07-26', '11:00:00', 450);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('33332222', '2016-03-15', '11:30:00', 150);
INSERT INTO public.nota_fiscal (cod, data_emissao, hora_emissao, valor_total) VALUES ('11110000', '2015-07-26', '11:00:00', 850);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('95482399900', '11111111110', '72100888802011', '2016-04-09 12:30:00.000000', 'C', 300, '4a', null, 4, 33);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('22222222222', '13333333332', '72100888802012', '2016-08-16 15:00:00.000000', 'P', 450, '4a', '12121212', 5, null);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('21212121212', '55500011122', '72100888802013', '2015-12-21 17:00:00.000000', 'P', 150, '4a', '23232323', 6, null);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('32323232323', '66600011122', '72100888802014', '2017-01-07 13:00:00.000000', 'P', 850, '4a', '34343434', 7, null);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('88655726970', '88888888888', '72100888802010', '2016-02-08 12:00:00.298000', 'C', 200, null, null, 8, 39);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('95482399900', '11111111110', '72100888802011', '2016-04-02 11:30:00.000000', 'P', 350, '4a', '45454545', 9, null);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('22222222222', '13333333332', '72100888802012', '2016-08-19 10:00:00.000000', 'C', 500, '4a', null, 10, 34);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('21212121212', '55500011122', '72100888802013', '2015-12-21 18:00:00.000000', 'C', 200, '4a', null, 11, 35);
INSERT INTO public.consulta (cpf_paciente, cpf_medico, cnpj_hospital, data_hora, tipo, valor, recibo, cod_nota_fiscal, id, id_paciente_conveniado) VALUES ('88655726970', '88888888888', '72100888802010', '2016-02-08 12:00:00.298000', 'P', 250, null, '56565656', 13, null);
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('66788827850', '55', '11', 'Fixo', '11111111');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('88655726970', '55', '11', 'Fixo', '22222222');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('95482399900', '55', '11', 'Fixo', '33333333');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('80070022266', '55', '11', 'Fixo', '44444444');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('12345678910', '55', '11', 'Fixo', '55555555');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('11111111111', '55', '11', 'Fixo', '66666666');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('22222222222', '55', '11', 'Fixo', '77777777');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('21212121212', '55', '11', 'Fixo', '88888888');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('32323232323', '55', '11', 'Fixo', '99999999');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('33333333333', '55', '11', 'Fixo', '111111110');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('44444444444', '55', '11', 'Fixo', '122222221');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('66666666666', '55', '11', 'Fixo', '133333332');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('88888888888', '55', '11', 'Fixo', '144444443');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('11111111110', '55', '11', 'Fixo', '155555554');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('13333333332', '55', '11', 'Fixo', '166666665');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('23333333332', '55', '11', 'Fixo', '166661010');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('11100011122', '55', '11', 'Fixo', '1111112222');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('22200011122', '55', '11', 'Celular', '1111112223');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('33300011122', '55', '11', 'Fixo', '1111112224');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('44400011122', '55', '11', 'Celular', '1111112225');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('55500011122', '55', '11', 'Fixo', '1111112226');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('66600011122', '55', '11', 'Celular', '1111112227');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('77700011122', '55', '11', 'Fixo', '1111112228');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('88811111122', '55', '11', 'Celular', '1111112229');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('99922211122', '55', '11', 'Fixo', '1111112230');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('11103331112', '55', '11', 'Fixo', '1111112231');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('12214441112', '55', '11', 'Celular', '1111112232');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('13325551112', '55', '11', 'Fixo', '1111112233');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('14436661112', '55', '11', 'Fixo', '1111112234');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('15547771112', '55', '11', 'Fixo', '1111112235');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('16658881112', '55', '11', 'Fixo', '1111112236');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('17769991112', '55', '11', 'Fixo', '1111112237');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('66788827850', '55', '11', 'Celular ', '177777776');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('88655726970', '55', '11', 'Celular', '188888887');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('95482399900', '55', '11', 'Whats', '199999998');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('80070022266', '55', '11', 'Celular ', '211111109');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('12345678910', '55', '11', 'Celular', '222222220');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('11111111111', '55', '11', 'Whats', '233333331');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('22222222222', '55', '11', 'Celular ', '244444442');
INSERT INTO public.telefone_pf (cpf, ddi, ddd, numero, tipo) VALUES ('21212121212', '55', '11', 'Celular', '255555553');
INSERT INTO public.medicamento_receitado (id_consulta, id_medicamento, cnpj_farmacia, periodo, dosagem) VALUES (5, 20, '72100888802016', '20 dias', '10 gotas');
INSERT INTO public.medicamento_receitado (id_consulta, id_medicamento, cnpj_farmacia, periodo, dosagem) VALUES (6, 30, '72100888802017', '15 dias', '1 comprimido');
INSERT INTO public.medicamento_receitado (id_consulta, id_medicamento, cnpj_farmacia, periodo, dosagem) VALUES (7, 40, '72100888802018', '10 dias', '2 cápsulas');
INSERT INTO public.medicamento_receitado (id_consulta, id_medicamento, cnpj_farmacia, periodo, dosagem) VALUES (8, 50, '72100888802019', '2 semanas', '2 comprimidos');
INSERT INTO public.medicamento_receitado (id_consulta, id_medicamento, cnpj_farmacia, periodo, dosagem) VALUES (4, 10, '72100888802015', '1 semana', '1 comprimido');
INSERT INTO public.agenda_medicamento (id_consulta, id_medicamento, horario, posologia, seg, ter, qua, qui, sex, sab, dom) VALUES (4, 10, '12:00:00', '', true, true, true, true, true, true, true);
INSERT INTO public.agenda_medicamento (id_consulta, id_medicamento, horario, posologia, seg, ter, qua, qui, sex, sab, dom) VALUES (5, 20, '08:00:00', '', true, false, true, false, true, false, true);
INSERT INTO public.agenda_medicamento (id_consulta, id_medicamento, horario, posologia, seg, ter, qua, qui, sex, sab, dom) VALUES (6, 30, '10:00:00', '', true, true, false, true, true, false, true);
INSERT INTO public.agenda_medicamento (id_consulta, id_medicamento, horario, posologia, seg, ter, qua, qui, sex, sab, dom) VALUES (7, 40, '08:00:00', '', false, true, false, true, false, true, false);
INSERT INTO public.agenda_medicamento (id_consulta, id_medicamento, horario, posologia, seg, ter, qua, qui, sex, sab, dom) VALUES (8, 50, '12:00:00', '', true, false, false, true, false, false, true);
INSERT INTO public.principio_ativo (id, nome, concentracao, unidade) VALUES (100, 'paracetamol', 300, 'mg');
INSERT INTO public.principio_ativo (id, nome, concentracao, unidade) VALUES (200, 'dipirona sódica', 500, 'mg/ml');
INSERT INTO public.principio_ativo (id, nome, concentracao, unidade) VALUES (300, 'dipirona sódica', 300, 'mg');
INSERT INTO public.principio_ativo (id, nome, concentracao, unidade) VALUES (400, 'aas', 500, 'mg');
INSERT INTO public.principio_ativo (id, nome, concentracao, unidade) VALUES (500, 'cafeína', 20, 'mg');
INSERT INTO public.composicao_medicamento (id_medicamento, id_principio_ativo) VALUES (10, 100);
INSERT INTO public.composicao_medicamento (id_medicamento, id_principio_ativo) VALUES (20, 200);
INSERT INTO public.composicao_medicamento (id_medicamento, id_principio_ativo) VALUES (30, 400);
INSERT INTO public.composicao_medicamento (id_medicamento, id_principio_ativo) VALUES (50, 300);
INSERT INTO public.composicao_medicamento (id_medicamento, id_principio_ativo) VALUES (50, 500);
INSERT INTO public.exame (id, nome) VALUES (1, 'PSA');
INSERT INTO public.exame (id, nome) VALUES (2, 'VHS');
INSERT INTO public.exame (id, nome) VALUES (3, 'CPK');
INSERT INTO public.exame (id, nome) VALUES (4, 'TSH');
INSERT INTO public.exame (id, nome) VALUES (5, 'PCR');
INSERT INTO public.familiar (cpf_paciente, cpf_pessoa_fisica, autorizacao, cosanguineo, grau_parentesco) VALUES ('88655726970', '66788827850', true, true, 'pai');
INSERT INTO public.familiar (cpf_paciente, cpf_pessoa_fisica, autorizacao, cosanguineo, grau_parentesco) VALUES ('88655726970', '88655726970', false, true, 'irmão');
INSERT INTO public.familiar (cpf_paciente, cpf_pessoa_fisica, autorizacao, cosanguineo, grau_parentesco) VALUES ('22222222222', '95482399900', true, true, 'filho');
INSERT INTO public.familiar (cpf_paciente, cpf_pessoa_fisica, autorizacao, cosanguineo, grau_parentesco) VALUES ('22222222222', '80070022266', false, false, 'sogro');
INSERT INTO public.familiar (cpf_paciente, cpf_pessoa_fisica, autorizacao, cosanguineo, grau_parentesco) VALUES ('32323232323', '12345678910', true, true, 'filho');
INSERT INTO public.anamnese (cpf_paciente, data_hora, pergunta, resposta) VALUES ('88655726970', '2016-02-03 15:00:00.000000', 'já contraiu dengue?', 'não');
INSERT INTO public.anamnese (cpf_paciente, data_hora, pergunta, resposta) VALUES ('22222222222', '2016-08-12 17:00:00.000000', 'toma algum medicamento controlado?', 'não');
INSERT INTO public.anamnese (cpf_paciente, data_hora, pergunta, resposta) VALUES ('22222222222', '2016-08-13 17:00:00.000000', 'possui histórico de câncer na família?', 'não');
INSERT INTO public.anamnese (cpf_paciente, data_hora, pergunta, resposta) VALUES ('32323232323', '2017-01-03 12:00:00.000000', 'toma algum medicamento controlado?', 'sim, hipnótico stilnox ');
INSERT INTO public.anamnese (cpf_paciente, data_hora, pergunta, resposta) VALUES ('88655726970', '2016-02-03 13:00:00.929000', 'toma algum medicamento controlado?', 'sim, antidepressivo anafranil');
INSERT INTO public.laboratorista (cpf) VALUES ('12345678910');
INSERT INTO public.laboratorista (cpf) VALUES ('11111111111');
INSERT INTO public.laboratorista (cpf) VALUES ('15547771112');
INSERT INTO public.laboratorista (cpf) VALUES ('16658881112');
INSERT INTO public.laboratorista (cpf) VALUES ('17769991112');
INSERT INTO public.funcionario_laboratorio (cpf_laboratorista, cnpj_laboratorio_exame) VALUES ('12345678910', '72100888802020');
INSERT INTO public.funcionario_laboratorio (cpf_laboratorista, cnpj_laboratorio_exame) VALUES ('11111111111', '72100888802021');
INSERT INTO public.funcionario_laboratorio (cpf_laboratorista, cnpj_laboratorio_exame) VALUES ('15547771112', '72100888802022');
INSERT INTO public.funcionario_laboratorio (cpf_laboratorista, cnpj_laboratorio_exame) VALUES ('16658881112', '72100888802023');
INSERT INTO public.funcionario_laboratorio (cpf_laboratorista, cnpj_laboratorio_exame) VALUES ('17769991112', '72100888802024');
INSERT INTO public.funcionario_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital) VALUES ('44444444444', '72100888802010');
INSERT INTO public.funcionario_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital) VALUES ('66666666666', '72100888802011');
INSERT INTO public.funcionario_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital) VALUES ('88888888888', '72100888802012');
INSERT INTO public.funcionario_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital) VALUES ('11111111110', '72100888802013');
INSERT INTO public.funcionario_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital) VALUES ('13333333332', '72100888802014');
INSERT INTO public.atendimento_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital, data_hora_inicio, data_hota_fim, setor) VALUES ('66666666666', '72100888802011', '2016-12-13 08:00:00.000000', '2016-12-13 11:00:00.000000', 'uti');
INSERT INTO public.atendimento_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital, data_hora_inicio, data_hota_fim, setor) VALUES ('88888888888', '72100888802012', '2017-01-10 16:00:00.000000', '2017-01-10 20:00:00.000000', 'centro cirúrgico');
INSERT INTO public.atendimento_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital, data_hora_inicio, data_hota_fim, setor) VALUES ('11111111110', '72100888802013', '2017-03-25 20:00:00.000000', '2017-03-26 01:00:00.000000', 'pronto socorro');
INSERT INTO public.atendimento_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital, data_hora_inicio, data_hota_fim, setor) VALUES ('13333333332', '72100888802014', '2016-04-13 06:00:00.000000', '2016-04-13 10:00:00.000000', 'ambulatório');
INSERT INTO public.atendimento_clinica_hospital (cpf_profissional_saude, cnpj_clinica_hospital, data_hora_inicio, data_hota_fim, setor) VALUES ('44444444444', '72100888802010', '2017-02-25 13:00:00.570000', '2017-02-25 15:00:00.690000', 'ambulatório');
INSERT INTO public.email_pf (cpf, email) VALUES ('66788827850', 'tuliosilva@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('88655726970', 'mercedessilva@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('95482399900', 'amandasilva@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('80070022266', 'marcosprado@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('12345678910', 'isabellasouza@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('11111111111', 'davidcortez@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('22222222222', 'pedromedeiros@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('21212121212', 'joanamedeiros@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('32323232323', 'biancamedeiros@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('33333333333', 'marcelamedeiros@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('44444444444', 'cesarcaetano@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('66666666666', 'emersonmedeiros@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('88888888888', 'augustosato@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('11111111110', 'emilynaroshi@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('13333333332', 'marciavenancio@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('23333333332', 'ameliajacinto@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('11100011122', 'joaquimafonso@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('22200011122', 'taissavalerio@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('33300011122', 'leonardosalazar@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('44400011122', 'alinecustodio@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('55500011122', 'helenamartinho@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('66600011122', 'adrianorebocho@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('77700011122', 'linaandrada@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('88811111122', 'julianocolaco@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('99922211122', 'neuzachamusa@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('11103331112', 'candidofagundes@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('12214441112', 'eusebiobandeira@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('13325551112', 'emaviveiros@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('14436661112', 'greicemorais@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('15547771112', 'celinagirao@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('16658881112', 'sandracarneiro@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('17769991112', 'aldaassis@gmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('66788827850', 'tuliosilva@hotmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('88655726970', 'mercedessilva@hotmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('95482399900', 'amandasilva@hotmail.com');
INSERT INTO public.email_pf (cpf, email) VALUES ('80070022266', 'marcosprado@hotmail.com');
INSERT INTO public.interacao_medicamentosa (id_medicamento_1, id_medicamento_2, efeito) VALUES (10, 20, 'dor de cabeça');
INSERT INTO public.interacao_medicamentosa (id_medicamento_1, id_medicamento_2, efeito) VALUES (30, 40, 'aceleração nos batimentos cardíacos');
INSERT INTO public.interacao_medicamentosa (id_medicamento_1, id_medicamento_2, efeito) VALUES (50, 20, 'superdosagem de dipirona sódica');
INSERT INTO public.interacao_medicamentosa (id_medicamento_1, id_medicamento_2, efeito) VALUES (10, 40, 'superdosagem de paracetamol');
INSERT INTO public.interacao_medicamentosa (id_medicamento_1, id_medicamento_2, efeito) VALUES (30, 50, 'insônia');
INSERT INTO public.medicamento_disponivel (id_medicamento, cnpj_farmacia, estoque) VALUES (10, '72100888802015', 15);
INSERT INTO public.medicamento_disponivel (id_medicamento, cnpj_farmacia, estoque) VALUES (10, '72100888802016', 20);
INSERT INTO public.medicamento_disponivel (id_medicamento, cnpj_farmacia, estoque) VALUES (30, '72100888802015', 40);
INSERT INTO public.medicamento_disponivel (id_medicamento, cnpj_farmacia, estoque) VALUES (40, '72100888802016', 5);
INSERT INTO public.medicamento_disponivel (id_medicamento, cnpj_farmacia, estoque) VALUES (50, '72100888802019', 50);
INSERT INTO public.medico_conveniado (cpf_medico, cnpj_operadora, data_adesao) VALUES ('88888888888', '72100888802030', '2005-04-15');
INSERT INTO public.medico_conveniado (cpf_medico, cnpj_operadora, data_adesao) VALUES ('88888888888', '72100888802031', '2013-04-12');
INSERT INTO public.medico_conveniado (cpf_medico, cnpj_operadora, data_adesao) VALUES ('13333333332', '72100888802030', '2000-12-19');
INSERT INTO public.medico_conveniado (cpf_medico, cnpj_operadora, data_adesao) VALUES ('55500011122', '72100888802031', '2003-07-26');
INSERT INTO public.medico_conveniado (cpf_medico, cnpj_operadora, data_adesao) VALUES ('66600011122', '72100888802034', '2016-01-24');
INSERT INTO public.cuidador (cpf) VALUES ('80070022266');
INSERT INTO public.cuidador (cpf) VALUES ('11103331112');
INSERT INTO public.cuidador (cpf) VALUES ('12214441112');
INSERT INTO public.cuidador (cpf) VALUES ('13325551112');
INSERT INTO public.cuidador (cpf) VALUES ('14436661112');
INSERT INTO public.paciente_cuidador (cpf_paciente, cpf_cuidador, periodicidade, data_inicio, data_fim) VALUES ('88655726970', '80070022266', '3 vezes por semana', '2015-05-01', '2015-06-13');
INSERT INTO public.paciente_cuidador (cpf_paciente, cpf_cuidador, periodicidade, data_inicio, data_fim) VALUES ('88655726970', '11103331112', '2 vezes por semana', '2015-05-01', '2015-06-13');
INSERT INTO public.paciente_cuidador (cpf_paciente, cpf_cuidador, periodicidade, data_inicio, data_fim) VALUES ('22222222222', '80070022266', 'diariamente', '2016-09-05', '2016-12-05');
INSERT INTO public.paciente_cuidador (cpf_paciente, cpf_cuidador, periodicidade, data_inicio, data_fim) VALUES ('21212121212', '13325551112', 'semanalmente', '2016-07-03', '2016-08-19');
INSERT INTO public.paciente_cuidador (cpf_paciente, cpf_cuidador, periodicidade, data_inicio, data_fim) VALUES ('32323232323', '14436661112', '3 vezes por semana', '2016-01-18', '2016-03-15');
INSERT INTO public.paciente_cuidador_especial (cpf_paciente, cpf_cuidador_especial, periodicidade, data_inicio, data_fim) VALUES ('88655726970', '44444444444', 'diariamente', '2015-05-01', '2015-06-13');
INSERT INTO public.paciente_cuidador_especial (cpf_paciente, cpf_cuidador_especial, periodicidade, data_inicio, data_fim) VALUES ('88655726970', '66666666666', 'semanalmente', '2015-05-01', '2015-06-13');
INSERT INTO public.paciente_cuidador_especial (cpf_paciente, cpf_cuidador_especial, periodicidade, data_inicio, data_fim) VALUES ('22222222222', '77700011122', 'diariamente', '2016-09-05', '2016-12-05');
INSERT INTO public.paciente_cuidador_especial (cpf_paciente, cpf_cuidador_especial, periodicidade, data_inicio, data_fim) VALUES ('21212121212', '88811111122', '2 vezes por semana', '2016-07-03', '2016-08-19');
INSERT INTO public.paciente_cuidador_especial (cpf_paciente, cpf_cuidador_especial, periodicidade, data_inicio, data_fim) VALUES ('32323232323', '44444444444', 'diariamente', '2016-03-15', '2016-12-18');
INSERT INTO public.exame_coberto (cnpj_plano_saude, tipo_plano_plano_saude, id_exame) VALUES ('72100888802030', 'familiar', 1);
INSERT INTO public.exame_coberto (cnpj_plano_saude, tipo_plano_plano_saude, id_exame) VALUES ('72100888802031', 'individual', 2);
INSERT INTO public.exame_coberto (cnpj_plano_saude, tipo_plano_plano_saude, id_exame) VALUES ('72100888802032', 'familiar', 1);
INSERT INTO public.exame_coberto (cnpj_plano_saude, tipo_plano_plano_saude, id_exame) VALUES ('72100888802033', 'empresarial', 2);
INSERT INTO public.exame_coberto (cnpj_plano_saude, tipo_plano_plano_saude, id_exame) VALUES ('72100888802034', 'individual', 3);
INSERT INTO public.medidas_aferidas (id_consulta, data_hora, instrumento, tipo, medicao) VALUES (4, '2016-02-03 13:00:00.000000', 'esfigmomanômetro', 'pressão arterial', '130 - 89 mm hg');
INSERT INTO public.medidas_aferidas (id_consulta, data_hora, instrumento, tipo, medicao) VALUES (5, '2016-04-06 15:30:00.000000', 'esfigmomanômetro', 'pressão arterial', '145 - 100 mm hg');
INSERT INTO public.medidas_aferidas (id_consulta, data_hora, instrumento, tipo, medicao) VALUES (6, '2016-08-12 17:00:00.000000', 'monitor cardíaco', 'batimentos cardíacos', '150 bpm');
INSERT INTO public.medidas_aferidas (id_consulta, data_hora, instrumento, tipo, medicao) VALUES (7, '2015-12-24 11:00:00.000000', 'monitor cardíaco', 'batimentos cardíacos', '110 bpm');
INSERT INTO public.medidas_aferidas (id_consulta, data_hora, instrumento, tipo, medicao) VALUES (8, '2017-01-03 12:00:00.000000', 'bafômetro', 'estado alcoólico', '20 dg/L');
INSERT INTO public.profissional_saude_recomendado (id_consulta, cpf_profissional_saude, recomendacao) VALUES (4, '66666666666', 'realizar seções de manhã');
INSERT INTO public.profissional_saude_recomendado (id_consulta, cpf_profissional_saude, recomendacao) VALUES (5, '66666666666', 'realizar seções 3 vezes por semana');
INSERT INTO public.profissional_saude_recomendado (id_consulta, cpf_profissional_saude, recomendacao) VALUES (6, '44444444444', 'realizar seções de noite');
INSERT INTO public.profissional_saude_recomendado (id_consulta, cpf_profissional_saude, recomendacao) VALUES (7, '44444444444', 'realizar seções diariamente');
INSERT INTO public.profissional_saude_recomendado (id_consulta, cpf_profissional_saude, recomendacao) VALUES (8, '77700011122', 'indicar dieta de baixo teor calórico');
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (4, 1, '72100888802020', '12345678910', true, 33, 50, 'nenhuma anomalia detectada', 85, '1a', '2016-03-15 11:00:00.000000', null);
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (5, 1, '72100888802021', '12345678910', false, null, null, 'valores alterados', 125, '1a', '2016-12-19 08:00:00.000000', '99998888');
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (6, 2, '72100888802022', '15547771112', true, null, null, 'nenhuma anomalia detectada', 90, '1a', '2015-09-20 09:00:00.000000', '77776666');
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (7, 1, '72100888802023', '15547771112', false, null, null, 'valores alterados', 150, '1a', '2015-07-26 10:00:00.000000', '55554444');
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (8, 2, '72100888802024', '15547771112', false, 39, 90, 'nenhuma anomalia detectada', 220, null, '2017-01-01 14:00:00.340000', null);
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (9, 1, '72100888802020', '12345678910', true, null, null, 'nenhuma anomalia detectada', 55, '1a', '2016-03-15 11:00:00.000000', '33332222');
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (10, 1, '72100888802021', '12345678910', false, 34, 80, 'valores alterados', 128, '1a', '2016-12-19 08:00:00.000000', null);
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (11, 2, '72100888802022', '15547771112', true, 35, 90, 'nenhuma anomalia detectada', 88, '1a', '2015-09-20 09:00:00.000000', null);
INSERT INTO public.exame_solicitado_realizado (id_consulta, id_exame, cnpj_laboratorio_exame, cpf_laboratorista, realizado_na_consulta, id_paciente_conveniado, percentual_cobertura, laudo, valor, recibo, data_hora_agendamento, cod_nota_fiscal) VALUES (13, 1, '72100888802023', '15547771112', false, null, null, 'valores alterados', 144, '1a', '2015-07-26 10:00:00.000000', '11110000');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('66788827850', 'Facebook', 'tuliosilva');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('88655726970', 'Linkedin', 'mariasilva');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('95482399900', 'Google+', 'amandasilva');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('80070022266', 'Facebook', 'marcosprado');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('12345678910', 'Facebook', 'isabellasouza');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('11111111111', 'Facebook', 'davidcortez');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('22222222222', 'Google+', 'pedromedeiros');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('21212121212', 'Facebook', 'joanamedeiros');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('32323232323', 'Facebook', 'biancamedeiros');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('33333333333', 'Facebook', 'marcelamedeiros');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('44444444444', 'Google+', 'cesarcaetano');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('66666666666', 'Facebook', 'emersonmedeiros');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('88888888888', 'Facebook', 'augustosato');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('11111111110', 'Linkedin', 'emilynaroshi');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('13333333332', 'Facebook', 'marciavenancio');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('23333333332', 'Facebook', 'ameliajacinto');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('11100011122', 'Linkedin', 'joaquimafonso');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('22200011122', 'Facebook', 'taissavalerio');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('33300011122', 'Facebook', 'leonardosalazar');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('44400011122', 'Google+', 'alinecustodio');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('55500011122', 'Facebook', 'helenamartinho');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('66600011122', 'Facebook', 'adrianorebocho');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('77700011122', 'Linkedin', 'linaandrada');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('88811111122', 'Facebook', 'julianocolaco');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('99922211122', 'Facebook', 'neuzachamusa');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('11103331112', 'Google+', 'candidofagundes');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('12214441112', 'Google+', 'eusebiobandeira');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('13325551112', 'Linkedin', 'emaviveiros');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('14436661112', 'Facebook', 'greicemorais');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('15547771112', 'Facebook', 'celinagirao');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('16658881112', 'Google+', 'sandracarneiro');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('17769991112', 'Linkedin', 'aldaassis');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('66788827850', 'Google+', 'tuliosilva');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('88655726970', 'Facebook', 'mariasilva');
INSERT INTO public.com_instantaneo_pf (cpf, tipo, usuario) VALUES ('95482399900', 'Facebook', 'amandasilva');
-- O conjunto de usuários Médico necessita gerenciar:
-- Os atendimentos particulares realizados listando clientes,
-- procedimentos realizados, exames laboratoriais e de imagens 
-- realizados, datas, valores envolvidos;
create or replace view consultas_cobertas_por_convenio_por_medico as
	select
		X.cpf_medico			as	cpfMedico,
		X.nome_fantasia			as	operadora,
		X.tipo_plano			as	plano,
		X.prenome				as	nomeCliente,
		X.sobrenome				as	sobrenomeCLiente,
		X.data_hora				as	dataConsulta,
		X.valor					as	valorConsulta,
		Y.nome 					as	exameRealizado,
		Y.laudo 				as 	laudoExame,
		Y.valor 				as	valorExame,
		Y.percentual_cobertura 	as percentualCobertoExame
	from
		(select
			C.cpf_medico,
			PJ.nome_fantasia,
			PS.tipo_plano,
			PF.prenome,
			PF.sobrenome,
			C.data_hora,
			C.valor,
			C.id
		from
			consulta 				C,
			paciente 				P,
			pessoa_fisica			PF,
			paciente_conveniado 	PC,
			plano_saude				PS,
			operadora				O,
			pessoa_juridica			PJ
		where
			C.tipo = 'C'
			and C.cpf_paciente = P.cpf
			and P.cpf = PF.cpf
			and C.id_paciente_conveniado = PC.id
			and PC.tipo_plano = PS.tipo_plano
			and PC.cnpj = O.cnpj
			and PS.cnpj = O.cnpj
			and O.cnpj = PJ.cnpj) X
	left join
		(select
			E.nome,
			ESR.id_consulta,
			ESR.valor,
			ESR.percentual_cobertura,
			ESR.laudo
		from 
			exame_solicitado_realizado	ESR, 
			exame 						E
		where
			ESR.realizado_na_consulta is true
			and ESR.id_exame = E.id) Y
	on X.id = Y.id_consulta;

-- O conjunto de usuários Médico necessita gerenciar:
-- Os atendimentos realizados para cada plano de saúde/odontológico, 
-- listando clientes, procedimentos realizados, exames laboratoriais e 
-- de imagens realizados, datas, valores envolvidos;
create or replace view consultas_particulares_por_medico as
	select
		X.cpf_medico	as	cpfMedico,
		X.prenome		as	nomeCliente,
		X.sobrenome		as	sobrenomeCLiente,
		X.data_hora		as	dataConsulta,
		X.valor			as	valorConsulta,
		Y.nome 			as	exameRealizado,
		Y.laudo			as 	laudoExame,
		Y.valor 		as	valorExame
	from
		(select
			C.cpf_medico,
			PF.prenome,
			PF.sobrenome,
			C.data_hora,
			C.valor,
			C.id
		from
			consulta 		C,
			paciente 		P,
			pessoa_fisica	PF
		where
			C.tipo = 'P'
			and C.cpf_paciente = P.cpf
			and P.cpf = PF.cpf) X
	left join
		(select
			E.nome,
			ESR.id_consulta,
			ESR.valor,
			ESR.laudo	
		from 
			exame_solicitado_realizado	ESR, 
			exame 						E
		where
			ESR.realizado_na_consulta is true
			and ESR.id_exame = E.id) Y
	on X.id = Y.id_consulta;

-- Autor: Dionisius Mayr
------------------------------------------------------------------------------------------------------------------------
-- O conjunto de usuários Paciente necessita gerenciar:
-- O uso de seus planos de saúde, com informes sobre consultas/exames que tenham sido pagos pelos planos,
-- informando qual o plano de saúde, qual o número do cartão de associado ao plano e data/hora nos quais foi utilizado;

