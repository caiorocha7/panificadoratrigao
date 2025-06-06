# 🥖 Sistema de Gestão para Padaria - Trigão

![Status do Projeto](https://img.shields.io/badge/status-funcional-green)
![Ruby](https://img.shields.io/badge/Ruby-3.1.2-CC342D?logo=ruby)
![Rails](https://img.shields.io/badge/Rails-7.0-CC0000?logo=rubyonrails)
![React](https://img.shields.io/badge/React-18-61DAFB?logo=react)
![Vite](https://img.shields.io/badge/Vite-4.x-646CFF?logo=vite)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-14-336791?logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-Deploy-2496ED?logo=docker)
![Licença](https://img.shields.io/badge/licen%C3%A7a-MIT-blue)

Um sistema de gestão (PDV/ERP) simples e moderno para padarias, construído com uma API Rails e um frontend React (PWA) rápido e instalável. O projeto foi desenvolvido para ser uma base funcional e escalável para controle de produtos, pedidos e usuários.

---

## 📋 Tabela de Conteúdos

1.  [Sobre o Projeto](#-sobre-o-projeto)
2.  [📸 Screenshots](#-screenshots)
3.  [🛠️ Stack Tecnológica](#️-stack-tecnológica)
4.  [✨ Funcionalidades](#-funcionalidades)
5.  [🚀 Como Rodar o Projeto](#-como-rodar-o-projeto)
    * [Pré-requisitos](#pré-requisitos)
    * [Com Docker (Recomendado)](#-rodando-com-docker-recomendado)
    * [Localmente (Para Desenvolvimento)](#-rodando-localmente-para-desenvolvimento)
6.  [🧑‍🍳 Como Usar](#-como-usar)
7.  [📁 Estrutura do Projeto](#-estrutura-do-projeto)
8.  [🌟 Próximos Passos](#-próximos-passos)
9.  [📄 Licença](#-licença)

---

## 📖 Sobre o Projeto

O **Trigão** é um protótipo funcional de um sistema de ponto de venda (PDV) e gestão para pequenas padarias. O objetivo é fornecer uma ferramenta rápida, confiável e com ótima experiência de usuário, permitindo que seja instalada em qualquer dispositivo (desktop, tablet, celular) graças à tecnologia PWA.

O backend é uma API RESTful robusta construída com **Ruby on Rails**, responsável pela lógica de negócio, segurança e persistência de dados. O frontend é uma Single Page Application (SPA) moderna e reativa, construída com **React** e **Vite**, garantindo um ambiente de desenvolvimento ágil e uma interface performática.

---

## 📸 Screenshots

*Aqui você pode adicionar imagens da sua aplicação em funcionamento.*

| Tela de Login                                       | Lista de Produtos                                         | Tela de Pedido                                    |
| --------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------- |
| ![Tela de Login](URL_DA_SUA_IMAGEM_DE_LOGIN_AQUI) | ![Lista de Produtos](URL_DA_SUA_IMAGEM_DE_PRODUTOS_AQUI) | ![Tela de Pedido](URL_DA_SUA_IMAGEM_DE_PEDIDO_AQUI) |

---

## 🛠️ Stack Tecnológica

A aplicação é dividida em dois componentes principais: `backend` e `frontend`.

| Backend (API)                                                                         | Frontend (Cliente)                                                                |
| ------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| **Ruby on Rails 7** (Modo API)                                                          | **React 18** |
| **Ruby 3.1.2** | **Vite** (Ambiente de desenvolvimento e build)                                      |
| **PostgreSQL** (Banco de dados)                                                         | **Axios** (Requisições HTTP)                                                      |
| **Pundit** (Controle de autorização por roles)                                          | **React Router DOM** (Roteamento)                                                 |
| **BCrypt** (Para senhas seguras)                                                        | **vite-plugin-pwa** (Suporte a Progressive Web App)                               |
| **Active Model Serializers** (Para construção de respostas JSON)                        | **CSS/Tailwind** (Estilização - *sugestão*)                                       |
| **Docker** & **Docker Compose** (Containerização para deploy e desenvolvimento)       | **Docker** (Servidor Nginx para build de produção)                                |

---

## ✨ Funcionalidades

-   [x] **Autenticação de Usuários:** Sistema de login/logout seguro baseado em sessão.
-   [x] **Controle de Acesso por Papel (Role):** Dois níveis de usuário (`master` e `padrão`) com permissões distintas.
-   [x] **Gestão de Produtos:** Listagem de produtos e atualização de estoque.
-   [x] **Criação de Pedidos:** Interface para adicionar produtos e registrar um novo pedido.
-   [x] **API RESTful Padronizada:** Endpoints bem definidos e respostas JSON consistentes.
-   [x] **Suporte a PWA:** O app pode ser "instalado" no dispositivo do usuário para acesso rápido e offline.
-   [x] **Ambiente Dockerizado:** Facilidade para rodar a aplicação completa com um único comando.

---

## 🚀 Como Rodar o Projeto

### Pré-requisitos

Para rodar o projeto, você precisará ter instalado em sua máquina:

* **Docker**
* **Docker Compose**

Para o ambiente de desenvolvimento local (sem Docker), você precisará de:
* Ruby 3.1.2+
* Bundler
* Rails 7+
* Node.js 18+
* Yarn ou NPM
* PostgreSQL

### 🐳 Rodando com Docker (Recomendado)

Este é o método mais simples e rápido para subir toda a aplicação (backend, frontend e banco de dados).

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/seu-usuario/trigao-gestao.git](https://github.com/seu-usuario/trigao-gestao.git)
    cd trigao-gestao
    ```

2.  **Suba os containers:**
    ```bash
    docker-compose up --build -d
    ```
    O comando irá construir as imagens do backend e frontend e iniciar os três containers em segundo plano (`-d`).

3.  **Prepare o banco de dados:**
    Na primeira vez que rodar o projeto, execute o setup do banco de dados (criação, migrações e seeds) no container do backend.
    ```bash
    docker-compose exec backend rails db:setup
    ```
    *Se precisar apenas rodar os seeds novamente:* `docker-compose exec backend rails db:seed`

4.  **Acesse a aplicação:**
    * **Frontend (Aplicação):** [http://localhost:5173](http://localhost:5173)
    * **Backend (API):** [http://localhost:3000](http://localhost:3000)

5.  **Para derrubar os containers:**
    ```bash
    docker-compose down
    ```

### 🛠️ Rodando Localmente (Para Desenvolvimento)

Se preferir rodar os serviços separadamente sem Docker.

#### Backend (API Rails)

1.  Navegue até a pasta do backend:
    ```bash
    cd trigao_backend
    ```
2.  Instale as dependências:
    ```bash
    bundle install
    ```
3.  Configure o arquivo `config/database.yml` com suas credenciais do PostgreSQL.
4.  Crie, migre e popule o banco de dados:
    ```bash
    rails db:setup
    ```
5.  Inicie o servidor Rails:
    ```bash
    rails s
    ```
    O servidor estará rodando em `http://localhost:3000`.

#### Frontend (React App)

1.  Em outro terminal, navegue até a pasta do frontend:
    ```bash
    cd trigao_frontend
    ```
2.  Instale as dependências:
    ```bash
    npm install
    ```
3.  Inicie o servidor de desenvolvimento:
    ```bash
    npm run dev
    ```
    A aplicação estará acessível em `http://localhost:5173`.

---

## 🧑‍🍳 Como Usar

Após iniciar a aplicação, você pode usar os seguintes usuários padrão para fazer login e testar as diferentes permissões:

| Role   | Username | Password | Permissões                                         |
| :----- | :------- | :------- | :------------------------------------------------- |
| **Master** | `master`   | `password` | Acesso total a todas as funcionalidades.           |
| **Padrão** | `caixa`    | `password` | Pode ver produtos e criar novos pedidos.         |

---

## 📁 Estrutura do Projeto

O projeto está organizado em uma estrutura de monorepo, com o backend e o frontend em pastas separadas na raiz.

├── trigao_backend/         # Aplicação Rails API
│   ├── app/
│   ├── config/
│   ├── db/
│   └── Dockerfile
├── trigao_frontend/        # Aplicação React + Vite
│   ├── public/
│   ├── src/
│   └── Dockerfile
├── docker-compose.yml      # Orquestrador dos serviços
└── README.md               # Este arquivo


---

## 🌟 Próximos Passos

Este projeto é uma base. Algumas ideias para futuras implementações são:

-   [ ] Implementar testes (RSpec para o backend, Jest/RTL para o frontend).
-   [ ] Criar um Dashboard com métricas de vendas.
-   [ ] Adicionar gestão de estoque mais detalhada (entradas, saídas, perdas).
-   [ ] Módulo de gestão de clientes (histórico de compras).
-   [ ] Módulo financeiro (fluxo de caixa, relatórios).
-   [ ] Autenticação via token (JWT) como alternativa à sessão.

---

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---
Feito com ❤️ por [Seu Nome](https://github.com/caiorocha7).