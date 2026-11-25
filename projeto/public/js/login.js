// Login do Bereia — valida os campos e autentica na API (/usuarios/autenticar)
let loginForm = document.getElementById("loginForm");

if (loginForm) {
    let email = document.getElementById("emailLogin");
    let senha = document.getElementById("senhaLogin");
    let mensagem = document.getElementById("loginMensagem");

    loginForm.addEventListener("submit", function(event) {
        event.preventDefault();
        mensagem.textContent = "";

        if (email.value.trim() == "") {
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

        fetch("/usuarios/autenticar", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                emailServer: email.value.trim().toLowerCase(),
                senhaServer: senha.value
            })
        }).then(function (resposta) {
            if (resposta.ok) {
                resposta.json().then(function (json) {
                    sessionStorage.ID_USUARIO = json.id;
                    sessionStorage.NOME_USUARIO = json.nome;
                    sessionStorage.EMAIL_USUARIO = json.email;

                    mensagem.textContent = "Login realizado! Entrando...";

                    setTimeout(function () {
                        window.location = "dashboard/livros.html";
                    }, 800);
                });
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
}
