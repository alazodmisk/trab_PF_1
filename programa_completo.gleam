import sgleam/check
import gleam/int

/// --------------------------------
/// *** TIPOS ***
/// --------------------------------

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



/// -----------------------------------
/// *** FUNÇÕES AUXILIARES DE BUSCA ***
/// -----------------------------------


/// ANÁLISE: É necessário fazer uma função que recebe uma lista de eventos, varre a lista de eventos e
/// contabiliza a quantidade de eventos com severidade alta ou crítica, devolvendo este valor que foi contabilizado.
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de eventos [(List(Evento)] e um acumulador do tipo primitivo *Int*.
/// A saída será a quantidade de eventos com severidade alta ou crítica, representada pelo tipo primitivo *Int*.
/// ESPECIFICAÇÃO: Recebe uma lista de eventos e um acumulador inicialmente em 0, varre a lista de eventos e acumula a
/// quantidade de eventos com severidade alta ou crítica, devolvendo o valor acumulado.
pub fn acumula_eventos_perigosos(eventos: List(Evento), acumulador: Int) {
    case eventos {
        [] -> acumulador
        [Evento(_, _, _, severidade, _, _), ..resto] ->
            case severidade {
                Alta -> acumula_eventos_perigosos(resto, acumulador + 1)
                Critica -> acumula_eventos_perigosos(resto, acumulador + 1)
                _ -> acumula_eventos_perigosos(resto, acumulador)
            }
    }
}

/// ANÁLISE: É necessário fazer uma função que recebe uma lista de ativos proveniente da função busca_setor_perigoso para
/// enfim retornar a quantidade de eventos com severidade alta ou crítica de toda a lista de ativos.
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de ativos [(List(Ativo)] e um acumulador do tipo primitivo *Int*.
/// A saída será a quantidade de eventos com severidade alta ou crítica, representada pelo tipo primitivo *Int*.
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



/// -----------------------------------
/// *** FUNÇÕES DE BUSCA ***
/// -----------------------------------


/// Busca por ID - F6
/// ANÁLISE: É necessário fazer uma função que encontre um evento em uma lista de eventos.
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de eventos [List(Evento)] e um ID do tipo primitivo *Int*. 
/// A saída será o evento encontrado, representado pelo tipo composto *Evento* ou uma mensagem de erro, 
/// representada pelo tipo primitivo *String*.
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
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de ativos [List(Ativo)] e um ID do tipo primitivo *Int*.
/// A saída será a lista de eventos do ativo encontrado, representada pelo tipo composto *List(Evento)*. 
/// Caso não encontre o ativo, retorna uma lista vazia.
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
/// TIPOS DE DADOS ENVOLVIDOS: Uma lista de setores [List(Setor)], um ID do setor mais perigoso do tipo primitivo *Int* e a 
/// quantidade de eventos perigosos do tipo primitivo *Int*. A saída será o ID do setor mais perigoso, 
/// representado pelo tipo primitivo *Int*.
/// ESPECIFICAÇÃO: Recebe uma lista de setores, varre a lista de setores em busca do setor com a maior quantidade de eventos
/// perigosos (severidade alta ou crítica), caso encontre, retorna o ID do setor mais perigoso, caso não encontre, retorna 0.
pub fn busca_setor_perigoso(setores: List(Setor), id_setor_mais_perigoso: Int, qtd_eventos_perigosos: Int) -> Int {
    case setores {
        [] -> id_setor_mais_perigoso
        [Setor(id_setor, nome, ativos), ..resto] ->
            case qtd_eventos_perigosos < extrai_eventos(ativos, 0) {
                True -> busca_setor_perigoso(resto, id_setor, extrai_eventos(ativos, 0))
                False -> busca_setor_perigoso(resto, id_setor_mais_perigoso, qtd_eventos_perigosos)
            }            
    }
}


/// Busca elemento com maior e menor tentativa - F7
/// ANÁLISE: É necessário fazer uma função que encontre o evento com maior e menor quantidade de tentativas em uma lista de eventos.
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



/// -----------------------------------
/// *** EXAMPLES BUSCA***
/// -----------------------------------


// Check da funcao: busca_evento_por_id
pub fn busca_evento_por_id_examples() {
    let evento1 =Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)
    let evento2 =Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)
    let evento3 = Evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido)

    check.eq(busca_evento_por_id([evento1, evento2, evento3], 1),Ok(evento1))
    check.eq(busca_evento_por_id([evento1, evento2, evento3], 2),Ok(evento2))
    check.eq(busca_evento_por_id([evento1, evento2, evento3], 3),Ok(evento3))
    check.eq(busca_evento_por_id([evento1, evento2, evento3], 99),Error("Evento não encontrado"))
    check.eq(busca_evento_por_id([], 1),Error("Evento não encontrado"))
}

// Check da funcao: busca_ativo_por_id
pub fn busca_ativo_por_id_examples() {
    let evento1 =Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)
    let evento2 =Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)
    let evento3 =Evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido)

    let ativo1 =Ativo(1, "Servidor 1", [evento1, evento2])
    let ativo2 =Ativo(2, "Servidor 2", [evento3])
    let ativo3 =Ativo(3, "Servidor 3", [])

    check.eq(busca_ativo_por_id([ativo1, ativo2, ativo3], 1),[evento1, evento2])
    check.eq(busca_ativo_por_id([ativo1, ativo2, ativo3], 2),[evento3])
    check.eq(busca_ativo_por_id([ativo1, ativo2, ativo3], 3),[])
    check.eq(busca_ativo_por_id([ativo1, ativo2, ativo3], 99),[])
    check.eq(busca_ativo_por_id([], 1),[])
}

// Check da funcao: busca_setor_mais_perigoso
pub fn busca_setor_perigoso_examples() {
    let evento1 = Evento(1,"Computador 1",Malware,Alta,3,EmAnalise)
    let evento2 = Evento(2,"Computador 2",AcessoSuspeito,Media,1,Desconhecido)
    let evento3 = Evento(3,"Computador 3",TentativaDeLogin,Critica,5,Resolvido)
    let evento4 = Evento(4,"Computador 4",Malware,Baixa,2,EmAnalise)

    let ativo1 = Ativo(1, "Ativo 1", [evento1, evento2])
    let ativo2 = Ativo(2, "Ativo 2", [evento1, evento3])
    let ativo3 = Ativo(3, "Ativo 3", [evento4])

    let setor1 = Setor(1, "Setor 1", [ativo1])
    let setor2 = Setor(2, "Setor 2", [ativo2])
    let setor3 = Setor(3, "Setor 3", [ativo3])

    check.eq(busca_setor_perigoso([setor1, setor2, setor3], 0, 0),2)
    check.eq(busca_setor_perigoso([setor1, setor2], 0, 0),2)
    check.eq(busca_setor_perigoso([setor1], 0, 0),1)
    check.eq(busca_setor_perigoso([], 0, 0),0)
}

// Check das auxiliares
pub fn acumula_eventos_perigosos_examples() {
    let evento1 =Evento(1,"Computador 1",Malware,Alta,3,EmAnalise)
    let evento2 =Evento(2,"Computador 2",AcessoSuspeito,Media,1,Desconhecido)
    let evento3 =Evento(3,"Computador 3",TentativaDeLogin,Critica,5,Resolvido)

    check.eq(acumula_eventos_perigosos([evento1, evento2, evento3],0),2)
    check.eq(acumula_eventos_perigosos([evento2],0),0)
    check.eq(acumula_eventos_perigosos([],0),0)
    check.eq(acumula_eventos_perigosos([evento1],0),1)
}

pub fn extrai_eventos_examples() {
    let evento1 =Evento(1,"Computador 1",Malware,Alta,3,EmAnalise)
    let evento2 =Evento(2,"Computador 2",AcessoSuspeito,Media,1,Desconhecido)
    let evento3 =Evento(3,"Computador 3",TentativaDeLogin,Critica,5,Resolvido)
    let evento4 =Evento(4,"Computador 4",Malware,Baixa,2,EmAnalise)

    let ativo1 =Ativo(1, "Ativo 1", [evento1, evento2])
    let ativo2 =Ativo(2, "Ativo 2", [evento3, evento4])
    let ativo3 =Ativo(3, "Ativo 3", [])

    check.eq(extrai_eventos([ativo1, ativo2], 0),2)
    check.eq(extrai_eventos([ativo1], 0),1)
    check.eq(extrai_eventos([ativo2], 0),1)
    check.eq(extrai_eventos([ativo3], 0),0)
    check.eq(extrai_eventos([], 0),0)
    check.eq(extrai_eventos([ativo1, ativo2, ativo3], 0),2)
}

// Check da funcao: tentativas_maior_menor
pub fn tentativas_maior_menor_examples() {
  let evento1 = Evento(1, "192.168.0.1", Malware, Alta, 10, EmAnalise)
  let evento2 = Evento(2, "192.168.0.2", AcessoSuspeito, Media, 3, Desconhecido)
  let evento3 = Evento(3, "192.168.0.3", AlteracaoDeDados, Baixa, 7, Resolvido)

  check.eq(tentativas_maior_menor([evento1, evento2, evento3],evento1,evento1),[evento1, evento2])
}



/// -----------------------------------
/// *** PROCESSAMENTO ***
/// -----------------------------------


/// Calcula total de invasões - F3
/// A partir da lista de eventos de um ativo, calcula o total de tentativas acumulado
//ANÁLISE: Faça uma função que recebe uma lista de eventos e devolve a soma de tentativas de todos os eventos da lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada por List(Evento). A saída será a quantidade de 
//total de tentativas, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de *eventos* e devolve a soma de tentativas de todos os eventos da lista.
pub fn calcula_total_invasoes(eventos: List(Evento)) -> Int {
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
pub fn instancia_evento(id: Int, ip: String, tipo: TipoEvento, severidade: Severidade, tentativas: Int, status: StatusEvento, ativo: Ativo, setor: Setor, rede: Rede) -> Rede {
    let evento = Evento(id, ip, tipo, severidade, tentativas, status)
    let novo_ativo = Ativo(ativo.id, ativo.nome, [evento, ..ativo.eventos])
    let lista_ativos_atualizada = atualiza_ativos(setor.ativos, novo_ativo)
    let novo_setor = Setor(setor.id, setor.nome, lista_ativos_atualizada)
    let lista_setores_atualizada = atualiza_setores(rede.setores, novo_setor)
    Rede(rede.id, rede.nome, lista_setores_atualizada)
}

/// Classifica evento - F2
/// Classifica o grau de periculosidade de um evento recém instanciado
//ANÁLISE: Faça uma função que recebe um evento e devolve o mesmo evento com a severidade atualizada de acordo com a quantidade de tentativas.
//TIPOS DE DADOS: A entrada será um evento, que será representado pelo tipo composto *Evento*. A saída será o mesmo evento com a severidade atualizada, 
//que será representado pelo tipo composto *Evento*.
//ESPECIFICAÇÃO: Recebe um evento e devolve o mesmo evento com a severidade atualizada de acordo com a quantidade de tentativas.
pub fn classifica_evento(evento: Evento) -> Evento {
    case evento.tentativas == 0 {
        True -> Evento(evento.id, evento.ip, evento.tipo, Nula, evento.tentativas, evento.status)
        False -> case evento.tentativas < 3 {
            True -> Evento(evento.id, evento.ip, evento.tipo, Baixa, evento.tentativas, evento.status)
            False -> case evento.tentativas < 5 {
                True -> Evento(evento.id, evento.ip, evento.tipo, Media, evento.tentativas, evento.status)
                False -> case evento.tentativas < 10 {
                    True -> Evento(evento.id, evento.ip, evento.tipo, Alta, evento.tentativas, evento.status)
                    False -> Evento(evento.id, evento.ip, evento.tipo, Critica, evento.tentativas, evento.status)
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
pub fn mascara_ip(eventos: List(Evento)) -> List(Evento) {
    case eventos {
        [] -> []
        [primeiro, ..resto] -> [Evento(primeiro.id, "mascarado", primeiro.tipo, primeiro.severidade, primeiro.tentativas, primeiro.status), ..mascara_ip(resto)]
    }
}


/// Calcula média - F8
/// Calcula a média de quantidade de tentativas em uma lista de eventos.
//ANÁLISE: Faça uma função que receba uma lista de eventos e calcule a quantidade média de tentativas dessa lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada pelo tipo composto *List(Evento)*. A saída será a quantidade média de tentativas, que será representada pelo tipo primitivo *Float*.
//ESPECIFICAÇÃO: Recebe uma lista de *eventos* e devolve a quantidade média de tentativas.
pub fn calcula_media(eventos: List(Evento)) -> Float {
    let quantidade_eventos = int.to_float(conta_eventos(eventos))
    let quantidade_tentativas = int.to_float(conta_tentativas(eventos))
    quantidade_tentativas /. quantidade_eventos
}





/// Imprime relatório - F10
/// Imprime três indicadores do sistema em uma string
//ANÁLISE: Faça uma função que receba uma rede e devolva uma string com três indicadores do sistema: o setor mais perigoso, a quantidade de eventos com severidade crítica e a quantidade de eventos com severidade alta.
//TIPOS DE DADOS: A entrada será uma rede, que será representada pelo tipo composto *Rede*. A saída será uma string, que será representada pelo tipo primitivo *String*.
//ESPECIFICAÇÃO: Recebe uma *rede* e devolve uma string com três indicadores do sistema.
//pub fn imprime_relatorio(rede: Rede) -> String {
    //todo 
//}



/// -----------------------------------
/// *** FUNÇÕES AUXILIARES DE PROCESSAMENTO ***
/// -----------------------------------

/// *** AUXILIARES PARA INSTANCIA_EVENTO ***

//ANÁLISE:
//TIPOS DE DADOS:
//ESPECIFICAÇÃO:
pub fn atualiza_ativos(ativos: List(Ativo), ativo_atualizado: Ativo) -> List(Ativo) {
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
pub fn atualiza_ativos_examples() {
    let ativo1 = Ativo(1, "Ativo 1", [])
    let ativo2 = Ativo(2, "Ativo 2", [])
    let ativo3 = Ativo(3, "Ativo 3", [])
    let ativo_atualizado = Ativo(2, "Ativo 2 Atualizado", [])
    check.eq(atualiza_ativos([ativo1, ativo2, ativo3], ativo_atualizado), [ativo1, ativo_atualizado, ativo3])
    check.eq(atualiza_ativos([ativo1, ativo2], ativo_atualizado), [ativo1, ativo_atualizado])
    check.eq(atualiza_ativos([ativo1], ativo_atualizado), [ativo1])
    check.eq(atualiza_ativos([], ativo_atualizado), [])
}

//ANÁLISE:
//TIPOS DE DADOS:
//ESPECIFICAÇÃO:
pub fn atualiza_setores(setores: List(Setor), setor_atualizado: Setor) -> List(Setor) {
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
pub fn atualiza_setores_examples() {
    let setor1 = Setor(1, "Setor 1", [])
    let setor2 = Setor(2, "Setor 2", [])
    let setor3 = Setor(3, "Setor 3", [])
    let setor_atualizado = Setor(2, "Setor 2 Atualizado", [])
    check.eq(atualiza_setores([setor1, setor2, setor3], setor_atualizado), [setor1, setor_atualizado, setor3])
    check.eq(atualiza_setores([setor1, setor2], setor_atualizado), [setor1, setor_atualizado])
    check.eq(atualiza_setores([setor1], setor_atualizado), [setor1])
    check.eq(atualiza_setores([], setor_atualizado), [])
}


/// *** AUXILIARES PARA CALCULA_MEDIA ***

//ANÁLISE: Faça uma função que recebe uma lista de eventos e conta quantos eventos ela tem.
//TIPOS DE DADOS: A entrada será uma: Uma lista de eventos representada por um tipo com autorreferência contendo o tipo composto *Evento*, uma *List(Evento)*.
//A saída será a quantidade de eventos dessa lista, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de eventos *eventos* e conta quantos eventos ela possui.
pub fn conta_eventos(eventos: List(Evento)) -> Int {
    case eventos {
        [] -> 0
        [__primeiro, ..resto] -> 1 + conta_eventos(resto)
    }
}
pub fn conta_eventos_examples() {
    check.eq(conta_eventos([]), 0)
    let evento1 = Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)
    check.eq(conta_eventos([evento1]), 1)       
    check.eq(conta_eventos([evento1, Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)]), 2)
}

//ANÁLISE: Faça uma função que recebe uma lista de eventos e calcula quantas tentativas totais a lista tem.
//TIPOS DE DADOS: A entrada será uma: Uma lista de eventos representada pelo tipo com autorreferência contendo o tipo composto *Evento*, um *List(Evento)*.
//A saída será a quantidade bruta e somada de tentativas de todos os eventos da lista, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de eventos *lst* e calcula todas as tentativas da lista.
pub fn conta_tentativas(lst: List(Evento)) -> Int {
    case lst {
        [] -> 0
        [primeiro, ..resto] -> primeiro.tentativas + conta_tentativas(resto) 
    }
}
pub fn conta_tentativas_examples() {
    let evento1 = Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)
    let evento2 = Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)
    let evento3 = Evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido)
    check.eq(conta_tentativas([evento1, evento2, evento3]), 9)
    check.eq(conta_tentativas([evento1]), 3)
    check.eq(conta_tentativas([]), 0)
}



/// -----------------------------------
/// *** EXAMPLES PROCESSAMENTO***
/// -----------------------------------

//EXEMPLOS F3: calcula_total_invasoes
pub fn calcula_total_invasoes_examples() {
    let evento1 =Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)
    let evento2 =Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)
    let evento3 = Evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido)
    check.eq(calcula_total_invasoes([evento1, evento2, evento3]),9)
    check.eq(calcula_total_invasoes([evento1]),3)
    check.eq(calcula_total_invasoes([]),0)
}

//EXEMPLOS F1: instancia_evento
pub fn instancia_evento_examples() {
    let evento1 =Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)
    let ativo1 =Ativo(1, "Ativo 1", [evento1])
    let setor1 =Setor(1, "Setor 1", [ativo1])
    let rede1 =Rede(1, "Rede 1", [setor1])
    check.eq(instancia_evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido, ativo1, setor1, rede1), Rede(1, "Rede 1", [Setor(1, "Setor 1", [Ativo(1, "Ativo 1", [Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido), Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)])])]))
    check.eq(instancia_evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido, ativo1, setor1, rede1), Rede(1, "Rede 1", [Setor(1, "Setor 1", [Ativo(1, "Ativo 1", [Evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido), Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)])])]))
    check.eq(instancia_evento(4, "Computador 4", Malware, Alta, 3, EmAnalise, ativo1, setor1, rede1), Rede(1, "Rede 1", [Setor(1, "Setor 1", [Ativo(1, "Ativo 1", [Evento(4, "Computador 4", Malware, Alta, 3, EmAnalise), Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)])])]))
} 

//EXEMPLOS F2: classifica_evento
pub fn classifica_evento_examples() {
    check.eq(classifica_evento(Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)), Evento(1, "Computador 1", Malware, Media, 3, EmAnalise))
    check.eq(classifica_evento(Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)), Evento(2, "Computador 2", AcessoSuspeito, Baixa, 1, Desconhecido))
    check.eq(classifica_evento(Evento(3, "Computador 3", TentativaDeLogin, Baixa, 5, Resolvido)), Evento(3, "Computador 3", TentativaDeLogin, Alta, 5, Resolvido))
}

//EXEMPLOS F5
pub fn mascara_ip_examples() {
    check.eq(mascara_ip([Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise), Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)]), [Evento(1, "mascarado", Malware, Alta, 3, EmAnalise), Evento(2, "mascarado", AcessoSuspeito, Media, 1, Desconhecido)])
    check.eq(mascara_ip([Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)]), [Evento(1, "mascarado", Malware, Alta, 3, EmAnalise)])
    check.eq(mascara_ip([]), [])
}

//EXEMPLOS F8
pub fn calcula_media_examples() {
    check.eq(calcula_media([Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise), Evento(2, "Computador 2", AcessoSuspeito, Media, 1, Desconhecido)]), 2.0)
    check.eq(calcula_media([Evento(1, "Computador 1", Malware, Alta, 3, EmAnalise)]), 3.0)
    check.eq(calcula_media([]), 0.0)
}

//EXEMPLOS F10
//pub fn imprime_relatorio_examples() {
    //todo
//}