class AddUserIdToQuestions < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM questions;'
    add_reference :questions, :user, null: false, index: true
  end

  def down #migrateのバージョンを下げる時の処理
    remove_reference :questions, :user, index: true
  end
end
