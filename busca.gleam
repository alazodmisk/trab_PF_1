import tipos.{
  type Ativo,
  Ativo,
  type Evento,
  Evento,
  type Setor,
  Setor,
  type Rede,
  Rede,
}
import busca_auxiliares


/// Busca por ID - F6
/// ANÁLISE: É necessário fazer uma função que encontre um evento em uma lista de eventos.
/// 
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de eventos [List(Evento)] e um ID do tipo primitivo *Int*. 
/// A saída será o evento encontrado, representado pelo tipo composto *Evento* ou uma mensagem de erro, 
/// representada pelo tipo primitivo *String*.w
/// 
/// ESPECIFICAÇÃO: Recebe uma lista de eventos e um ID, varre a lista de eventos em busca do evento com o 
/// ID informado, caso não encontre, retorna um erro.
pub fn busca_evento_por_id(eventos: List(Evento), id: Int) -> Result(Evento, String) {
    case eventos {
        [] -> Error("Evento não encontrado")

        [primeiro, ..resto] ->
        case primeiro {
            Evento(id_evento, ..) if id_evento == id ->
            Ok(primeiro)

            _ ->
            busca_evento_por_id(resto, id)
        }
    }
}


/// Busca por ativo por id - F9
/// ANÁLISE: É necessário fazer uma função que encontre um ativo em uma lista de ativos e retorne a lista de eventos associado à ele.
///
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de ativos [List(Ativo)] e um ID do tipo primitivo *Int*.
/// A saída será a lista de eventos do ativo encontrado, representada pelo tipo composto *List(Evento)*. 
/// Caso não encontre o ativo, retorna uma lista vazia.
/// 
/// ESPECIFICAÇÃO: Recebe uma lista de ativos e um ID, varre a lista de ativos em busca do ativo com o
/// ID informado, caso encontre, retorna a lista de eventos associado à ele, caso não encontre, retorna uma lista vazia.
pub fn busca_ativo_por_id(ativos: List(Ativo), id: Int) -> List(Evento) {
    case ativos {
        [] -> []

        [Ativo(id_ativo, nome, eventos), ..resto] ->
            case id_ativo == id {
                True -> eventos
                False -> busca_ativo_por_id(resto, id)
            }
    }
}


/// Busca por setor mais perigoso - F9, F8 e F4
/// ANÁLISE: É necessário fazer uma função que encontre o setor mais perigoso em uma lista de setores.
///
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de setores [List(Setor)], um ID do setor mais perigoso do tipo primitivo *Int* e a 
/// quantidade de eventos perigosos do tipo primitivo *Int*. A saída será o ID do setor mais perigoso, 
/// representado pelo tipo primitivo *Int*.
/// 
/// ESPECIFICAÇÃO: Recebe uma lista de setores, varre a lista de setores em busca do setor com a maior quantidade de eventos
/// perigosos (severidade alta ou crítica), caso encontre, retorna o ID do setor mais perigoso, caso não encontre, retorna 0.
pub fn busca_setor_perigoso(setores: List(Setor), id_setor_mais_perigoso: Int, qtd_eventos_perigosos: Int) -> Int {
    case setores {
        [] -> id_setor_mais_perigoso
        [Setor(id_setor, nome, ativos), ..resto] ->
            case qtd_eventos_perigosos < busca_auxiliares.extrai_eventos(ativos, 0) {
                True -> busca_setor_perigoso(resto, id_setor, busca_auxiliares.extrai_eventos(ativos, 0))
                False -> busca_setor_perigoso(resto, id_setor_mais_perigoso, qtd_eventos_perigosos)
            }            
    }
}


/// Busca elemento com maior e menor tentativa - F7
/// Recebe uma lista de eventos e retorna o evento com maior e menor quantidade de tentativas
/// Caso a lista esteja vazia, retorna uma lista vazia
/// 
/// ANÁLISE: É necessário fazer uma função que encontre o evento com maior e menor quantidade de tentativas em uma lista de eventos.
/// 
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de eventos [List(Evento)], um evento com a maior quantidade de tentativas do tipo composto *Evento* 
/// e um evento com a menor quantidade de tentativas do tipo composto *Evento*. A saída será uma lista com o evento com maior e menor
/// quantidade de tentativas, representada pelo tipo composto *List(Evento)*. Caso a lista esteja vazia, retorna a lista vazia.
pub fn tentativas_maior_menor(eventos: List(Evento), maior: Evento, menor: Evento) -> List(Evento) {
    case eventos {
        [] -> [maior, menor]
        [Evento(id, ip, tipo, severidade, tentativas, status), ..resto] ->
            case tentativas > maior.tentativas { 
                True -> case tentativas < menor.tentativas { 
                    True -> tentativas_maior_menor(resto, Evento(id, ip, tipo, severidade, tentativas, status), Evento(id, ip, tipo, severidade, tentativas, status))
                    False -> tentativas_maior_menor(resto, Evento(id, ip, tipo, severidade, tentativas, status), menor) 
                } 
                False -> case tentativas < menor.tentativas { 
                    True -> tentativas_maior_menor(resto, maior, Evento(id, ip, tipo, severidade, tentativas, status)) 
                    False -> tentativas_maior_menor(resto, maior, menor) 
                } 
            }
    }
}