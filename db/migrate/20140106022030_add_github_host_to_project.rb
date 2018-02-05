class AddGithubHostToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :github_host, :text, default: 'github.com'
  end
end
