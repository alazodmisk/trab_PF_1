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
/// A busca evento por ID tem como entrada o ID e toda uma lista de eventos. A busca_evento_por_id 
/// varre a lista de eventos em busca do evento com o ID informado, caso não encontre, retorna um erro.
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
/// Recebe uma lista de ativos e o ID do ativo que se deseja encontrar. Ao encontrar o ativo, retorna
/// a lista de eventos associado à ele
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
/// Receba a lista de todos os setores e vasculha qual o setor possui os eventos com maiores periculosidades
/// (severidade alta ou crítica) e indica qual é este setor pelo seu id. Ele vasculha por todos os ativos de um setor
/// vai ser necessário usar funções auxiliares
pub fn busca_setor_perigoso(setores: List(Setor), id_setor_mais_perigoso: Setor, qtd_eventos_perigosos: Int) -> Int {
    case setores {
        [] -> id_setor_mais_perigoso
        [Setor(id_setor, nome, ativos), ..resto] ->
            let valor_acumulado = busca_auxiliares.extrai_eventos(ativos)
            case qtd_eventos_perigosos < valor_acumulado {
                True -> busca_setor_perigoso(..resto, id_setor, valor_acumulado)
                False -> busca_setor_perigoso(..resto, id_setor_mais_perigoso, qtd_eventos_perigosos)
            }            
    }
}


/// Busca elemento com maior e menor tentativa - F7
/// Procura os dois eventos com maior e menor quantidade de tentativas em uma lista de eventos e os retorna