class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[7.1]
  def change
    change_table(:users, bulk: true) do |t|
      ## Add DeviseTokenAuth fields if missing
      t.string :provider, null: false, default: "email" unless column_exists?(:users, :provider)
      t.string :uid, null: false, default: "" unless column_exists?(:users, :uid)
      t.text :tokens unless column_exists?(:users, :tokens)
    end

    add_index :users, [:uid, :provider], unique: true unless index_exists?(:users, [:uid, :provider])
  end
end
