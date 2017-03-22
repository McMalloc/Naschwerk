# put into rakefile:
# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations+from+a+Rake+task

class CreateUsers < Sequel::Migration
  def up
    create_table :users do
      primary_key :id
      text :name
      DateTime :created_at
      text :email
      text :phone
      text :pwdhash
      text :salt
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE users'
  end
end
