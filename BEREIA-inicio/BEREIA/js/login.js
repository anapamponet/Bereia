// Validação inicial do formulário de login do Bereia
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

        mensagem.textContent = "Os campos foram preenchidos. A autenticação será ativada quando conectarmos o banco de dados.";
    });
}
