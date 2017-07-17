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