class CreateConfigurations < ActiveRecord::Migration[7.0]
  def change
    create_table :configurations, id: :uuid do |t|
      t.jsonb :content, null: false, default: '{}'

      t.timestamps
    end

    add_index :configurations, :content, using: :gin
  end
end
