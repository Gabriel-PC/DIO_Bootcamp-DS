### O papel dos Bancos de Dados Relacionais (SQL) e Não Relacionais (NoSQL) no contexto de um ***Engenheiro de Dados***.

#### O Engenheiro de Dados é o profissional responsável pela coleta e disponibilização dos dados brutos por uma pipeline para um formato que permita os outros profissionais subsequentes, como o Cientista de Dados, venha consultar estes dados. ***Gerenciando, monitorando, recuperando, armazenando, otimizando e distribuindo os dados*** dentro de uma arquitetura.

  Os diversos modelos de programas de **SGBD**, nomes e linguaguens vieram da necessidade de enquadrar, armazenar e trabalhar sobre os diversos tipos de dados que surgiram ao longo do tempo. Existem muitos nomes que atendem diferentes demandas, que aumentam cada vez mais a abrangência dos dados que podem ser trabalhados. Eles não vieram pra substituir os nomes existentes, mas sim pra complementá-los, tem espaço pra todos eles, aumentando a flexibilidade sem restrições a qualquer nome, mas tendo o cuidado com a complexidade que este banco pode tomar ao agregar diversas tecnologias. Assim o foco do engenheiro/analista está em sempre otimizar a solução com as escolhas destas ferramentas.

  As primeiras estruturas de bancos de dados surgiram na década de 1960 na empresa **IBM**. O objetivo era reduzir custos do trabalho de armazenagem, organização e indexação de dados e arquivos. Temos hoje um separação em dois tipos de Banco de Dados, aqueles com **Dados Relacionais**, e aqueles com **Dados Não-Relacionais**.

#### **SQL**
  Um armazenamento de dados que possuem algum grau de relacionamento, trazendo consigo normalização para estruturação e integridade dos dados contidos.
#### **NoSQL**
  O termo surgiu em 1998 como o nome de um banco de dados relacional de código aberto que não possuía uma interface SQL, e ressurgiu somente em 2009 aí sim descrevendo um banco não-relacional, sem garantias, horizontal e schemaless. Apesar da falta de estrutura, os bancos NoSQL _precisam apresentar algum tipo de modelo_, ou vários normalmente, que permita a busca e pesquisa dentro de suas bases, como por exemplo a utilização de _chave-valor ou mesmo índice_. Caso contrário seu DataLake pode virar um pântano de dados :scream:...

  O grande volume de dados não-relacional como _fotos, vídeos e áudios_, produzido inclusive pelas redes sociais, ajudou a impulsionar a crescente demanda de armazenamento e análise destes dados não estruturados, o comportamento do consumidor e do mercado ao longo das últimas duas décadas ditou grandes volumes de dados gerados.

  Há ainda que se levar em conta que a estrutura física dos bancos de dados, que por muito tempo permaneceu dentro das empresas, **migrou em boa parte para nuvem**. Foi um desenvolvimento natural, devido custos de manutenção, versionamento, super ou sub dimensionamento destes servidores, e também devido o desenvolvimento da rede de maior velocidade e serviços justamente de dados em nuvem com maior confiabilidade.

  Concluindo, dentro do papel do Engenheiro de Dados, _a tecnologia/ferramenta é apenas um meio para atingir nossos objetivos_, e portanto nunca deve perder o foco. E ainda este profissional precisa aguçar sua **curiosidade**, uma vez que coisas novas vão surgir a todo momento e ainda apurar seu **olhar crítico**, no sentido de saber aplicar a tecnologia para resolver o que de fato precisa ser resolvido. Portanto, além dos conhecimentos técnicos para realizar ETL e/ou ELT utilizando ferramentas, _sempre cuidar do fluxo de dados_.
