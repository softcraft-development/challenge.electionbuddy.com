require 'user'

module ElectionAuditable
  extend ActiveSupport::Concern

  # The provded test doesn't allow for changes to `updated_at`, so we need to suppress them
  # here. This makes sense, as `updated_at` is really a metadata field that's going to be
  # constantly updating anyway. ElectionAudit's own created_at field is really an audit_trail
  # of the changes to Election.updated_at.
  #
  # created_at isn't useful to audit as it *should* be write-once anyway.
  #
  # Any other sensitive attributes should be in this list. We don't want any sensitive
  # information accidentally leaked So far, that's just Devise's
  # encrypted_password and reset_password_token. User isn't (currently) an ElectionAuditable,
  # so strictly speaking thse attributes don't need to be blacklisted. However, it's best
  # to include them now just so they don't get accidentally recorded in the future.
  #
  # If we do want to indicate that these values changed (without leaking their actual values),
  # then we should be writing custom code to handle that.
  #
  DEFAULT_ATTRIBUTE_BLACKLIST = [
    'created_at',
    'encrypted_password',
    'id',
    'reset_password_token',
    'updated_at',
  ]

  included do
    # Since this is for auditing, we want to create the ElectionAudit *after* the commit,
    # ie: once we've known for sure that the DB save has occurred. If the transaction rolls back,
    # then the changes shouldn't happen, and we shouldn't record the audit.
    after_commit -> { record_audit_trail(:create) }, on: :create
    after_commit -> { record_audit_trail(:destroy) }, on: :destroy
    after_commit -> { record_audit_trail(:update) }, on: :update
  end

  def auditable_changes
    # Note: it's reasonable to whitelist specific attributes rather than try to blacklist ones.
    # That can be done here, and overridden on a per-class basis.
    self.previous_changes.except(*DEFAULT_ATTRIBUTE_BLACKLIST)
  end

  def election
    # In Ruby, we don't have a compiler that's going to warn us when an "abstract class" is missing
    # an abstract method, so I like to raise an exception when an implementation isn't provided.
    # Testing should ensure that this is never called.
    raise "#{self.class} is missing a reference to its election"
  end

  def record_audit_trail(operation)
    # Note that we're not calling create!() here. If the audit creation fails, we *probably*
    # don't want to stop the execution of the app entirely. That *may not be true*; for example, we
    # may want strict reliability and accountability in the audits (which is potentially
    # important for elections). However, if that's the case, we probably should be choosing a new
    # architecture for the audits; RDBMS is the wrong platform for these cases.
    # See ElectionAudit for more discussion.
    ElectionAudit.create(
      audit_changes: auditable_changes,
      election: election,
      operation: operation,
      target: self,
      user: User.current,
    )
  end
end
