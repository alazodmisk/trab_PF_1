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
import processamento
import busca_auxiliares

/// -----------------------------------
/// *** AUXILIARES PARA INSTANCIA_EVENTO ***
/// -----------------------------------
//ANÁLISE: Faça uma função que recebe uma lista de ativos e um ativo atualizado, e devolve a lista de ativos atualizada com o ativo atualizado no lugar do ativo antigo.
//TIPOS DE DADOS: A entrada será uma lista de ativos e um ativo atualizado, que serão representados pelos tipos composto *List(Ativo)* e *Ativo*. A saída será a lista de ativos atualizada, que será representada pelo tipo composto *List(Ativo)*.
//ESPECIFICAÇÃO: Recebe uma lista de *ativos* e um *ativo atualizado* e devolve a lista de *ativos* atualizada com o *ativo atualizado* no lugar do *ativo antigo*.
pub fn atualiza_ativos(ativos: List(tipos.Ativo), ativo_atualizado: tipos.Ativo) -> List(tipos.Ativo) {
  case ativos {
    [] -> []
    [primeiro, ..resto] -> {
      case primeiro.id == ativo_atualizado.id {
        True -> [ativo_atualizado, ..resto]
        False -> [primeiro, ..atualiza_ativos(resto, ativo_atualizado)]
      }
    }
  }
}

//ANÁLISE: Faça uma função que recebe uma lista de setores e um setor atualizado, e devolve a lista de setores atualizada com o setor atualizado no lugar do setor antigo.
//TIPOS DE DADOS: A entrada será uma lista de setores e um setor atualizado, que serão representados pelos tipos composto *List(Setor)* e *Setor*. A saída será a lista de setores atualizada, que será representada pelo tipo composto *List(Setor)*.
//ESPECIFICAÇÃO: Recebe uma lista de *setores* e um *setor atualizado* e devolve a lista de *setores* atualizada com o *setor atualizado* no lugar do *setor antigo*.
pub fn atualiza_setores(setores: List(tipos.Setor), setor_atualizado: tipos.Setor) -> List(tipos.Setor) {
  case setores {
    [] -> []
    [primeiro, ..resto] -> {
      case primeiro.id == setor_atualizado.id {
        True -> [setor_atualizado, ..resto]
        False -> [primeiro, ..atualiza_setores(resto, setor_atualizado)]
      }
    }
  }
}

/// -----------------------------------
/// *** AUXILIARES PARA CALCULA_MEDIA ***
/// -----------------------------------
//ANÁLISE: Faça uma função que recebe uma lista de eventos e conta quantos eventos ela tem.
//TIPOS DE DADOS: A entrada será uma: Uma lista de eventos representada por um tipo com autorreferência contendo o tipo composto *Evento*, uma *List(Evento)*.
//A saída será a quantidade de eventos dessa lista, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de eventos *eventos* e conta quantos eventos ela possui.
pub fn conta_eventos(eventos: List(tipos.Evento)) -> Int {
    case eventos {
        [] -> 0
        [__primeiro, ..resto] -> 1 + conta_eventos(resto)
    }
}

//ANÁLISE: Faça uma função que recebe uma lista de eventos e calcula quantas tentativas totais a lista tem.
//TIPOS DE DADOS: A entrada será uma: Uma lista de eventos representada pelo tipo com autorreferência contendo o tipo composto *Evento*, um *List(Evento)*.
//A saída será a quantidade bruta e somada de tentativas de todos os eventos da lista, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de eventos *lst* e calcula todas as tentativas da lista.
pub fn conta_tentativas(lst: List(tipos.Evento)) -> Int {
    case lst {
        [] -> 0
        [primeiro, ..resto] -> primeiro.tentativas + conta_tentativas(resto) 
    }
}

/// -----------------------------------
/// *** AUXILIARES PARA IMPRIME_RELATORIO ***
/// -----------------------------------
//ANÁLISE: Faça uma função que recebe uma lista de setores e calcula a quantidade de eventos com severidade alta ou crítica.
//TIPOS DE DADOS: A entrada será uma: Uma lista de setores representada pelo tipo com autorreferência contendo o tipo composto *Setor*, um *List(Setor)*.
//A saída será a quantidade de eventos com severidade alta ou crítica, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de setores *setores* e calcula a quantidade de eventos com severidade alta ou crítica.
pub fn calcula_eventos_criticos_ou_altos(setores: List(tipos.Setor)) -> Int {
    case setores {
        [] -> 0
        [tipos.Setor(_, _, ativos), ..resto] -> busca_auxiliares.extrai_eventos(ativos, 0) + calcula_eventos_criticos_ou_altos(resto)
    }
}

//ANÁLISE: Faça uma função que recebe uma lista de ativos e calcula a quantidade de tentativas de todos os eventos da lista.
//TIPOS DE DADOS: As entradas serão uma lista de ativos representada pelo tipo com autorreferência contendo o tipo composto *Ativo*, um *List(Ativo)*. 
//A saída será a quantidade de tentativas de todos os eventos da lista, representada pelo tipo primitivo *Int*.
//EPSECIFICAÇÃO: Recebe uma lista de ativos *ativos* e calcula a quantidade de tentativas somada de todos os eventos da lista.
pub fn calcula_tentativas_ativos(ativos: List(tipos.Ativo)) -> Int {
    case ativos {
        [] -> 0
        [primeiro, ..resto] -> processamento.calcula_total_invasoes(primeiro.eventos) + calcula_tentativas_ativos(resto) 
    }
}

//ANÁLISE: Faça uma função que recebe uma lista de setores e calcula a quantidade de tentativas de todos os eventos da lista.
//TIPOS DE DADOS: As entradas serão uma lista de setores representada pelo tipo com autorreferência contendo o tipo composto *Setor*, um *List(Setor)*.
//A saída será a quantidade de tentativas de todos os eventos da lista, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de setores *setores* e calcula a quantidade de tentativas somada de todos os eventos da lista.
pub fn calcula_tentativas_setores(setores: List(tipos.Setor)) -> Int {
    case setores {
        [] -> 0
        [primeiro, ..resto] -> calcula_tentativas_ativos(primeiro.ativos) + calcula_tentativas_setores(resto)
    }
}