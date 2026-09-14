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



/// Busca por ID - F6
/// A busca evento por ID tem como entrada o ID e toda uma lista de eventos. A busca_evento_por_id 
/// varre a lista de eventos em busca do evento com o ID informado, caso não encontre, retorna um erro.
pub fn busca_evento_por_id(eventos: List(Evento), id: Int) -> Result(Evento, String) {
    case eventos {
        [] -> Error("Evento não encontrado")

        [primeiro, ..resto] ->
        case primeiro {
            Evento(id_evento, _, _, _, _, _) if id_evento == id ->
            Ok(primeiro)

            _ ->
            busca_evento_por_id(resto, id)
        }
    }
}


/// Busca por ativo - F9
/// Recebe uma lista de ativos e o ID do ativo que se deseja encontrar. Ao encontrar o ativo, retorna
/// a lista de eventos associado à ele
pub fn busca_ativo_por_id(ativos: Setor, id: Int) -> Ativo {

}


/// Busca por setor mais perigoso - F9 e F4
/// Receba a lista de todos os setores e vasculha qual o setor possui os eventos com maiores periculosidades
/// (severidade alta ou crítica) e indica qual é este setor. Ele vasculha por todos os ativos de um setor
pub fn busca_setor_perigoso(setores: Rede) -> Setor {

}


/// Busca elemento com maior e menor tentativa - F7
/// Procura os dois eventos com maior e menor quantidade de tentativas em uma lista de eventos e os retorna