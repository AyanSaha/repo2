class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :headline
      t.string :summary
      t.string :link

      t.timestamps null: false
    end
  end
end
