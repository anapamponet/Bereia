// Validação do formulário de cadastro do Bereia
let cadastroForm = document.getElementById("cadastroForm");

if (cadastroForm) {
    let nome = document.getElementById("nomeCadastro");
    let email = document.getElementById("emailCadastro");
    let senha = document.getElementById("senhaCadastro");
    let mensagem = document.getElementById("cadastroMensagem");

    cadastroForm.addEventListener("submit", function(event) {
        event.preventDefault();
        mensagem.textContent = "";

        if (nome.value.trim() == "") {
            alert("Por favor, informe seu nome.");
            return;
        }
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

        console.log(nome.value);
        console.log(email.value);
        mensagem.textContent = "Cadastro validado! A criação da conta será ativada quando conectarmos o banco de dados.";
    });
}
