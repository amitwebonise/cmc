class AddSubjectToActivity < ActiveRecord::Migration
  def change
	add_column :activities, :subject, :string
  end
end
