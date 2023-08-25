class ChangePurchasedDefault < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :purchased, :boolean, :default => false
  end
end
