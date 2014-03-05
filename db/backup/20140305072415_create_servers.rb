class CreateServers < ActiveRecord::Migration
  def up
  	create_table :servers do |t|
    	t.string  :title
    	t.text    :body
    	t.time    :time
    	t.integer :server_id
    end
  end

  def down
    drop_table :servers
  end
end
