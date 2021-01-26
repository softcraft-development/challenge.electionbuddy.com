class ElectionAuditsController < ApplicationController
  def index
    # Note: no permissions check that the current user can see the audit log
    # for this election.
    @election = Election.find(params[:election_id])
    @audits = @election.election_audits
  end
end
