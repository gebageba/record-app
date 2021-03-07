# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :records, dependent: :destroy

  def records
    Record.where(user_id: id)
  end

  def self.guest
    find_by(email: 'sample@sample.com') do |user|
      user.password = SecureRandom.urlsafe_base6
    end
  end
end
