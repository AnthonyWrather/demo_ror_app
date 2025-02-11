# README

* Create initial project.

```bash
rails new demo_ror_app -c tailwind --database=postgresql --devcontainer
```

* Update the devcontainer

Added pgadmin to the Dev Containers setup in .devcontainer/compose.yaml

```yaml
    depends_on:
    - pgadmin

  pgadmin:
    image: dpage/pgadmin4
    restart: unless-stopped
    environment:
      PGADMIN_DEFAULT_EMAIL: "pgadmin@pgadmin.com"
      PGADMIN_DEFAULT_PASSWORD: "password"
    volumes:
      - pgadmin-data:/var/lib/pgadmin
    ports:
      - "15432:80"
    depends_on:
      - postgres

  volumes:
    pgadmin-data:
```

Added some common extensions to VSCode
```bash
  "customizations": {
    "vscode": {
      "extensions": [
        "misogi.ruby-rubocop",
        "Shopify.ruby-lsp",
        "castwide.solargraph",
        "hridoy.rails-snippets",
        "eamodio.gitlens",
        "kaiwood.endwise",
        "esbenp.prettier-vscode",
        "streetsidesoftware.code-spell-checker",
        "GitHub.vscode-pull-request-github",
        "karunamurti.rspec-snippets",
        "oderwat.indent-rainbow",
        "Gruntfuggly.todo-tree",
        "redhat.vscode-yaml",
        "bradlc.vscode-tailwindcss",
        "vortizhe.simple-ruby-erb",
        "miguel-savignano.ruby-symbols",
        "hoovercj.ruby-linter",
        "WallabyJs.quokka-vscode",
        "pdconsec.vscode-print",
        "christian-kohler.path-intellisense",
        "christian-kohler.npm-intellisense",
        "bierner.markdown-preview-github-styles"
      ]
    }
  }
```

Run the following to enable you to publish to GitHub

```bash
  git config --global --add safe.directory /workspaces/demo_ror_app
```


