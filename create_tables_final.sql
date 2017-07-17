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

