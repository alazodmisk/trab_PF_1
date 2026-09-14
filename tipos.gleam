// Tipos auxiliares
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

// Tipos pertencentes à hierarquia
pub type Evento {
    Evento(id: Int, origem: String, tipo: TipoEvento, severidade: Severidade, tentativas: Int, status: StatusEvento)
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

//teste 