class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string :name
      t.string :video
      t.string :intro
      t.string :bio
      t.timestamps
    end
  end
end

RSpec.configure do |config|
  config.before :suite do
    ActiveRecord::Base.establish_connection(
      :adapter  => "sqlite3",
      :database => ":memory:"
    )

    ActiveRecord::Migration.suppress_messages do
      CreateSchema.migrate(:up)
    end
  end
end
