var express = require("express");
var router = express.Router();

var questionarioController = require("../controllers/questionarioController");

router.post("/registrar", function (req, res) {
    questionarioController.registrar(req, res);
});

router.get("/resumo/:idUsuario", function (req, res) {
    questionarioController.resumo(req, res);
});

module.exports = router;
