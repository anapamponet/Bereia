// Sessão das páginas da área do usuário (pasta /dashboard)
// O login (js/login.js) guarda ID_USUARIO, NOME_USUARIO e EMAIL_USUARIO no sessionStorage.

function validarSessao() {
    var id = sessionStorage.ID_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    if (id == null || nome == null) {
        window.location = "../login.html";
        return false;
    }

    var authUser = document.getElementById("authUser");
    if (authUser) {
        authUser.textContent = "Olá, " + nome;
        authUser.style.display = "inline-block";
    }
    return true;
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../index.html";
}

function mostrarAviso(texto) {
    var e = document.getElementById("toast");
    e.textContent = texto;
    e.classList.add("show");
    setTimeout(function () { e.classList.remove("show"); }, 2300);
}
