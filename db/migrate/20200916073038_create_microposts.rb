class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|

      t.timestamps
    end
  end
end
