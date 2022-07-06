class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :quantidade
      t.text :funcionario
      t.date :data
      t.time :horaInicio
      t.time :horaFim
      t.text :detalhes

      t.timestamps
    end
  end
end
