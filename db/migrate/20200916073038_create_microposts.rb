class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.string :content
      t.bigint :user_id

      t.timestamps
    end
    add_index :microposts, :user_id
  end
end
