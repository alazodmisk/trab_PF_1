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

### Instruções:

### Análise do projeto:

### Especificação: 