import processamento
import processamento_auxiliares
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
    let ativo1 = tipo.Ativo(1, "Ativo 1", [])
    let ativo2 = tipo.Ativo(2, "Ativo 2", [])
    let ativo3 = tipo.Ativo(3, "Ativo 3", [])
    let ativo_atualizado = tipo.Ativo(2, "Ativo 2 Atualizado", [])
    check.eq(processamento_auxiliares.atualiza_ativos([ativo1, ativo2, ativo3], ativo_atualizado), [ativo1, ativo_atualizado, ativo3])
    check.eq(processamento_auxiliares.atualiza_ativos([ativo1, ativo2], ativo_atualizado), [ativo1, ativo_atualizado])
    check.eq(processamento_auxiliares.atualiza_ativos([ativo1], ativo_atualizado), [ativo1])
    check.eq(processamento_auxiliares.atualiza_ativos([], ativo_atualizado), [])
}

pub fn atualiza_setores_examples() {
    let setor1 = tipo.Setor(1, "Setor 1", [])
    let setor2 = tipo.Setor(2, "Setor 2", [])
    let setor3 = tipo.Setor(3, "Setor 3", [])
    let setor_atualizado = tipo.Setor(2, "Setor 2 Atualizado", [])
    check.eq(processamento_auxiliares.atualiza_setores([setor1, setor2, setor3], setor_atualizado), [setor1, setor_atualizado, setor3])
    check.eq(processamento_auxiliares.atualiza_setores([setor1, setor2], setor_atualizado), [setor1, setor_atualizado])
    check.eq(processamento_auxiliares.atualiza_setores([setor1], setor_atualizado), [setor1])
    check.eq(processamento_auxiliares.atualiza_setores([], setor_atualizado), [])
}

pub fn conta_eventos_examples() {
    check.eq(processamento_auxiliares.conta_eventos([]), 0)
    let evento1 = tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)
    check.eq(processamento_auxiliares.conta_eventos([evento1]), 1)       
    check.eq(processamento_auxiliares.conta_eventos([evento1, tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)]), 2)
}

pub fn conta_tentativas_examples() {
    let evento1 = tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)
    let evento2 = tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)
    let evento3 = tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido)
    check.eq(processamento_auxiliares.conta_tentativas([evento1, evento2, evento3]), 9)
    check.eq(processamento_auxiliares.conta_tentativas([evento1]), 3)
    check.eq(processamento_auxiliares.conta_tentativas([]), 0)
}

pub fn calcula_eventos_criticos_ou_altos_examples() {
    let evento1 = tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)
    let evento2 = tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)
    let evento3 = tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Critica, 5, tipo.Resolvido)
    let evento4 = tipo.Evento(4, "Computador 4", tipo.Malware, tipo.Baixa, 2, tipo.EmAnalise)
    check.eq(processamento_auxiliares.calcula_eventos_criticos_ou_altos([tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [evento1, evento2])]), tipo.Setor(2, "Setor 2", [tipo.Ativo(2, "Ativo 2", [evento3, evento4])])]), 2)
    check.eq(processamento_auxiliares.calcula_eventos_criticos_ou_altos([tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [evento1, evento2])])]), 1)
    check.eq(processamento_auxiliares.calcula_eventos_criticos_ou_altos([tipo.Setor(2, "Setor 2", [tipo.Ativo(2, "Ativo 2", [evento3, evento4])])]), 1)
    check.eq(processamento_auxiliares.calcula_eventos_criticos_ou_altos([]), 0)
}

pub fn calcula_tentativas_ativos_examples() {
    check.eq(processamento_auxiliares.calcula_tentativas_ativos([tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise), tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)]), tipo.Ativo(2, "Ativo 2", [tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido)])]), 9)
    check.eq(processamento_auxiliares.calcula_tentativas_ativos([tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)])]), 3)
    check.eq(processamento_auxiliares.calcula_tentativas_ativos([]), 0)
}

pub fn calcula_tentativas_setores_examples() {
    check.eq(processamento_auxiliares.calcula_tentativas_setores([tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise), tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)])]),tipo.Setor(2, "Setor 2", [tipo.Ativo(2, "Ativo 2", [tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido)])])]), 9)
    check.eq(processamento_auxiliares.calcula_tentativas_setores([tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)])])]), 3)
    check.eq(processamento_auxiliares.calcula_tentativas_setores([]), 0)
}

//EXEMPLOS F3: calcula_total_invasoes
pub fn calcula_total_invasoes_examples() {
    let evento1 =tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)
    let evento2 =tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)
    let evento3 = tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido)
    check.eq(processamento.calcula_total_invasoes([evento1, evento2, evento3]),9)
    check.eq(processamento.calcula_total_invasoes([evento1]),3)
    check.eq(processamento.calcula_total_invasoes([]),0)
}

//EXEMPLOS F1: instancia_evento
pub fn instancia_evento_examples() {
    let evento1 =tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)
    let ativo1 =tipo.Ativo(1, "Ativo 1", [evento1])
    let setor1 =tipo.Setor(1, "Setor 1", [ativo1])
    let rede1 =tipo.Rede(1, "Rede 1", [setor1])
    check.eq(processamento.instancia_evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido, ativo1, setor1, rede1), tipo.Rede(1, "Rede 1", [tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido), tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)])])]))
    check.eq(processamento.instancia_evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido, ativo1, setor1, rede1), tipo.Rede(1, "Rede 1", [tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido), tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)])])]))
    check.eq(processamento.instancia_evento(4, "Computador 4", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise, ativo1, setor1, rede1),tipo.Rede(1, "Rede 1", [tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(4, "Computador 4", tipo.Malware,tipo.Alta, 3,tipo.EmAnalise),tipo.Evento(1,"Computador 1",tipo.Malware,tipo.Alta, 3,tipo.EmAnalise)])])]))
} 

//EXEMPLOS F2: classifica_evento
pub fn classifica_evento_examples() {
    check.eq(processamento.classifica_evento(tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)), tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Media, 3, tipo.EmAnalise))
    check.eq(processamento.classifica_evento(tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)), tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Baixa, 1, tipo.Desconhecido))
    check.eq(processamento.classifica_evento(tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido)), tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Alta, 5, tipo.Resolvido))
}

//EXEMPLOS F5
pub fn mascara_ip_examples() {
    check.eq(processamento.mascara_ip([tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise), tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)]), [tipo.Evento(1, "mascarado", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise),tipo.Evento(2, "mascarado",tipo.AcessoSuspeito,tipo.Media, 1,tipo.Desconhecido)])
    check.eq(processamento.mascara_ip([tipo.Evento(1, "Computador 1",tipo.Malware,tipo.Alta, 3,tipo.EmAnalise)]), [tipo.Evento(1, "mascarado",tipo.Malware,tipo.Alta, 3,tipo.EmAnalise)])
    check.eq(processamento.mascara_ip([]), [])
}

//EXEMPLOS F8
pub fn calcula_media_examples() {
    check.eq(processamento.calcula_media([tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise), tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)]), 2.0)
    check.eq(processamento.calcula_media([tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)]), 3.0)
    check.eq(processamento.calcula_media([]), 0.0)
}

//EXEMPLOS F10
pub fn imprime_relatorio_examples() {
    check.eq(processamento.imprime_relatorio(tipo.Rede(1, "Rede 1", [tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise), tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)])]), tipo.Setor(2, "Setor 2", [tipo.Ativo(2, "Ativo 2", [tipo.Evento(3, "Computador 3", tipo.TentativaDeLogin, tipo.Baixa, 5, tipo.Resolvido)])])])), "Setor mais perigoso: 1, Quantidade de eventos críticos ou altos: 1, Quantidade de tentativas da rede: 9")
    check.eq(processamento.imprime_relatorio(tipo.Rede(1, "Rede 1", [tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)])]), tipo.Setor(2, "Setor 2", [tipo.Ativo(2, "Ativo 2", [tipo.Evento(2, "Computador 2", tipo.AcessoSuspeito, tipo.Media, 1, tipo.Desconhecido)])])])), "Setor mais perigoso: 1, Quantidade de eventos críticos ou altos: 1, Quantidade de tentativas da rede: 4")
    check.eq(processamento.imprime_relatorio(tipo.Rede(1, "Rede 1", [tipo.Setor(1, "Setor 1", [tipo.Ativo(1, "Ativo 1", [tipo.Evento(1, "Computador 1", tipo.Malware, tipo.Alta, 3, tipo.EmAnalise)])])])), "Setor mais perigoso: 1, Quantidade de eventos críticos ou altos: 1, Quantidade de tentativas da rede: 3")
    check.eq(processamento.imprime_relatorio(tipo.Rede(1, "Rede 1", [])), "Setor mais perigoso: 0, Quantidade de eventos críticos ou altos: 0, Quantidade de tentativas da rede: 0")
}