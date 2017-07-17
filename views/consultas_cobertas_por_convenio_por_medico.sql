-- O conjunto de usuários Médico necessita gerenciar:
-- Os atendimentos particulares realizados listando clientes,
-- procedimentos realizados, exames laboratoriais e de imagens 
-- realizados, datas, valores envolvidos;
create or replace view consultas_cobertas_por_convenio_por_medico as
	select
		X.cpf_medico	as	cpfMedico,
		X.nome_fantasia	as	operadora,
		X.tipo_plano	as	plano,
		X.prenome		as	nomeCliente,
		X.sobrenome		as	sobrenomeCLiente,
		X.data_hora		as	dataConsulta,
		X.valor			as	valorConsulta,
		Y.nome 			as	exameRealizado,
		Y.laudo 		as 	laudoExame,
		Y.valor 		as	valorExame
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
			ESR.laudo
		from 
			exame_solicitado_realizado	ESR, 
			exame 						E
		where
			ESR.realizado_na_consulta is true
			and ESR.id_exame = E.id) Y
	on X.id = Y.id_consulta;