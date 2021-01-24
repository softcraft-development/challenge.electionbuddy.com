class AddOperationToElectionAudit < ActiveRecord::Migration[6.1]
  def change
    add_column :election_audits, :operation, :string
  end
end
