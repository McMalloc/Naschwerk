# put into rakefile:
# http://sequel.jeremyevans.net/rdoc/files/doc/migration_rdoc.html#label-Running+migrations+from+a+Rake+task

class CreatePosts < Sequel::Migration
  def up
    create_table :posts do
      primary_key :id
      int :user_id
      text :title
      DateTime :created_at
      text :url
      text :og_title
      text :og_description
      text :keywords
      text :og_image
      text :localimage
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE posts'
  end
end
