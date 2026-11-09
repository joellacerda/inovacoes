// Função que valida e inicia a venda
function iniciarVenda(veiculo, vendedor, valor) {
  // Regra de negócio: vendedor precisa ser o dono do veículo
  if (veiculo.proprietarioId !== vendedor.id) {
    throw new Error("Operação negada: apenas o proprietário pode vender este veículo.");
  }

  // Se passou na validação, cria o registro da venda
  const venda = {
    id: Date.now(),
    veiculoId: veiculo.id,
    modelo: veiculo.modelo,
    vendedorId: vendedor.id,
    valor: valor,
    status: "INICIADA",
    data: new Date()
  };

  return venda;
}

// --- Testando na prática ---

const proprietario = { id: 1, nome: "Carlos" };
const gol = { id: 101, modelo: "Gol 1.6", proprietarioId: 1 };

const fraudador = { id: 2, nome: "Marcos" };

// 1. Cenário válido (Carlos vendendo o próprio carro)
try {
  const vendaValida = iniciarVenda(gol, proprietario, 35000);
  console.log("Sucesso:", vendaValida);
} catch (erro) {
  console.error("Erro:", erro.message);
}

// 2. Cenário inválido (Marcos tentando vender o carro do Carlos)
try {
  const vendaInvalida = iniciarVenda(gol, fraudador, 35000);
  console.log("Sucesso:", vendaInvalida);
} catch (erro) {
  console.error("Erro:", erro.message); 
  // Saída: Erro: Operação negada: apenas o proprietário pode vender este veículo.
}