# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  def election
    # Note: this could well generate extra queries that could be optimized away.
    # Assuming that answers never switch their questions, and question never switch their elections,
    # then we could de-normalize elections.answers_id, and then get the Answer's Election directly
    # without needing to go through Question. This would require some extra work in the models
    # to ensure that Anwer.election was set properly, and so I'll leave that off for now.
    self.question.election
  end
end
