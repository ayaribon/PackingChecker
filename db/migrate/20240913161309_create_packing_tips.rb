class CreatePackingTips < ActiveRecord::Migration[7.2]
  def change
    create_table :packing_tips do |t|
      t.string :title
      t.text :body
      t.string :image

      t.timestamps
    end
  end
end
