class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: {to_table: :users } #usersテーブルに紐づけ

      t.timestamps
      t.index [:user_id, :follow_id], unique: true　#フォロー側とされる側の重複を回避
      end
  end
end
