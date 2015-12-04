class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :hurigana
      t.date :date
      t.string :bunrui
      t.string :bangou
      t.string :gozyuon

      t.timestamps null: false
    end
  end
end
