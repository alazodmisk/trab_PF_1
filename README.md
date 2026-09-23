## Tema do trabalho: Monitoramento de Segurança Cibernética
Integrantes:
Arthur Pedrinho de Paula RA:. 145100; 
Guilherme Henrique Viana Pichitelli Vitor RA:.145092.

### Descrição do sistema:
O sistema apresenta diferentes funcionalidades de segurança cibernética no que diz respeito ao monitoramento de uma determinada rede. A ideia central é analisar e buscar dados referentes à eventos que ocorrem nos ativos de uma rede por meio de funções recursivas, autorreferência, listas e tipos.

### Tipos criados:
Tipos pertencentes à hierarquia:

    pub type Evento {
        Evento(id: Int, 
            ip: String, 
            tipo: TipoEvento, 
            severidade: Severidade, 
            tentativas: Int, 
            status: StatusEvento)
    }

    pub type Ativo {
        Ativo(id: Int, nome: String, eventos: List(Evento))
    }

    pub type Setor {
        Setor(id: Int, nome: String, ativos: List(Ativo))
    }

    pub type Rede {
        Rede(id: Int, nome: String, setores: List(Setor))
    }

E tipos que compões evento (Tipo soma):

    pub type TipoEvento {
        TentativaDeLogin
        Malware
        AcessoSuspeito
        AlteracaoDeDados    
    }

    pub type Severidade {
        Nula
        Baixa
        Media
        Alta
        Critica
    }

    pub type StatusEvento {
        Desconhecido
        EmAnalise
        Resolvido
    }

### Funcionalidades:
As funcionalidades foram divididas em:

Buscas (encontrar dados dentro da hierarquia). Assim apresentando as seguintes funções:

    busca_evento_por_id
    busca_ativo_por_id
    busca_setor_perigoso
    tentativas_maior_menor

Processamento (funções que recebem dados como entradas e devolve novos dados). Assim apresentando as seguintes funções:

    calcula_total_invasoes
    instancia_evento
    classifica_evento
    mascara_ip
    calcula_media
    imprime_relatorio


### Instruções:
###### Passos REPL:
    1. Abra o terminal no diretório de "programa_completo.gleam"
    2. Utiliza o comando "sgleam -i programa_completo.gleam"
       obs. utilize ./ ou .\ à depender do OS e do path que está o sgleam
    3. Determine os eventos, ativos e ademais
    4. Chame uma função e coloque as entradas corretas
###### Passos TEST:
    1. Abra o diretório de "programa_completo.gleam" ou, no caso dos arquivos modularizados o diretório de um arguivo com _test
    2. Rode no terminal "sgleam -t <arquivo>.gleam"

### Análise do projeto:
O projeto foi desenvolvido com o objetivo de representar uma estrutura hierárquica de uma rede e seus respectivos eventos de segurança. A utilização de tipos personalizados permite organizar os dados em diferentes níveis, sendo a Rede composta por Setores, os Setores compostos por Ativos e os Ativos compostos por Eventos.

As funcionalidades de busca utilizam essa estrutura para localizar informações específicas dentro da hierarquia, como eventos e ativos, além de realizar verificações relacionadas à segurança da rede. Já as funções de processamento recebem os dados necessários e realizam operações sobre eles, produzindo novas informações a partir dos eventos monitorados.

A utilização de listas e funções recursivas é fundamental para percorrer os diferentes níveis da hierarquia. Dessa forma, o sistema consegue analisar conjuntos de dados sem depender de estruturas imperativas de repetição, mantendo a proposta de programação funcional utilizada no projeto.

Além disso, os tipos soma utilizados em TipoEvento, Severidade e StatusEvento permitem representar diferentes possibilidades para cada evento, tornando a estrutura dos dados mais organizada e permitindo que as funções tratem cada situação de acordo com sua classificação.

### Especificação: 
O sistema deve permitir representar uma rede composta por setores, ativos e eventos de segurança. Cada evento deve possuir um identificador, endereço IP, tipo, severidade, quantidade de tentativas e status.

As funções de busca devem permitir localizar eventos e ativos por meio de seus identificadores, além de identificar setores que apresentem características relacionadas à segurança. A função tentativas_maior_menor deve permitir realizar comparações relacionadas à quantidade de tentativas registradas nos eventos.

As funções de processamento devem realizar operações sobre os dados fornecidos, incluindo o cálculo do total de invasões, a criação de novos eventos, a classificação de eventos, a aplicação de máscara sobre endereços IP e o cálculo de médias.

Por fim, a função imprime_relatorio deve utilizar os dados processados para apresentar as informações relevantes do monitoramento da rede de forma organizada.

O sistema deve manter a utilização de funções, listas, tipos personalizados e recursão, seguindo os princípios de programação funcional propostos para o trabalho.