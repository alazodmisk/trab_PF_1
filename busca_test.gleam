import busca
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

// Check da funcao: busca_evento_por_id
pub fn busca_evento_por_id_examples() {
    let evento1 =tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let evento2 =tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    let evento3 = tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)

    check.eq(busca.busca_evento_por_id([evento1, evento2, evento3], 1),Ok(evento1))
    check.eq(busca.busca_evento_por_id([evento1, evento2, evento3], 2),Ok(evento2))
    check.eq(busca.busca_evento_por_id([evento1, evento2, evento3], 3),Ok(evento3))
    check.eq(busca.busca_evento_por_id([evento1, evento2, evento3], 99),Error("Evento não encontrado"))
    check.eq(busca.busca_evento_por_id([], 1),Error("Evento não encontrado"))
}


// Check da funcao: busca_ativo_por_id
pub fn busca_ativo_por_id_examples() {
    let evento1 =tipos.Evento(1, "Computador 1", tipos.Malware, tipos.Alta, 3, tipos.EmAnalise)
    let evento2 =tipos.Evento(2, "Computador 2", tipos.AcessoSuspeito, tipos.Media, 1, tipos.Desconhecido)
    let evento3 =tipos.Evento(3, "Computador 3", tipos.TentativaDeLogin, tipos.Baixa, 5, tipos.Resolvido)
    
    let ativo1 =tipos.Ativo(1, "Servidor 1", [evento1, evento2])
    let ativo2 =tipos.Ativo(2, "Servidor 2", [evento3])
    let ativo3 =tipos.Ativo(3, "Servidor 3", [])

    check.eq(busca.busca_ativo_por_id([ativo1, ativo2, ativo3], 1),[evento1, evento2])
    check.eq(busca.busca_ativo_por_id([ativo1, ativo2, ativo3], 2),[evento3])
    check.eq(busca.busca_ativo_por_id([ativo1, ativo2, ativo3], 3),[])
    check.eq(busca.busca_ativo_por_id([ativo1, ativo2, ativo3], 99),[])
    check.eq(busca.busca_ativo_por_id([], 1),[])
}