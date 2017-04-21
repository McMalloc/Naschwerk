# put into rakefile:
# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations+from+a+Rake+task

class CreateSubscriptions < Sequel::Migration
  def up
    create_table :subscriptions do
      primary_key :id
      int :user_id
      DateTime :created_at
      text :chat_id
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE subscriptions'
  end
end
