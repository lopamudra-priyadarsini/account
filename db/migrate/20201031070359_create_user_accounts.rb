class CreateUserAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_accounts do |t|
    	t.string :account_type
    	t.date :open_date
    	t.string :branch
    	t.string :customer_name
    	t.string :minor_indicator
    	t.references :user, foreign_key: true, type: :string
      t.timestamps
    end
  end
end
