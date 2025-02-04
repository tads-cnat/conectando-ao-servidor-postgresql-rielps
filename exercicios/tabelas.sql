CREATE SCHEMA dbo;

CREATE TABLE dbo.Pessoa(
  cpf CHAR(11) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  nome VARCHAR(150) NOT NULL UNIQUE,
  data_nasc DATE NOT NULL,
  endereco VARCHAR(300) NOT NULL,
  telefone VARCHAR(15) NULL,
  CONSTRAINT pessoa_pk PRIMARY KEY (cpf)
);


CREATE TABLE dbo.Paciente(
  cpf_pessoa CHAR(11),
  senha VARCHAR(20) NOT NULL,
  plano_saude BOOLEAN not NULL DEFAULT FALSE,
  CONSTRAINT paciente_pk PRIMARY KEY (cpf_pessoa),
  CONSTRAINT paciente_fk FOREIGN KEY (cpf_pessoa) REFERENCES dbo.Pessoa(cpf)
);

CREATE TABLE dbo.Medico(
  cpf_pessoa CHAR(11),
  crm VARCHAR(10) NOt NULL UNIQUE,
  CONSTRAINT medico_pk PRIMARY KEY (cpf_pessoa),
  CONSTRAINT medico_fk FOREIGN KEY (cpf_pessoa) REFERENCES dbo.Pessoa(cpf)
);

CREATE TABLE dbo.Agendamento(
  cpf_paciente CHAR(11),
  cpf_medico CHAR(11),
  dh_consulta TIMESTAMP,
  dh_agendamento TIMESTAMP NOT NULL,
  valor_consulta FLOAT NOT NULL DEFAULT 0.0,
  CONSTRAINT agendamento_pk PRIMARY KEY (cpf_paciente, cpf_medico, dh_consulta),
  CONSTRAINT agendamento_fk_paciente FOREIGN KEY (cpf_paciente) REFERENCES dbo.Paciente,
  CONSTRAINT agendamento_fk_medico FOREIGN KEY (cpf_medico) REFERENCES dbo.Medico
);

CREATE TABLE dbo.Especialidade(
  id INT GENERATED ALWAYS AS IDENTITY,
  CONSTRAINT especialidade_pk PRIMARY KEY (id),
  descricao VARCHAR(300) NOT NULL
);

CREATE TABLE dbo.MedicoEspecialidade(
  cpf_medico CHAR(11),
  id_especialidade INT,
  CONSTRAINT MedicoEspecialidade_pk PRIMARY KEY (cpf_medico,id_especialidade),
  CONSTRAINT MedicoEspecialidade_fk_medico FOREIGN KEY (cpf_medico) REFERENCES dbo.Medico,
  CONSTRAINT MedicoEspecialidade_fk_especialidade FOREIGN KEY (id_especialidade) REFERENCES dbo.Especialidade
);