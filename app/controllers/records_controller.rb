# frozen_string_literal: true

class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  before_action :base, except: [:welcome]
  before_action :set_record, only: %i[show edit update destroy]
  before_action :records_expence, only: %i[new expence]
  before_action :records_all, only: %i[index shiwaketyo mototyo]
  before_action :records_sum, only: %i[trial pl bs]

  def index
    @title = '現金出納帳'
  end

  def show
    @title = '詳細'
  end

  def new
    @title = '入力'
    @record = base.new
    @records = base.expence.sorted
    @records_income = base.income.sorted
  end

  def edit
    @title = '編集'
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id

    if @record.save
      redirect_to new_record_path, notice: '追加されました'
    else
      render new_record
    end
  end

  def update
    if @record.update(record_params)
      redirect_to new_record_path, notice: '更新が完了しました'
    else
      render new_record_path
    end
  end

  def destroy
    redirect_to new_record_path, notice: '削除が完了しました' if @record.destroy
  end

  def welcome; end

  def expence
    @title = '経費帳'
    @price = @records.pluck('price')
  end

  def shiwaketyo
    @title = '仕訳帳'
    @price = @records.pluck('price')
  end

  def mototyo
    @title = '総勘定元帳'
    @records = base.sorted
  end

  def trial
    @title = '試算表'
    @cash = @sum_income - @expence
  end

  def pl
    @title = '損益計算書'
    @pl = @records[100].to_i - @expence
  end

  def bs
    @cash = @sum_income - @expence
    @pl = @records[100].to_i - @expence
    @asset = @records[18].to_i + @cash
    @debt = @records[101].to_i + @records[102].to_i + @pl
    @title = '貸借対照表'
  end

  private

  def set_record
    @record = Record.find(params[:id])
  end

  def record_params
    params.require(:record).permit(:date, :memo, :subject_id, :price, :detail).merge(user_id: current_user.id)
  end

  def records_expence
    @records = base.expence.sorted
  end

  def records_all
    @records = current_user.records.all.sorted
  end

  def records_sum
    @records = base.group('subject_id').select(:subject_id).sum(:price)
    @sum_income = base.income.sum(:price)
    @expence = base.expence.sum(:price)
  end

  def base
    base = current_user.records
  end
end
