class Record < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :subject
  belongs_to_active_hash :subject_income
  belongs_to :user

  def user
    return User.find_by(id: self.user_id)
 end

scope :sorted, -> { order(date: :asc) }
scope :expence, -> { where(subject_id: [1..99]) }
scope :income, -> { where(subject_id: [100..102]) }

end