class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :image
      t.integer :category_id
      t.string :media
      t.string :description
      t.string :contact_person
      t.boolean :is_anonymous
      t.integer :user_id

      t.timestamps
    end
  end
end
