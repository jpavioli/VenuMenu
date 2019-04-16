class CreateAttractions < ActiveRecord::Migration[5.0]
  def change
    create_table :attractions, id: false do |t|
      t.string :id, null: false
      t.string :attraction_name
      t.string :attraction_primary_classification
      t.string :attraction_secondary_classification
      t.boolean :attraction_family_classifcation
    end
  end
end
