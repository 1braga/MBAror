# API de Tarefas
Projeto desenvolvido como exercício da disciplina de Fundamentos Avançados de Ruby.
A aplicação é uma API RESTful para gerenciamento de tarefas (to-do list), com fucnionalidades completas de criação, listagem, edição, cancelamento e filtros dinâmicos.

## Tecnologias Utilizadas
- Ruby
- Rails
- SQLite

## Como rodar o projeto
```
git clone https://github.com/1braga/MBAror.git
cd "Fundamentos Avancados de Ruby"/class0506/todo_list
rails db:create db:migrate
rails s
```
> A API estará disponível em http://localhost:3000

## Funcionalidades
- Criar, visualizar, atualizar e cancelar tarefas
- Cancelamento lógico: Não remove o banco, apenas marca como "Cancelada"
- Campo opcional de data de entrega
- Atualização automática do status para "Em atraso" caso a data de entrega passe
- Filtros por:
    - Status
    - Título
    - Descrição
    - Data de criação
    - Data de entrega

## Testes com curl
### Criar tarefa
```bash
curl -X POST http://localhost:3000/tarefas \
    -H "Content-Type: application/json" \
    -d '{
        "tarefa": {
        "titulo": "Fazer exercício Rails",
        "descricao": "Implementar a API de tarefas",
        "status": "Em andamento",
        "data_de_entrega": "2025-07-25"
        }
    }'
```
### Listar tarefas
```bash
    curl http://localhost:3000/tarefas
```
### Visualizar tarefa específica
```bash
    curl http://localhost:3000/tarefas/id
```
### Atualizar tarefa
```bash
curl -X PATCH http://localhost:3000/tarefas/1 \
  -H "Content-Type: application/json" \
  -d '{
    "tarefa": {
      "status": "Concluído"
    }
  }'
```
### Cancelar tarefa
```bash
    curl -X DELETE http://localhost:3000/tarefas/id
```
