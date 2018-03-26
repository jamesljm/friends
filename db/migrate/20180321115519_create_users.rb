class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, length: { maximum: 50 }
      t.string :phone
      t.string :email, null: false, uniqueness: { case_sensitive: false }
      
      t.timestamps
    end
  end
end
