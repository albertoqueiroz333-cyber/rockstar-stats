# 🎮 Rockstar-Stats

## 📌 Sobre o Projeto

O **Rockstar-Stats** é uma aplicação web desenvolvida para coletar e exibir estatísticas de jogadores do ecossistema GTA. O projeto consiste em uma pesquisa realizada através da inserção de dados via formulário no site do projeto, armazenando e processando essas informações de forma persistente.

---

## 🛠️ Tecnologias Utilizadas

* **HTML5:** Construção e estruturação do front-end.
* **Python:** Linguagem principal do back-end.
* **Starlette:** Framework ASGI leve e de alta performance para construção dos serviços web.
* **Jinja2:** Motor de templates para renderização dinâmica das páginas HTML.
* **Uvicorn:** Servidor web ASGI rápido para execução da aplicação Python.
* **PostgreSQL:** Banco de dados relacional para armazenamento dos registros.
* **Docker & Docker Compose:** Containerização e orquestração do ambiente da aplicação e do banco de dados.

---

## 📦 Dependências e Versões

Abaixo estão listadas as principais ferramentas, bibliotecas e suas respectivas versões utilizadas no desenvolvimento:

| Tecnologia / Lib | Versão |
| :--- | :--- |
| **Python** | `3.15` |
| **PostgreSQL** | `18.6` |
| **Starlette** | `1.8.0` |
| **Jinja** | `3.1.6` |
| **Uvicorn** | `0.54.0` |
| **Docker** | `4.95.0` |

---

## 🚀 Como Rodar o Projeto

Siga os passos abaixo para executar a aplicação na sua máquina local:

### 1. Pré-requisitos
Certifique-se de ter o **Docker** e o **Git** instalados em seu sistema.

### 2. Clonar o Repositório
Abra o terminal e faça o clone do projeto a partir do GitHub:

```bash
git clone https://github.com/albertoqueiroz333-cyber/rockstar-stats.git
cd rockstar-stats
```

### 3. Subir a Aplicação
Execute o comando abaixo para construir a imagem Docker e iniciar os containers em segundo plano (*detached mode*):

```bash
docker compose up --build -d
```

### 4. Acessar a Aplicação
Após o término da inicialização dos containers, acesse a página no seu navegador:

```text
http://localhost:8000
```

---

## ⚙️ Arquitetura de Dados & Endpoints

### Endpoint Principal
* **`POST /stats`**
  * **Content-Type:** `application/x-www-form-urlencoded`
  * **Campos do Formulário:**
    * `PLAYER_ID` (*String*, 1 a 100 caracteres) — *Chave primária do jogador*
    * `COPS_KILLED` (*Inteiro $\ge 0$*)
    * `VEHICLES_STOLEN` (*Inteiro $\ge 0$*)
    * `STORE_HOLD_UPS` (*Inteiro $\ge 0$*)
    * `MURDERED_CIVILIANS` (*Inteiro $\ge 0$*)

---

## 🛠️ Comandos Úteis

* **Verificar containers ativos:**
  ```bash
  docker compose ps
  ```

* **Visualizar logs em tempo real:**
  ```bash
  docker compose logs -f
  ```

* **Parar e remover os containers:**
  ```bash
  docker compose down
  ```