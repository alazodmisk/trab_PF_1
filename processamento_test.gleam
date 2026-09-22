import processamento
import tipos
import sgleam/check

//EXEMPLOS F3
pub fn calcula_total_invasoes_examples() {
    let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let evento2 = tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    check.eq(processamento.calcula_total_invasoes([evento1, evento2, evento3]), 9)
    check.eq(processamento.calcula_total_invasoes([evento1]), 3)
    check.eq(processamento.calcula_total_invasoes([]), 0)
}

//EXEMPLOS F1
pub fn instancia_evento_examples() {
    let ativo = tipos.Ativo(1, "Ativo 1", [])
    let setor = tipos.Setor(1, "Setor 1", [ativo])
    let rede = tipos.Rede(1, "Rede 1", [setor])
    let evento = processamento.instancia_evento(1, "Acesso não autorizado", tipos.TentativaDeLogin, tipos.Alta, 3, tipos.EmAnalise, ativo, setor, rede)
    check.eq(evento, tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Acesso não autorizado", tipos.TentativaDeLogin, tipos.Alta, 3, tipos.EmAnalise)]))
} 

//EXEMPLOS F2
//pub fn classifica_evento_examples() {
    //let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Nula, 0, tipos.Desconhecido)
    //let evento2 = tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Nula, 3, tipos.Desconhecido)
    //let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Nula, 6, tipos.Desconhecido)
    //check.eq(processamento.classifica_evento(evento1), tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Nula, 0, tipos.Desconhecido))
    //check.eq(processamento.classifica_evento(evento2), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Alta, 3, tipos.Desconhecido))
    //check.eq(processamento.classifica_evento(evento3), tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Critica, 6, tipos.Desconhecido))
//}

//EXEMPLOS F5
//pub fn mascara_ip_examples() {
    //let evento1 = tipos.Evento(1, "192.168.1.1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    //let evento2 = tipos.Evento(2, "192.168.1.2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    //let evento3 = tipos.Evento(3, "192.168.1.3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    //check.eq(processamento.mascara_ip([evento1, evento2, evento3]), [tipos.Evento(1, "0.0.0.0", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise), tipos.Evento(2, "0.0.0.0", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido), tipos.Evento(3, "0.0.0.0", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)])
//}

//EXEMPLOS F8
//pub fn calcula_media_examples() {
    //let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    //let evento2 = tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    //let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    //check.eq(processamento.calcula_media([evento1, evento2, evento3]), 3.0)
    //check.eq(processamento.calcula_media([evento1]), 3.0)
    //check.eq(processamento.calcula_media([]), 0.0)
//}

//EXEMPLOS F10
//pub fn imprime_relatorio_examples() {
    //let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Critica, 3, tipos.EmAnalise)
    //let evento2 = tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Alta, 1, tipos.Desconhecido)
    //let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    //let ativo1 = tipos.Ativo(1, "Ativo 1", [evento1])
    //let ativo2 = tipos.Ativo(2, "Ativo 2", [evento2])
    //let ativo3 = tipos.Ativo(3, "Ativo 3", [evento3])
    //let setor1 = tipos.Setor(1, "Setor 1", [ativo1])
    //let setor2 = tipos.Setor(2, "Setor 2", [ativo2])
    //let setor3 = tipos.Setor(3, "Setor 3", [ativo3])
    //let rede = tipos.Rede(1, "Rede 1", [setor1, setor2, setor3])
    //check.eq(processamento.imprime_relatorio(rede), "Setor mais perigoso: Setor 1\nQuantidade de eventos críticos: 1\nQuantidade de eventos altos: 1")
//}