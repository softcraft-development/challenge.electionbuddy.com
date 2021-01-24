require "test_helper"

class ElectionAuditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @election = elections(:one)
    sign_in users(:one)
  end

  test 'should get index' do
    get election_audits_url(@election)
    assert_response :success
  end
end
