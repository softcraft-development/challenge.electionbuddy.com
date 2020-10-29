# frozen_string_literal: true

class CreateElections < ActiveRecord::Migration[5.2]
  def change
    create_table :elections do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.text :settings
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
