class ChangeEmbedCodeToText < ActiveRecord::Migration
  def self.up
    change_column :products, :embed_code, :text
  end

  def self.down
  end
end
