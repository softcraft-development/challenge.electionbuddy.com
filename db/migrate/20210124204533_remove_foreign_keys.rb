class RemoveForeignKeys < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key 'election_audits', 'elections'
    remove_foreign_key 'election_audits', 'users'
  end
end
