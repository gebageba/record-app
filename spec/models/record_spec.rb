# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record, type: :model do
  describe '収入・支出新規登録' do
    before do
      @record = FactoryBot.build(:record)
    end

    context '登録がうまくいく時' do
      it 'data, memo, subject_id, price, detailが存在すれば登録できる' do
        expect(@record).to be_valid
      end

      it 'date, memo, subject_id, price, detailが存在しなくても登録できる' do
        @record.date = ''
        @record.memo = ''
        @record.subject_id = ''
        @record.price = ''
        @record.detail = ''
        expect(@record).to be_valid
      end
    end
  end
end
