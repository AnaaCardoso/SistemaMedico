-- Ana Lucia Cardoso 611107 
CREATE OR REPLACE VIEW v_Paciente_AgendamentoConsultas
  AS SELECT c.cpf_paciente, c.data_hora, c.cpf_medico, pf.prenome, pf.meionome, pf.sobrenome, c.cnpj_hospital, pj.nome_fantasia
    FROM consulta c, pessoa_fisica pf, pessoa_juridica pj
    WHERE c.cpf_medico = pf.cpf AND
          c.cnpj_hospital = pj.cnpj;

SELECT * FROM v_Paciente_AgendamentoConsultas;
