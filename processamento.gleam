/// Calcula total de invasões - F3
/// A partir da lista de eventos de um ativo, calcula o total de tentativas acumulado
//ANÁLISE: Faça uma função que recebe uma lista de eventos e devolve a soma de tentativas de todos os eventos da lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada por List(Evento). A saída será a quantidade de 
//total de tentativas, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: Recebe uma lista de *eventos* e devolve a soma de tentativas de todos os eventos da lista.
pub fn calcula_total_invasoes(eventos: List(Evento)) -> Int {
    todo 
}

/// Instancia evento - F1
/// Instancia um evento, registrando-o em um ativo e por consequência em um setor e por fim numa rede
//ANÁLISE: Faça uma função que recebe os parâmetros de um evento, instancia o evento e o adiciona à lista de eventos do ativo.
//TIPOS DE DADOS: As entradas serão seis: Um Id que será representado pelo tipo primitivo *Int*, um IP que será representada pelo tipo primitivo *String*, um tipo de evento que será representado pelo tipo enumerado *TipoEvento*, 
//uma severidade que será representada pelo tipo enumerado*Severidade*, 
//uma quantidade de tentativas que será representada pelo tipo primitivo *Int*, um status do evento que será representado pelo tipo *StatusEvento* e um ativo que será representado pelo tipo composto *Ativo*.
//A saída será o ativo atualizado, que será representado pelo tipo *Ativo*.
//ESPECIFICAÇÃO: Recebe os atributos de um evento e um ativo, instancia o evento e o adiciona à lista de eventos do ativo, devolvendo o ativo atualizado.
pub fn instancia_evento(id: Int, ip: String, tipo: TipoEvento, severidade: Severidade, tentativas: Int, status: StatusEvento, ativo: Ativo) -> Ativo {
    todo 
}

/// Classifica evento - F2
/// Classifica o grau de periculosidade de um evento recém instanciado
//ANÁLISE: Faça uma função que recebe um evento e devolve o mesmo evento com a severidade atualizada de acordo com a quantidade de tentativas.
//TIPOS DE DADOS: A entrada será um evento, que será representado pelo tipo composto *Evento*. A saída será o mesmo evento com a severidade atualizada, 
//que será representado pelo tipo composto *Evento*.
//ESPECIFICAÇÃO: Recebe um evento e devolve o mesmo evento com a severidade atualizada de acordo com a quantidade de tentativas.
pub fn classifica_evento(evento: Evento) -> Evento {
    todo 
}


/// Mascara IP - F5
/// Recebe uma lista de eventos e devolve a mesma lista porém sem o IP (0 ou Nulo)
//ANÁLISE: Faça uma função que recebe uma lista de eventos e devolve a mesma lista porém com os IPs dos eventos escrito "mascarado" no lugar.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada pelo tipo composto *List(Evento)*. A saída será a mesma lista de eventos porém com os IPs dos eventos escrito "mascarado" no lugar, que será representada pelo tipo composto *List(Evento)*.
//ESPECIFICAÇÃO: Recebe uma lista de eventos e devolve a mesma lista porém com os IPs dos eventos escrito "mascarado" no lugar.
pub fn mascara_ip(eventos: List(Evento)) -> List(Evento) {
    todo 
}


/// Calcula média - F8
/// Calcula a média de quantidade de tentativas em uma lista de eventos.
/// Necessário duas funções auxiliares
//ANÁLISE: Faça uma função que receba uma lista de eventos e calcule a quantidade média de tentativas dessa lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada pelo tipo composto *List(Evento)*. A saída será a quantidade média de tentativas, que será representada pelo tipo primitivo *Float*.
//ESPECIFICAÇÃO: Recebe uma lista de *eventos* e devolve a quantidade média de tentativas.
pub fn calcula_media(eventos: List(Evento)) -> Float {
    todo 
}


/// Imprime relatório - F10
/// Imprime três indicadores do sistema em uma string
//ANÁLISE: Faça uma função que receba uma rede e devolva uma string com três indicadores do sistema: o setor mais perigoso, a quantidade de eventos com severidade crítica e a quantidade de eventos com severidade alta.
//TIPOS DE DADOS: A entrada será uma rede, que será representada pelo tipo composto *Rede*. A saída será uma string, que será representada pelo tipo primitivo *String*.
//ESPECIFICAÇÃO: Recebe uma *rede* e devolve uma string com três indicadores do sistema.
pub fn imprime_relatorio(rede: Rede) -> String {
    todo 
}
