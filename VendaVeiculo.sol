// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VendaVeiculo {
    struct Veiculo {
        uint256 id;
        string modelo;
        address proprietario;
    }

    struct Venda {
        uint256 id;
        uint256 veiculoId;
        string modelo;
        address vendedor;
        uint256 valor;
        string status;
        uint256 data;
    }

    mapping(uint256 => Veiculo) public veiculos;
    mapping(uint256 => Venda) public vendas;

    uint256 public nextVendaId;

    function registrarVeiculo(
        uint256 id,
        string memory modelo,
        address proprietario
    ) external {
        require(veiculos[id].id == 0, "Veiculo ja cadastrado.");

        veiculos[id] = Veiculo({
            id: id,
            modelo: modelo,
            proprietario: proprietario
        });
    }

    function iniciarVenda(uint256 veiculoId, uint256 valor) external returns (uint256) {
        Veiculo storage veiculo = veiculos[veiculoId];

        require(veiculo.id != 0, "Veiculo nao cadastrado.");
        require(
            veiculo.proprietario == msg.sender,
            "Operacao negada: apenas o proprietario pode vender este veiculo."
        );
        require(valor > 0, "Valor da venda deve ser maior que zero.");

        uint256 vendaId = ++nextVendaId;

        vendas[vendaId] = Venda({
            id: vendaId,
            veiculoId: veiculoId,
            modelo: veiculo.modelo,
            vendedor: msg.sender,
            valor: valor,
            status: "INICIADA",
            data: block.timestamp
        });

        return vendaId;
    }
}
