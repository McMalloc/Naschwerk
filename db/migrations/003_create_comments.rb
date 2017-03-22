# put into rakefile:
# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations+from+a+Rake+task

class CreateComments < Sequel::Migration
  def up
    create_table :comments do
      primary_key :id
      text :content
      DateTime :created_at
      int :user_id
      int :post_id
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE comments'
  end
end