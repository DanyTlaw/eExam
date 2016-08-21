class AddFileToStudent < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :file, :string
  end
end
