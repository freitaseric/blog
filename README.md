# Blog Phoenix

Um blog simples e funcional construído com Phoenix, Elixir, TailwindCSS e DaisyUI.

Este projeto foi criado como um exemplo educacional para aprender os conceitos fundamentais do framework Phoenix e ecossistema Elixir.

## 🚀 Funcionalidades

- ✅ Criar, editar e deletar posts
- ✅ Publicar/despublicar posts (rascunhos)
- ✅ Página pública mostrando apenas posts publicados
- ✅ Painel administrativo para gerenciar posts
- ✅ Interface responsiva com DaisyUI + TailwindCSS
- ✅ Validações em formulários

## 📋 Pré-requisitos

- Elixir 1.18 ou superior
- PostgreSQL 12 ou superior
- Node.js 18 ou superior

## 🔧 Instalação

1. Clone o repositório:
```bash
git clone https://github.com/freitaseric/blog.git
cd blog
```

2. Instale as dependências:
```bash
mix deps.get
```

3. Configure o banco de dados:
```bash
mix ecto.create
mix ecto.migrate
```

4. Inicie o servidor:
```bash
mix phx.server
```

5. Acesse no navegador:
- Blog público: `http://localhost:4000`
- Painel de admin: `http://localhost:4000/posts`

## 📖 Estrutura do Projeto

```
lib/
├── blog/
│   ├── posts.ex              # Contexto (lógica de negócio)
│   └── post.ex               # Schema (modelo de dados)
└── blog_web/
├── controllers/
│   ├── page_controller.ex
│   ├── post_controller.ex
│   └── post_html/            # Templates dos posts
├── components/
│   └── core_components.ex    # Componentes reutilizáveis
└── router.ex
```
## 🧑‍💻 Conceitos Principais

### Contextos
Módulos que encapsulam lógica de negócio. Em `lib/blog/posts.ex` temos funções como `list_posts()`, `create_post()`, etc.

### Schemas
Modelos que definem estrutura de dados. Em `lib/blog/post.ex` definimos campos e validações.

### Changesets
Validam e transformam dados antes de salvar no banco.

### Componentes
Reutilize UI com `<.input />`, `<.button />`, `<.form />`, etc.

### Pipe Operator (`|>`)
Passa resultado de uma função para a próxima:
```elixir
Post
|> where([p], not is_nil(p.published_at))
|> order_by([p], desc: p.published_at)
|> Repo.all()
```

## 🛠️ Desenvolvimento

Rode os testes:
```bash
mix test
```

Acesse o console interativo:
```bash
iex -S mix
```

## 📚 Recursos

- [Phoenix Documentation](https://hexdocs.pm/phoenix/)
- [Elixir Documentation](https://elixir-lang.org/docs.html)
- [Ecto Documentation](https://hexdocs.pm/ecto/)
- [TailwindCSS](https://tailwindcss.com/)
- [DaisyUI](https://daisyui.com/)

## 📝 Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

## 🤝 Contribuindo

Sinta-se livre para fazer fork e enviar pull requests!

## 👨‍💻 Autor

Eric Freitas - [@freitaseric](https://github.com/freitaseric)