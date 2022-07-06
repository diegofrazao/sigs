class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.text :descricao
      t.decimal :valor

      t.timestamps
    end
  end
end
