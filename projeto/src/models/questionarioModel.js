var database = require("../database/config");

// Grava a tentativa (tabela tentativa_questionario).
// O DER tem idusuario e fkusuario; os dois recebem o id do usuário.
function registrarTentativa(idUsuario, idLivro, pontuacao) {
    var instrucaoSql = `
        INSERT INTO tentativa_questionario (idusuario, idlivro, pontuacao, datarealizacao, fkusuario)
        VALUES (?, ?, ?, NOW(), ?);
    `;
    return database.executar(instrucaoSql, [idUsuario, idLivro, pontuacao, idUsuario]);
}

// Grava as respostas da tentativa (tabela resposta_questionario) em um único INSERT.
function registrarRespostas(idTentativa, respostas) {
    var linhas = respostas.map(function (r) {
        return [idTentativa, r.numeroQuestao, r.alternativa, r.correta ? 1 : 0];
    });
    var instrucaoSql = `
        INSERT INTO resposta_questionario (idtentativa, numeroquestao, alternativaescolhida, correta)
        VALUES ?;
    `;
    return database.executar(instrucaoSql, [linhas]);
}

function totais(idUsuario) {
    var instrucaoSql = `
        SELECT COUNT(DISTINCT t.idtentativa) AS questionarios,
               COUNT(r.idresposta) AS questoes,
               COALESCE(SUM(r.correta), 0) AS acertos
        FROM tentativa_questionario t
        LEFT JOIN resposta_questionario r ON r.idtentativa = t.idtentativa
        WHERE t.fkusuario = ?;
    `;
    return database.executar(instrucaoSql, [idUsuario]);
}

function porLivro(idUsuario) {
    var instrucaoSql = `
        SELECT l.idlivro AS id, l.nome,
               COUNT(DISTINCT t.idtentativa) AS questionarios,
               COUNT(r.idresposta) AS questoes,
               COALESCE(SUM(r.correta), 0) AS acertos
        FROM livro l
        LEFT JOIN tentativa_questionario t ON t.idlivro = l.idlivro AND t.fkusuario = ?
        LEFT JOIN resposta_questionario r ON r.idtentativa = t.idtentativa
        GROUP BY l.idlivro, l.nome
        ORDER BY l.idlivro;
    `;
    return database.executar(instrucaoSql, [idUsuario]);
}

function recentes(idUsuario) {
    var instrucaoSql = `
        SELECT t.idtentativa AS id, l.nome AS livro, t.pontuacao, t.datarealizacao,
               (SELECT COUNT(*) FROM resposta_questionario r WHERE r.idtentativa = t.idtentativa) AS totalQuestoes
        FROM tentativa_questionario t
        JOIN livro l ON l.idlivro = t.idlivro
        WHERE t.fkusuario = ?
        ORDER BY t.datarealizacao DESC, t.idtentativa DESC
        LIMIT 7;
    `;
    return database.executar(instrucaoSql, [idUsuario]);
}

module.exports = { registrarTentativa, registrarRespostas, totais, porLivro, recentes };
