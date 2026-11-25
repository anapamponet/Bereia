var questionarioModel = require("../models/questionarioModel");
var livroModel = require("../models/livroModel");

var ALTERNATIVAS = ["A", "B", "C", "D"];

function registrar(req, res) {
    var idUsuario = Number(req.body.idUsuarioServer);
    var idLivro = Number(req.body.idLivroServer);
    var respostas = req.body.respostasServer;

    if (!Number.isInteger(idUsuario) || idUsuario <= 0) {
        res.status(400).send("O id do usuário está inválido!");
        return;
    }
    if (!Number.isInteger(idLivro) || idLivro <= 0) {
        res.status(400).send("O id do livro está inválido!");
        return;
    }
    if (!Array.isArray(respostas) || respostas.length == 0) {
        res.status(400).send("As respostas estão indefinidas!");
        return;
    }
    for (var i = 0; i < respostas.length; i++) {
        var r = respostas[i];
        if (!Number.isInteger(r.numeroQuestao) || ALTERNATIVAS.indexOf(r.alternativa) < 0 || typeof r.correta != "boolean") {
            res.status(400).send("A resposta " + (i + 1) + " está inválida!");
            return;
        }
    }

    var pontuacao = respostas.filter(function (r) { return r.correta; }).length;

    livroModel.buscarPorId(idLivro)
        .then(function (livro) {
            if (livro.length == 0) {
                res.status(404).send("Livro não encontrado!");
                return;
            }

            return questionarioModel.registrarTentativa(idUsuario, idLivro, pontuacao)
                .then(function (tentativa) {
                    return questionarioModel.registrarRespostas(tentativa.insertId, respostas)
                        .then(function () {
                            res.status(201).json({ idTentativa: tentativa.insertId, pontuacao: pontuacao });
                        });
                });
        })
        .catch(function (erro) {
            console.log(erro);
            console.log("\nHouve um erro ao registrar o questionário! Erro: ", erro.sqlMessage);
            res.status(500).json(erro.sqlMessage);
        });
}

function resumo(req, res) {
    var idUsuario = Number(req.params.idUsuario);

    if (!Number.isInteger(idUsuario) || idUsuario <= 0) {
        res.status(400).send("O id do usuário está inválido!");
        return;
    }

    Promise.all([
        questionarioModel.totais(idUsuario),
        questionarioModel.porLivro(idUsuario),
        questionarioModel.recentes(idUsuario)
    ]).then(function (dados) {
        var t = dados[0][0];
        var questoes = Number(t.questoes);
        var acertos = Number(t.acertos);

        res.status(200).json({
            questionarios: Number(t.questionarios),
            questoes: questoes,
            acertos: acertos,
            aproveitamento: questoes > 0 ? Math.round(acertos / questoes * 100) : null,
            porLivro: dados[1].map(function (l) {
                var q = Number(l.questoes);
                var a = Number(l.acertos);
                return {
                    id: l.id,
                    nome: l.nome,
                    questionarios: Number(l.questionarios),
                    questoes: q,
                    acertos: a,
                    aproveitamento: q > 0 ? Math.round(a / q * 100) : null
                };
            }),
            recentes: dados[2]
        });
    }).catch(function (erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = { registrar, resumo };
