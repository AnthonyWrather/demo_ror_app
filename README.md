# README

This is a sample RoR application using Dev Containers.
It uses devise, hotwire, turbo, stimulus with a postgres db.

```bash
  Ruby version : 3.3.3
  Rails version : 7.2.2.1
```

## Create initial project and setup.  (Release v0.0.1)

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
http://127.0.0.1:3000/up
http://127.0.0.1:3000/rails/info/routes
```

PgAdmin
Create a connection to name:postgres hostname:postgres user:postgres password:progress
By using dev containers there is a complete separation between dev, test and production.

```bash
http://127.0.0.1:15432/
```

## Create the home page and basic styling. (Release v0.0.2)

```bash
rails g controller home index
```

Update routes.rb

```bash
  root "home#index"
```

Added to Gemfile

```bash
gem "inline_svg"
gem "htmlbeautifier"
```

Added to Development section in Gemfile

```bash
  gem "solargraph"
```

Run

```bash
bundle
```

Add the HTML etc to get a basic layout of the landing page.

## GitHub CI/CD test run fails.

Edit the test/controllers/home_controller_test.rb and rerun the tests.

```bash
bin/rails db:test:prepare test test:system
```

## Authentication with devise. (Release v0.0.3)

```bash
rails g controller dashboard
```

Edit app/controllers/dashboard_controller.rb
Edit config/routes.rb

Add devise

```bash
bundle add devise
rails g devise:install
rails g devise:views
rails g devise user
rails db:migrate
```

Edit app/views/layouts/application.html.erb to add the flash messages.

Create app/views/dashboard.html.erb
Edit app/controllers/dashboard_controller.rb and add the before action.
Split the navbar out into its own file app/views/home/_navbar.html.erb

Style the Sign Up screen
Edit app/views/devise/registrations/new.html.erb

TODO: Need to add the bit about styling the login screen.
Now implement the same styling on the login screen.

Run rubocop

```bash
rubocop -a
```

Run the tests.
The current tests fail with db errors so that will need tidying up.

```bash
bin/rails db:test:prepare test test:system
```

Commit and push changes

## Alert and Notice messages with stimulus. (Release v0.0.4)

Create the close controller

```bash
rails g stimulus close
```

Setup the close controller for the close action on Alerts and Notices.

Run rubocop

```bash
rubocop -a
```

## Build the Dashboard. (Release v0.0.5)

Setup the navigation bar.
Build the user menu.
TODO: Style the Profile screen.
Toggle the Profile card

```bash
rails g stimulus toggle
```

Build the sidebar.
Toggle the sidebar.

Run rubocop

```bash
rubocop -a
```

## Bonus Edit - Apply some style to the Edit User screen. (No Release)

Styled the Edit User screen.

## Setup the Project screens. (Release v0.0.6)

Layout for the Projects page.

```bash
rails g controller projects index
```

Create the table for the Projects.
Make the Projects table dynamic.
Create the Project model.

```bash
# Associate the user_id with a project.
rails g model project name:string user:references
rails db:migrate
```

Enable the creation of Projects.
Enable the deletion of Projects.
Create a basic Project edit screen.
Edit Project in a modal. (Turbo Frames)
Setting up Turbo Morphing to preserve the scroll.

## Setup the Tasks (Release v0.0.x)

Create the scaffold for the Tasks.

```bash
rails g scaffold task name:string due_date:date completed_at:datetime priority:integer project:references
rails db:migrate
```

Crud tasks and Enums.


## Next Section

```bash
```
