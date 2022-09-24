class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.string :name, null: false
      t.string :nit
      t.string :contact_name, null: false
      t.string :contact_cellphone
      t.references :bank, foreign_key: true, null: false
      t.string :account_number

      t.timestamps
    end
  end
end
