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


/// Funcoes auxiliar de busca_setor_perigoso: busca.gleam
/// extrai_eventos recebe a lista de ativos associados à um setor
/// de cada ativo extrai a lista de eventos e manda para acumula_eventos_perigosos
/// que vai acumular a quantidade de eventos de periculosidade alta ou critica
/// Quando o acumula_eventos_perigosos terminar de calcular, a extrai_eventos envia
/// uma nova lista de eventos até acabar os ativos e retorna todo o valor acumulado
/// para a busca_setor_perigoso

/// Recebe os eventos do ativos do setor e verifica quantos destes possuem 
/// periculosidade alta ou critica
pub fn acumula_eventos_perigosos(eventos: List(Eventos), acumulador: Int) {
    case eventos {
        [] -> acumulador
        [Evento(_, _, _, severidade, _, _), ..resto] ->
            
    }
}

/// Recebe uma lista de ativos e extrai a lista de eventos associado à ele
pub fn extrai_eventos(ativos: List(Ativos), acumulador: Int) {
    case ativos {
        [] -> acumulador
        [Ativo(id_ativo, nome, eventos), ..resto] ->
            extrai_eventos(resto, acumula_eventos_perigosos(eventos, 0))
    }
}