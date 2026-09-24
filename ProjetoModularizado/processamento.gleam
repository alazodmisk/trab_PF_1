import tipos
import busca
import busca_auxiliares
import gleam/int

/// Calcula total de invasões - F3
/// A partir da lista de eventos de um ativo, calcula o total de tentativas acumulado
//ANÁLISE: Faça uma função que recebe uma lista de eventos e devolve a soma de tentativas de todos os eventos da lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada por List(Evento). A saída será a quantidade de 
//total de tentativas, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de *eventos* e devolve a soma de tentativas de todos os eventos da lista.
pub fn calcula_total_invasoes(eventos: List(tipos.Evento)) -> Int {
    case eventos {
        [] -> 0
        [primeiro, ..resto] -> primeiro.tentativas + calcula_total_invasoes(resto)
    }
}

/// Instancia evento - F1
//ANÁLISE: Faça uma função que recebe os parâmetros de um evento, instancia o evento e o adiciona à lista de eventos do ativo, que é adicionado à lista de ativos do setor, que é adicionado à lista de setores da rede.
//TIPOS DE DADOS: As entradas serão nove: Um Id que será representado pelo tipo primitivo *Int*, um IP que será representada pelo tipo primitivo *String*, um tipo de evento que será representado pelo tipo enumerado *TipoEvento*, 
//uma severidade que será representada pelo tipo enumerado *Severidade*, 
//uma quantidade de tentativas que será representada pelo tipo primitivo *Int*, um status do evento que será representado pelo tipo *StatusEvento* e um ativo que será representado pelo tipo composto *Ativo*, 
//um setor que será representado pelo tipo composto *Setor* e uma rede que será representada pelo tipo composto *Rede*.
//A saída será o ativo atualizado, que será representado pelo tipo *Ativo*.
//ESPECIFICAÇÃO: Recebe os atributos de um evento, um ativo, um setor e uma rede e instancia o evento e o adiciona à lista de eventos do ativo, que é adicionado à lista de ativos do setor, que é adicionado à lista de setores da rede, 
//devolvendo a rede atualizada.
pub fn instancia_evento(id: Int, ip: String, tipo: tipos.TipoEvento, severidade: tipos.Severidade, tentativas: Int, status: tipos.StatusEvento, ativo: tipos.Ativo, setor: tipos.Setor, rede: tipos.Rede) -> tipos.Rede {
    let evento = tipos.Evento(id, ip, tipo, severidade, tentativas, status)
    let novo_ativo = tipos.Ativo(ativo.id, ativo.nome, [evento, ..ativo.eventos])
    let lista_ativos_atualizada = atualiza_ativos(setor.ativos, novo_ativo)
    let novo_setor = tipos.Setor(setor.id, setor.nome, lista_ativos_atualizada)
    let lista_setores_atualizada = atualiza_setores(rede.setores, novo_setor)
    tipos.Rede(rede.id, rede.nome, lista_setores_atualizada)
}

/// Classifica evento - F2
/// Classifica o grau de periculosidade de um evento recém instanciado
//ANÁLISE: Faça uma função que recebe um evento e devolve o mesmo evento com a severidade atualizada de acordo com a quantidade de tentativas.
//TIPOS DE DADOS: A entrada será um evento, que será representado pelo tipo composto *Evento*. A saída será o mesmo evento com a severidade atualizada, 
//que será representado pelo tipo composto *Evento*.
//ESPECIFICAÇÃO: Recebe um evento e devolve o mesmo evento com a severidade atualizada de acordo com a quantidade de tentativas.
pub fn classifica_evento(evento: tipos.Evento) -> tipos.Evento {
    case evento.tentativas == 0 {
        True -> tipos.Evento(evento.id, evento.ip, evento.tipo, tipos.Nula, evento.tentativas, evento.status)
        False -> case evento.tentativas < 3 {
            True -> tipos.Evento(evento.id, evento.ip, evento.tipo, tipos.Baixa, evento.tentativas, evento.status)
            False -> case evento.tentativas < 5 {
                True -> tipos.Evento(evento.id, evento.ip, evento.tipo, tipos.Media, evento.tentativas, evento.status)
                False -> case evento.tentativas < 10 {
                    True -> tipos.Evento(evento.id, evento.ip, evento.tipo, tipos.Alta, evento.tentativas, evento.status)
                    False -> tipos.Evento(evento.id, evento.ip, evento.tipo, tipos.Critica, evento.tentativas, evento.status)
                }
            }
        } 
    }
}

/// Mascara IP - F5
/// Recebe uma lista de eventos e devolve a mesma lista porém sem o IP (0 ou Nulo)
//ANÁLISE: Faça uma função que recebe uma lista de eventos e devolve a mesma lista porém com os IPs dos eventos escrito "mascarado" no lugar.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada pelo tipo composto *List(Evento)*. A saída será a mesma lista de eventos porém com os IPs dos eventos escrito "mascarado" no lugar, que será representada pelo tipo composto *List(Evento)*.
//ESPECIFICAÇÃO: Recebe uma lista de eventos e devolve a mesma lista porém com os IPs dos eventos escrito "mascarado" no lugar.
pub fn mascara_ip(eventos: List(tipos.Evento)) -> List(tipos.Evento) {
    case eventos {
        [] -> []
        [primeiro, ..resto] -> [tipos.Evento(primeiro.id, "mascarado", primeiro.tipo, primeiro.severidade, primeiro.tentativas, primeiro.status), ..mascara_ip(resto)]
    }
}

/// Calcula média - F8
/// Calcula a média de quantidade de tentativas em uma lista de eventos.
//ANÁLISE: Faça uma função que receba uma lista de eventos e calcule a quantidade média de tentativas dessa lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada pelo tipo composto *List(Evento)*. A saída será a quantidade média de tentativas, que será representada pelo tipo primitivo *Float*.
//ESPECIFICAÇÃO: Recebe uma lista de *eventos* e devolve a quantidade média de tentativas.
pub fn calcula_media(eventos: List(tipos.Evento)) -> Float {
    let quantidade_eventos = int.to_float(conta_eventos(eventos))
    let quantidade_tentativas = int.to_float(conta_tentativas(eventos))
    quantidade_tentativas /. quantidade_eventos
}

/// Imprime relatório - F10
/// Imprime três indicadores do sistema em uma string
//ANÁLISE: Faça uma função que receba uma rede e devolva uma string com três indicadores do sistema: o setor mais perigoso, a quantidade de eventos com severidade crítica ou alta,
//e a quantidade de tentativas de todos os eventos da rede.
//TIPOS DE DADOS: A entrada será uma rede, que será representada pelo tipo composto *Rede*. A saída será uma string, que será representada pelo tipo primitivo *String*.
//ESPECIFICAÇÃO: Recebe uma *rede* e devolve uma string com três indicadores do sistema.
pub fn imprime_relatorio(rede: tipos.Rede) -> String {
    let setor_mais_perigoso = busca.busca_setor_perigoso(rede.setores, 0, 0) 
    let quantidade_eventos_criticos_ou_altos = calcula_eventos_criticos_ou_altos(rede.setores)
    let quantidade_tentativas_rede = calcula_tentativas_setores(rede.setores)
    "Setor mais perigoso: " <> int.to_string(setor_mais_perigoso) <> ", Quantidade de eventos críticos ou altos: " <> int.to_string(quantidade_eventos_criticos_ou_altos) <> ", Quantidade de tentativas da rede: " <> int.to_string(quantidade_tentativas_rede)
}

/// -----------------------------------
/// *** FUNÇÕES AUXILIARES DE PROCESSAMENTO ***
/// -----------------------------------

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
        [primeiro, ..resto] -> calcula_total_invasoes(primeiro.eventos) + calcula_tentativas_ativos(resto) 
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