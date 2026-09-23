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

### Especificação: 