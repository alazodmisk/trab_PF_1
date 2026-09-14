/// Calcula total de invasões - F3
/// A partir da lista de eventos de um ativo, calcula o total de tentativas acumulado
//ANÁLISE: Faça uma função que recebe uma lista de eventos e devolve a soma de tentativas de todos os eventos da lista.
//TIPOS DE DADOS: A entrada será uma lista de eventos, que será representada por List(Evento). A saída será a quantidade de 
//total de tentativas, representada pelo tipo primitivo *Int*.
//ESPECIFICAÇÃO: 
pub fn calcula_total_invasoes(eventos: List(Evento)) -> Int {
    todo 
}


/// Instancia evento - F1
/// Instancia um evento, registrando-o em um ativo e por consequência em um setor e por fim numa rede
//ANÁLISE: Faça uma função que recebe os parâmetros de um evento, instancia o evento e o adiciona à lista de eventos do ativo.
//TIPOS DE DADOS: As entradas serão seis: Um Id que será representado pelo tipo primitivo *Int*, uma origem que será representada pelo tipo primitivo *String*, um tipo de evento que será representado pelo tipo enumerado *TipoEvento*, 
//uma severidade que será representada pelo tipo enumerado*Severidade*, 
//uma quantidade de tentativas que será representada pelo tipo primitivo *Int*, um status do evento que será representado pelo tipo *StatusEvento* e um ativo que será representado pelo tipo composto *Ativo*.
//A saída será o ativo atualizado, que será representado pelo tipo *Ativo*.
//ESPECIFICAÇÃO: 
pub fn instancia_evento(id: Int, origem: String, tipo: TipoEvento, severidade: Severidade, tentativas: Int, status: StatusEvento, ativo: Ativo) -> Ativo {
    todo 
}

/// Classifica evento - F2
/// Classifica o grau de periculosidade de um evento recém instanciado


/// Mascara IP - F5
/// Recebe uma lista de eventos e devolve a mesma lista porém sem o IP (0 ou Nulo)


/// Calcula média - F8
/// Calcula a média de quantidade de tentativas em uma lista de eventos.
/// Necessário duas funções auxiliares


/// Imprime relatório - F10
/// Imprime três indicadores do sistema em uma string