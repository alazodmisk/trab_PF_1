import processamento
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
import sgleam/check

pub fn atualiza_ativos_examples() {
    let ativo1 = tipos.Ativo(1, "Ativo 1", [])
    let ativo2 = tipos.Ativo(2, "Ativo 2", [])
    let ativo3 = tipos.Ativo(3, "Ativo 3", [])
    let ativo_atualizado = tipos.Ativo(2, "Ativo 2 Atualizado", [])
    check.eq(processamento.atualiza_ativos([ativo1, ativo2, ativo3], ativo_atualizado), [ativo1, ativo_atualizado, ativo3])
    check.eq(processamento.atualiza_ativos([ativo1, ativo2], ativo_atualizado), [ativo1, ativo_atualizado])
    check.eq(processamento.atualiza_ativos([ativo1], ativo_atualizado), [ativo1])
    check.eq(processamento.atualiza_ativos([], ativo_atualizado), [])
}

pub fn atualiza_setores_examples() {
    let setor1 = tipos.Setor(1, "Setor 1", [])
    let setor2 = tipos.Setor(2, "Setor 2", [])
    let setor3 = tipos.Setor(3, "Setor 3", [])
    let setor_atualizado = tipos.Setor(2, "Setor 2 Atualizado", [])
    check.eq(processamento.atualiza_setores([setor1, setor2, setor3], setor_atualizado), [setor1, setor_atualizado, setor3])
    check.eq(processamento.atualiza_setores([setor1, setor2], setor_atualizado), [setor1, setor_atualizado])
    check.eq(processamento.atualiza_setores([setor1], setor_atualizado), [setor1])
    check.eq(processamento.atualiza_setores([], setor_atualizado), [])
}

pub fn conta_eventos_examples() {
    check.eq(processamento.conta_eventos([]), 0)
    let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    check.eq(processamento.conta_eventos([evento1]), 1)       
    check.eq(processamento.conta_eventos([evento1, tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)]), 2)
}

pub fn conta_tentativas_examples() {
    let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let evento2 = tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    check.eq(processamento.conta_tentativas([evento1, evento2, evento3]), 9)
    check.eq(processamento.conta_tentativas([evento1]), 3)
    check.eq(processamento.conta_tentativas([]), 0)
}

pub fn calcula_eventos_criticos_ou_altos_examples() {
    let evento1 = tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let evento2 = tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Critica, 5, tipos.Resolvido)
    let evento4 = tipos.Evento(4, "Computador 4", tipos.Malware, tipos.Baixa, 2, tipos.EmAnalise)
    check.eq(processamento.calcula_eventos_criticos_ou_altos([tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [evento1, evento2])]), tipos.Setor(2, "Setor 2", [tipos.Ativo(2, "Ativo 2", [evento3, evento4])])]), 2)
    check.eq(processamento.calcula_eventos_criticos_ou_altos([tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [evento1, evento2])])]), 1)
    check.eq(processamento.calcula_eventos_criticos_ou_altos([tipos.Setor(2, "Setor 2", [tipos.Ativo(2, "Ativo 2", [evento3, evento4])])]), 1)
    check.eq(processamento.calcula_eventos_criticos_ou_altos([]), 0)
}

pub fn calcula_tentativas_ativos_examples() {
    check.eq(processamento.calcula_tentativas_ativos([tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)]), tipos.Ativo(2, "Ativo 2", [tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)])]), 9)
    check.eq(processamento.calcula_tentativas_ativos([tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)])]), 3)
    check.eq(processamento.calcula_tentativas_ativos([]), 0)
}

pub fn calcula_tentativas_setores_examples() {
    check.eq(processamento.calcula_tentativas_setores([tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)])]),tipos.Setor(2, "Setor 2", [tipos.Ativo(2, "Ativo 2", [tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)])])]), 9)
    check.eq(processamento.calcula_tentativas_setores([tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)])])]), 3)
    check.eq(processamento.calcula_tentativas_setores([]), 0)
}

//EXEMPLOS F3: calcula_total_invasoes
pub fn calcula_total_invasoes_examples() {
    let evento1 =tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let evento2 =tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    check.eq(processamento.calcula_total_invasoes([evento1, evento2, evento3]),9)
    check.eq(processamento.calcula_total_invasoes([evento1]),3)
    check.eq(processamento.calcula_total_invasoes([]),0)
}

//EXEMPLOS F1: instancia_evento
pub fn instancia_evento_examples() {
    let evento1 =tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let ativo1 =tipos.Ativo(1, "Ativo 1", [evento1])
    let setor1 =tipos.Setor(1, "Setor 1", [ativo1])
    let rede1 =tipos.Rede(1, "Rede 1", [setor1])
    check.eq(processamento.instancia_evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido, ativo1, setor1, rede1), tipos.Rede(1, "Rede 1", [tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido), tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)])])]))
    check.eq(processamento.instancia_evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido, ativo1, setor1, rede1), tipos.Rede(1, "Rede 1", [tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido), tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)])])]))
    check.eq(processamento.instancia_evento(4, "Computador 4", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise, ativo1, setor1, rede1),tipos.Rede(1, "Rede 1", [tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(4, "Computador 4", tipos.Malware,tipos.Alta, 3,tipos.EmAnalise),tipos.Evento(1,"Computador 1",tipos.Malware,tipos.Alta, 3,tipos.EmAnalise)])])]))
} 

//EXEMPLOS F2: classifica_evento
pub fn classifica_evento_examples() {
    check.eq(processamento.classifica_evento(tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)), tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Media, 3, tipos.EmAnalise))
    check.eq(processamento.classifica_evento(tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Baixa, 1, tipos.Desconhecido))
    check.eq(processamento.classifica_evento(tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)), tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Alta, 5, tipos.Resolvido))
}

//EXEMPLOS F5
pub fn mascara_ip_examples() {
    check.eq(processamento.mascara_ip([tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)]), [tipos.Evento(1, "mascarado", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise),tipos.Evento(2, "mascarado",tipos.AcessoSuspeito,tipos.Media, 1,tipos.Desconhecido)])
    check.eq(processamento.mascara_ip([tipos.Evento(1, "Computador 1",tipos.Malware,tipos.Alta, 3,tipos.EmAnalise)]), [tipos.Evento(1, "mascarado",tipos.Malware,tipos.Alta, 3,tipos.EmAnalise)])
    check.eq(processamento.mascara_ip([]), [])
}

//EXEMPLOS F8
pub fn calcula_media_examples() {
    check.eq(processamento.calcula_media([tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)]), 2.0)
    check.eq(processamento.calcula_media([tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)]), 3.0)
    check.eq(processamento.calcula_media([]), 0.0)
}

//EXEMPLOS F10
pub fn imprime_relatorio_examples() {
    check.eq(processamento.imprime_relatorio(tipos.Rede(1, "Rede 1", [tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise), tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)])]), tipos.Setor(2, "Setor 2", [tipos.Ativo(2, "Ativo 2", [tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)])])])), "Setor mais perigoso: 1, Quantidade de eventos críticos ou altos: 1, Quantidade de tentativas da rede: 9")
    check.eq(processamento.imprime_relatorio(tipos.Rede(1, "Rede 1", [tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)])]), tipos.Setor(2, "Setor 2", [tipos.Ativo(2, "Ativo 2", [tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)])])])), "Setor mais perigoso: 1, Quantidade de eventos críticos ou altos: 1, Quantidade de tentativas da rede: 4")
    check.eq(processamento.imprime_relatorio(tipos.Rede(1, "Rede 1", [tipos.Setor(1, "Setor 1", [tipos.Ativo(1, "Ativo 1", [tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)])])])), "Setor mais perigoso: 1, Quantidade de eventos críticos ou altos: 1, Quantidade de tentativas da rede: 3")
    check.eq(processamento.imprime_relatorio(tipos.Rede(1, "Rede 1", [])), "Setor mais perigoso: 0, Quantidade de eventos críticos ou altos: 0, Quantidade de tentativas da rede: 0")
}