class CreateTarefas < ActiveRecord::Migration[7.2]
  def change
    create_table :tarefas do |t|
      t.string :titulo
      t.text :descricao
      t.string :status
      t.date :data_de_entrega

      t.timestamps
    end
  end
end
