# README

This is a sample RoR application using Dev Containers.

```bash
  Ruby version : 3.3.3
  Rails version : 7.2.2.1
```

## Create initial project and setup.

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

* EDIT: Not needed in a devcontainer but would be if running locally
```bash
  rails db:create
  bin/rails db:migrate
```

Either use VSCode or run the git commands to commit the code to GitHub

Add Solargraph
```bash
gem install solargraph
```

And run the server
```bash
bin/dev
```

Web App
```bash
http://127.0.0.1:3000/
```

PgAdmin
Create a connection to name:postgres hostname:postgres user:postgres password:progress
By using dev containers there is a complete separation between dev, test and production.
```bash
http://127.0.0.1:15432/
```

## Create the home page and basic styling. (Commit as heading)

rails g controller home index

Update routes.rb
  root "home#index"

Added to Gemfile
gem "inline_svg"
gem "htmlbeautifier"

Added to Development section in Gemfile
  gem "solargraph"

Run
bundle

Add the HTML etc to get a basic layout of the landing page.

## GitHub CI/CD test run fails.

Edit the test/controllers/home_controller_test.rb and rerun the tests.

```bash
bin/rails db:test:prepare test test:system
```


## Authentication with devise

```bash
```

##
