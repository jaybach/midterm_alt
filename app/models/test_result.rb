class TestResult < ActiveRecord::Base

	belongs_to :test
	validates :candidate_name, :candidate_email, length: {minimum: 2, maximum: 120}, presence: true
end
