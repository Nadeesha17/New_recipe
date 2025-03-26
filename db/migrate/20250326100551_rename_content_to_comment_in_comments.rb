class RenameContentToCommentInComments < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :content, :comment
  end
end
