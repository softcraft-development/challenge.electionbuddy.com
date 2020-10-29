# frozen_string_literal: true

class CreateVoters < ActiveRecord::Migration[5.2]
  def change
    create_table :voters do |t|
      t.string :name
      t.string :email
      t.references :election, foreign_key: true

      t.timestamps
    end
  end
end
