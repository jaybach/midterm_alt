class AddAnswersFromUser < ActiveRecord::Migration
  def change
  	add_column :test_results, :candidate_answers, :string
  end
end
