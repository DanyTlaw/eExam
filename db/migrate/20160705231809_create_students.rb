class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.references  :course, foreign_key: true
      t.string :email
      t.boolean :check
      t.boolean :online

      t.timestamps
    end
  end
end
