require 'test_helper'

class VotersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @voter = voters(:one)
    @election = elections(:one)
    sign_in users(:one)
  end

  test 'should get index' do
    get election_voters_url(election_id: @election)
    assert_response :success
  end

  test 'should get new' do
    get new_election_voter_url(election_id: @election)
    assert_response :success
  end

  test 'should create voter' do
    assert_difference('Voter.count') do
      post election_voters_url(election_id: @election), params: { voter: { election_id: @voter.election_id, email: @voter.email, name: @voter.name } }
    end

    assert_redirected_to voter_url(Voter.last)
  end

  test 'should show voter' do
    get voter_url(@voter)
    assert_response :success
  end

  test 'should get edit' do
    get edit_voter_url(@voter)
    assert_response :success
  end

  test 'should update voter' do
    patch voter_url(@voter), params: { voter: { election_id: @voter.election_id, email: @voter.email, name: @voter.name } }
    assert_redirected_to voter_url(@voter)
  end

  test 'should destroy voter' do
    assert_difference('Voter.count', -1) do
      delete voter_url(@voter)
    end

    assert_redirected_to election_voters_url(election_id: @election)
  end
end
