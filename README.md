Aluno: Guilherme Teixeira Silva Email: gtex@gtexsoftware.com

Nome do Projeto

Este meu projeto é um gerenciador de tarefas para designar tarefas e prazos para trabalhadores de uma obra. Estou fazendo para que o usuário selecione um funcionário cadastrado em uma obra tenha tarefas com prazos e prioridade definidas. Atualmente ele tem tres modelos: obra, funcionario e tarefa.

📦 Tecnologias Utilizadas Ruby 3.3.5 Ruby on Rails 8.0.1 PostgreSQL

🚀 Como rodar o projeto localmente

Não precisa, pois eu subi ele no flyio =) https://task-manager-a0kf0a.fly.dev/
Mas se quiser seguem os passos abaixo.

Clone o repositório
git clone https://github.com/gtexsoftware/task_manager cd task-manager rails db:create rails db:migrate rails db:fixtures:load

abra o VSCode
Inicie o projeto dentro do dev container
✅ Funcionalidades implementadas

O app já cria funcionário por meio das fixtures que são carregadas com rails db:fixtures:load O barato aqui é editar e modificar as tarefas em uma só página que pode ser feito usando o hotwired Background job para envio de e-mails Sistema de permissões com roles diferentes

🧠 Conceitos aplicados Abaixo estão os conceitos aprendidos em aula e aplicados neste projeto, junto com a justificativa de sua utilização:

Concerns

Com o propósito de evitar fat model e isolar uma lógica de filtragem de um model foi utilizado um módulo separado de concern.

Active Record

Para o crud do aplicativo nas ações do controller foi usado o Active Record e também para as associções nos models utilizado o has_many e belongs_to

Tests

Para testar o app e garantir que as funcionalidades não quebrem foi feito um teste de controller.
