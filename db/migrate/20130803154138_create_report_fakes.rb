class CreateReportFakes < ActiveRecord::Migration
  def change
    create_table :report_fakes do |t|
      t.integer :activity_id
      t.integer :user_id
      t.boolean :is_shame

      t.timestamps
    end
  end
end
