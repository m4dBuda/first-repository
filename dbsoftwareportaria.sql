  CREATE DATABASE security_db;

  CREATE TABLE moradores
      id_morador INT AUTO_INCREMENT PRIMARY KEY
      nome VARCHAR(255)
      cpf VARCHAR(255)
      rg INT
      cnh INT
      data_nascimento TIMESTAMP
      email VARCHAR(255)
      telefone VARCHAR(255)
      endereço VARCHAR(255)
      grupo INT
      criado_em TIMESTAMP DEFAULT NOW
      alterado_em TIMESTAMP DEFAULT NOW
      criado_por INT
        FOREIGN KEY (grupo) REFERENCES grupos(id_grupo)
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
  );

  CREATE TABLE usuarios (
      id_usuario INT AUTO_INCREMENT PRIMARY KEY
      nome VARCHAR(255)
      cpf VARCHAR(255)
      rg INT
      cnh INT
      data_nascimento TIMESTAMP
      email VARCHAR(255)
      telefone VARCHAR(255)
      endereço VARCHAR(255)
      criado_em TIMESTAMP DEFAULT NOW
      alterado_em TIMESTAMP DEFAULT NOW
      criado_por INT
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)  
  );

  CREATE TABLE esporadicos (
      id_esporadico INT AUTO_INCREMENT PRIMARY KEY
      nome VARCHAR(255)
      cpf VARCHAR(255)
      rg INT
      cnh INT
      data_nascimento TIMESTAMP
      email VARCHAR(255)
      telefone VARCHAR(255)
      endereço VARCHAR(255)
      lote_vinculado INT
      criado_em TIMESTAMP DEFAULT NOW
      alterado_em TIMESTAMP DEFAULT NOW
      criado_por INT
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
        FOREIGN KEY (lote_vinculado) REFERENCES lotes(id_lote) 
  );


  CREATE TABLE quadras (
      id_quadra INT AUTO_INCREMENT PRIMARY KEY
      quadra INT
      criado_em TIMESTAMP
      alterado_em TIMESTAMP
      alterado_por INT
      criado_por INT
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
        FOREIGN KEY (id_vinculado) REFERENCES moradores(morador_id)
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
  );

  CREATE TABLE lotes (
      id_lote INT AUTO_INCREMENT PRIMARY KEY
      lote INT
      metragem VARCHAR(255)
      situacao VARCHAR(255)
      obs VARCHAR(255)
      ativo BOOLEAN
      id_quadra INT
      id_vinculado INT 
      criado_em TIMESTAMP
      criado_por INT
        FOREIGN KEY (id_quadra) REFERENCES quadras(id_quadra)
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
        FOREIGN KEY (id_vinculado) REFERENCES moradores(id_morador)
  );

  CREATE TABLE grupos (
      id_grupo INT AUTO_INCREMENT PRIMARY KEY 
      tipo_grupo VARCHAR(255)
      permissão_grupo INT
      ativo BOOLEAN
      criado_em TIMESTAMP
      criado_por INT
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
  );

  CREATE TABLE liberacoes (
      id_liberacao INT AUTO_INCREMENT PRIMARY KEY
      nome VARCHAR(255)
      obs VARCHAR(255)
      liberado_em TIMESTAMP
      liberado_por INT
      valido_ate TIMESTAMP
        FOREIGN KEY (liberado_por) REFERENCES moradores(id_morador)
  );
        

  CREATE TABLE registros_esporadicos
    id_registro INT AUTO_INCREMENT PRIMARY KEY
    horario_entrada TIMESTAMP
    horario_saida TIMESTAMP
    nome INT
    destino INT
    operador INT
        FOREIGN KEY (nome) REFERENCES esporadicos(nome)  
        FOREIGN KEY (destino) REFERENCES lotes(id_lote)
        FOREIGN KEY (operador) REFERENCES usuarios(id_usuario)
  );
  
  CREATE TABLE registros_moradores
    id_registro INT AUTO_INCREMENT PRIMARY KEY
    horario_entrada TIMESTAMP
    horario_saida TIMESTAMP
    nome INT
    destino INT
    operador INT
        FOREIGN KEY (nome) REFERENCES moradores(nome)  
        FOREIGN KEY (destino) REFERENCES lotes(id_lote)
        FOREIGN KEY (operador) REFERENCES usuarios(id_usuario)
  ); 
   
  
  CREATE TABLE avisos (
      id_aviso INT AUTO_INCREMENT PRIMARY KEY
      referencia VARCHAR(255)
      mensagem VARCHAR(255)
      enviado_para INT
      criado_em TIMESTAMP
      criado_por INT
      modificado_em TIMESTAMP
        FOREIGN KEY (criado_por) REFERENCES usuarios(id_usuario)
        FOREIGN KEY (enviado_para) REFERENCES grupos(id_grupo)
  );

  CREATE TABLE bloqueados (
    id_bloqueio INT AUTO_INCREMENT PRIMARY KEY
    id_bloqueado INT
    razão VARCHAR(255)
    bloqueado_por INT
    FOREIGN KEY (id_bloqueado) REFERENCES esporadicos(id_esporadico)
    FOREIGN KEY (bloqueado_por) REFERENCES moradores(id_morador)
  );

