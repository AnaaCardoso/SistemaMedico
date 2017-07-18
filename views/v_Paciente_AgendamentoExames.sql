-- Ana Lucia Cardoso 611107
CREATE OR REPLACE VIEW v_Paciente_AgendamentoExames
  AS SELECT c.cpf_paciente, ers.id_exame, e.nome, ers.cnpj_laboratorio_exame, pj.nome_fantasia, ers.data_hora_agendamento
     FROM exame_solicitado_realizado ers, exame e, pessoa_juridica pj, consulta c
     WHERE ers.id_consulta = c.id AND
           ers.cnpj_laboratorio_exame = pj.cnpj AND
           ers.id_exame = e.id;

SELECT * FROM v_Paciente_AgendamentoExames;
