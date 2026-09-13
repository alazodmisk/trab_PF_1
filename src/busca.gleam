import src/tipos.gleam
import src/processamento.gleam


/// Busca por ID - F6
/// A busca por ID tem como entrada o ID e toda a hierarquia da rede (Rede -> Setores -> Ativos -> Eventos)
/// Iniciando do topo da hierarquia, a Busca por ID encontra o evento que se deseja. Caso não haja um evento
/// com o ID indicado, a função retornará um erro.

