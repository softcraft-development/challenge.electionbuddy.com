class AddTargetToElectionAudit < ActiveRecord::Migration[6.1]
  def change
    add_column :election_audits, :target_id, :integer
    add_column :election_audits, :target_type, :string
  end
end
