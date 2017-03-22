# put into rakefile:
# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations+from+a+Rake+task

class CreateFavs < Sequel::Migration
  def up
    create_table :favs do
      primary_key :id
      int :post_id
      DateTime :created_at
      int :user_id
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE favs'
  end
end
