// Cadastro do Bereia — primeira etapa de validação
// Vamos continuar desenvolvendo este arquivo juntas, passo a passo.

let cadastroForm = document.getElementById("cadastroForm");

let nome = document.getElementById("nomeCadastro");
let email = document.getElementById("emailCadastro");
let senha = document.getElementById("senhaCadastro");

cadastroForm.addEventListener("submit", function(event) {

    event.preventDefault();

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

    let nomeDigitado = nome.value;
    let emailDigitado = email.value;

    console.log(nomeDigitado);
    console.log(emailDigitado);

    alert("Cadastro validado com sucesso! Seja bem-vinda ao Bereia.");

});
