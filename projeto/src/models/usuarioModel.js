var database = require("../database/config")

// A senha é guardada com SHA2-256 (64 caracteres, cabe no VARCHAR(255) do DER).
function autenticar(email, senha) {
    var instrucaoSql = `
        SELECT idusuario AS id, nome, email FROM usuario WHERE email = ? AND senha = SHA2(?, 256);
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [email, senha]);
}

function buscarPorEmail(email) {
    var instrucaoSql = `
        SELECT idusuario AS id FROM usuario WHERE email = ?;
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [email]);
}

function cadastrar(nome, email, senha) {
    var instrucaoSql = `
        INSERT INTO usuario (nome, email, senha) VALUES (?, ?, SHA2(?, 256));
    `;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql, [nome, email, senha]);
}

module.exports = {
    autenticar,
    buscarPorEmail,
    cadastrar
};
