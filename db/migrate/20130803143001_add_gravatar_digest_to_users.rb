class AddGravatarDigestToUsers < ActiveRecord::Migration
  def change
	add_column :users, :gravatar_digest, :string
  end
end
