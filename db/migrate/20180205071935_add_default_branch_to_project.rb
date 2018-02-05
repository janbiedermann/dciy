class AddDefaultBranchToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :default_branch, :string
  end
end
