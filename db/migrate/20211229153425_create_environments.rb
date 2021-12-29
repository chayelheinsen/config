class CreateEnvironments < ActiveRecord::Migration[7.0]
  def change
    enable_extension 'citext'

    create_table :environments, id: :uuid do |t|
      t.citext :name, null: false, unique: true
      t.references :configuration, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
