# frozen_string_literal: true
# require 'test_helper'

class ElectionAuditTest < ActiveSupport::TestCase
  test 'ensure audit trail is created' do
    e = elections(:one)
    e.update(settings: { visibility: 'private' })
    assert_equal({ 'settings' => [{ 'visibility' => 'public' }, { 'visibility' => 'private' }] }, ElectionAudit.last.audit_changes)

    test_admin = users(:test_admin)
    assert_equal(test_admin, ElectionAudit.last.user)
  end
end
