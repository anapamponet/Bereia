var database = require("../database/config");

function listar() {
    var instrucaoSql = `SELECT idlivro AS id, nome FROM livro ORDER BY idlivro;`;
    return database.executar(instrucaoSql);
}

function buscarPorId(idLivro) {
    var instrucaoSql = `SELECT idlivro AS id, nome FROM livro WHERE idlivro = ?;`;
    return database.executar(instrucaoSql, [idLivro]);
}

module.exports = { listar, buscarPorId };
