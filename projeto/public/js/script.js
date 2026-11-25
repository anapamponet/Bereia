// Cadastro do Bereia — valida os campos e cadastra na API (/usuarios/cadastrar)

let cadastroForm = document.getElementById("cadastroForm");

let nome = document.getElementById("nomeCadastro");
let email = document.getElementById("emailCadastro");
let senha = document.getElementById("senhaCadastro");
let mensagem = document.getElementById("cadastroMensagem");

cadastroForm.addEventListener("submit", function(event) {

    event.preventDefault();
    mensagem.textContent = "";

    if (nome.value == "") {
        alert("Por favor, informe seu nome.");
        return;
    }

    if (email.value == "") {
        alert("Por favor, informe seu e-mail.");
        return;
    }

    if (!email.value.includes("@")) {
        alert("Informe um e-mail válido.");
        return;
    }

    if (senha.value == "") {
        alert("Por favor, informe sua senha.");
        return;
    }

    if (senha.value.length < 8) {
        alert("A senha precisa ter pelo menos 8 caracteres.");
        return;
    }

    fetch("/usuarios/cadastrar", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({
            nomeServer: nome.value.trim(),
            emailServer: email.value.trim().toLowerCase(),
            senhaServer: senha.value
        })
    }).then(function (resposta) {
        if (resposta.ok) {
            mensagem.textContent = "Cadastro realizado com sucesso! Redirecionando para o login...";

            setTimeout(function () {
                window.location = "login.html";
            }, 2000);
        } else {
            resposta.text().then(function (texto) {
                mensagem.textContent = texto;
            });
        }
    }).catch(function (erro) {
        console.log(erro);
        mensagem.textContent = "Não foi possível conectar ao servidor. Tente novamente.";
    });

});
