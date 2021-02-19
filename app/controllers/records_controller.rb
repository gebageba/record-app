class RecordsController < ApplicationController
  before_action :authenticate_user!, except: [:welcome]
  # before_action :set_record
  # before_action :records_all, only: [:index, :shiwaketyo, :mototyo]
  # before_action :records_sum, only: [:trial, :pl, :bs]


  def index
    @title = "現金出納帳"
    @records = current_user.records.all.sorted
  end

  def show
    @title = "詳細"
  end

  

  def new
    @title = "入力"
    @records = current_user.records.expense.sorted
    @records_income = current_user.records.income.sorted
    @record = Record.new
  end

  def edit
    @title = "編集"
  end
  
  def expence
    @title = "経費帳"
    @records = Record.all
    @price = @records.pluck("price")
  end
  
  def shiwaketyo
    @title = "仕訳帳"
    @records = current_user.records.all.sorted
    @price = @records.pluck("price")
  end

  def mototyo
    @title = "総勘定元帳"
    @records = current_user.records.all.sorted
  end

  def trial
    base = current_user.records
    @records = base.group("subject_id").select(:subject_id).sum(:price)
    @sum_income = base.income.sum(:price)
    @expence = base.expense.sum(:price)
    @title = "試算表"
    @cash = @sum_income-@expence
  end

  def pl
    base = current_user.records
    @records = base.group("subject_id").select(:subject_id).sum(:price)
    @sum_income = base.income.sum(:price)
    @expence = base.expense.sum(:price)
    @pl = @records[100].to_i-@expence
    @title = "損益計算書"
  end

  def bs
    base = current_user.records
    @records = base.group("subject_id").select(:subject_id).sum(:price)
    @sum_income = base.income.sum(:price)
    @expence = base.expense.sum(:price)
    @cash = @sum_income-@expence
    @pl = @records[100].to_i-@expence
    @asset = @records[18].to_i + @cash
    @debt = @records[101].to_i + @records[102].to_i + @pl
    @title = "貸借対照表"
  end


  def create
    @record = Record.new(params.require(:record).permit(:date, :memo, :subject_id, :price, :detail).merge(user_id: current_user.id))
    @record.user_id = current_user.id

      if @record.save
         redirect_to new_record_path
      else
        render new_record
      end
    end
  end

  def update
    if @record.update(record_params)
      redirect_to new_record_path
      else
        render new_record
      end
  end

  

  def destroy
    if @record.destroy 
      redirect_to new_record_path, notice: '成功しました'
  end




  # private

  # def set_record
  #   @record = Record.find(params[:id])
  # end

  # def record_params
  #   params.require(:record).permit(:date, :memo, :subject_id, :price, :detail).merge(user_id: current_user.id)
  # end
  
  # def records_all
  #   @records = current_user.records.all.sorted
  # end
  
  # def records_sum
  #   base = current_user.records
  #   @records = base.group("subject_id").select(:subject_id).sum(:price)
  #   @sum_income = base.income.sum(:price)
  #   @expence = base.expense.sum(:price)
  # end

end