class CreateElectionAudits < ActiveRecord::Migration[6.1]
  def change
    create_table :election_audits do |t|
      t.references :election, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.json :audit_changes

      t.timestamps
    end
  end
end
