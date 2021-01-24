# frozen_string_literal: true
require 'user'

class Election < ApplicationRecord
  has_many :questions
  belongs_to :user

  serialize :settings, Hash

  # Since this is for auditing, we want to create the ElectionAudit *after* the commit,
  # ie: once we've known for sure that the DB save has occurred. If the transaction rolls back,
  # then the changes shouldn't happen, and we shouldn't record the audit.
  after_commit :record_audit_trail

  def auditable_changes
    # The provded test doesn't allow for changes to `updated_at`, so we need to suppress them
    # here. This makes sense, as `updated_at` is really a metadata field that's going to be
    # constantly updating anyway. ElectionAudit's own created_at field is really an audit_trail
    # of the changes to Election.updated_at.

    # created_at isn't useful to audit as it *should* be write-once anyway.
    self.previous_changes.except(*[
    'created_at',
    'updated_at',
  ])
  end

  def record_audit_trail
    # Note that we're not calling create!() here. If the audit creation fails, we *probably*
    # don't want to stop the execution of the app entirely. That *may not be true*; for example, we
    # may want strict reliability and accountability in the audits (which is potentially
    # important for elections). However, if that's the case, we probably should be choosing a new
    # architecture for the audits; RDBMS is the wrong platform for these cases.
    # See ElectionAudit for more discussion.
    ElectionAudit.create(
      election: self,
      user: User.current,
      audit_changes: auditable_changes
    )
  end

  def visibility
    settings[:visibility]
  end

  def visibility=(value)
    settings[:visibility] = value
  end
end
