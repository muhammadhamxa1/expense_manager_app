class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :group_name
      t.timestamps
    end
    create_table :group_members do |t|
      t.belongs_to :user
      t.belongs_to :group
      t.timestamps
    end
  end
end
