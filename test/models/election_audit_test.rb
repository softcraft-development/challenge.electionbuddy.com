# frozen_string_literal: true
# require 'test_helper'

class ElectionAuditTest < ActiveSupport::TestCase
  test 'ensure audit trail is created' do
    e = elections(:one)
    e.update(settings: { visibility: 'private' })

    election_audit = ElectionAudit.last
    assert_equal({ 'settings' => [{ 'visibility' => 'public' }, { 'visibility' => 'private' }] }, election_audit.audit_changes)

    assert_equal(e, election_audit.election)
    assert_equal(e, election_audit.target)

    test_admin = users(:test_admin)
    assert_equal(test_admin, ElectionAudit.last.user)
  end
end
