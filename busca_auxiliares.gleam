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

/// ANÁLISE: É necessário fazer uma função que recebe uma lista de eventos, varre a lista de eventos e
/// contabiliza a quantidade de eventos com severidade alta ou crítica, devolvendo este valor que foi contabilizado.
/// 
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de eventos [(List(Evento)] e um acumulador do tipo primitivo *Int*.
/// A saída será a quantidade de eventos com severidade alta ou crítica, representada pelo tipo primitivo *Int*.
/// 
/// ESPECIFICAÇÃO: Recebe uma lista de eventos e um acumulador inicialmente em 0, varre a lista de eventos e acumula a
/// quantidade de eventos com severidade alta ou crítica, devolvendo o valor acumulado.
pub fn acumula_eventos_perigosos(eventos: List(Evento), acumulador: Int) {
    case eventos {
        [] -> acumulador
        [Evento(_, _, _, severidade, _, _), ..resto] ->
            case severidade {
                tipos.Alta -> acumula_eventos_perigosos(resto, acumulador + 1)
                tipos.Critica -> acumula_eventos_perigosos(resto, acumulador + 1)
                _ -> acumula_eventos_perigosos(resto, acumulador)
            }
    }
}

/// ANÁLISE: É necessário fazer uma função que recebe uma lista de ativos proveniente da função busca_setor_perigoso para
/// enfim retornar a quantidade de eventos com severidade alta ou crítica de toda a lista de ativos.
/// 
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de ativos [(List(Ativo)] e um acumulador do tipo primitivo *Int*.
/// A saída será a quantidade de eventos com severidade alta ou crítica, representada pelo tipo primitivo *Int*.
///
/// ESPECIFICAÇÃO: Recebe uma lista de ativos e um acumulador inicialmente em 0, varre a lista de ativos e para cada ativo extrai
/// a lista de eventos associado à ele, envia esta lista de eventos para a função acumula_eventos_perigosos, que contabiliza a quantidade 
/// de eventos com severidade alta ou crítica e devolve o valor acumulado. Desse modo, a extrai eventos acumula esse valor de tentativas
/// de todos os ativos e devolve o valor final.
pub fn extrai_eventos(ativos: List(Ativo), acumulador: Int) {
    case ativos {
        [] -> acumulador
        [Ativo(id_ativo, nome, eventos), ..resto] ->
            extrai_eventos(resto, acumulador + acumula_eventos_perigosos(eventos, 0))
    }
}