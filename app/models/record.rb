# frozen_string_literal: true

class Record < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :subject
  belongs_to_active_hash :subject_income
  belongs_to :user

  def user
    User.find_by(id: user_id)
  end
# 日付順に並べ替える
  scope :sorted, -> { order(date: :asc) }
# 経費
  scope :expence, -> { where(subject_id: [1..99]) }
# 収入
  scope :income, -> { where(subject_id: [100..102]) }
end
