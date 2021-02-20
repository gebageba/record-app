require 'rails_helper'

RSpec.describe 'レコード投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @record = FactoryBot.build(:record)
  end

  context 'レコード投稿ができるとき'do
  it 'ログインしたユーザーは新規投稿できる' do
    # ログインする
    sign_in(@user)
    # フォームに情報を入力する
    fill_in 'Date', with: @record.date
    fill_in 'Memo', with: @record.memo
    select '1. 外注工費', from: 'record_subject_id'
    fill_in 'Price', with: @record.price
    fill_in 'Detail', with: @record.detail

    # 送信するとRecordモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Record.count }.by(1)
    # 投稿完了ページに遷移することを確認する
    expect(current_path).to eq new_record_path
    # 「投稿が完了しました」の文字があることを確認する
    expect(page).to have_content('追加されました')
    # トップページには先ほど投稿した内容のレコードが存在することを確認する（テキスト）
    expect(page).to have_content(@record.date)
    expect(page).to have_content(@record.memo)
    expect(page).to have_content('1. 外注工費')
    expect(page).to have_content(@record.price)
  end
end
end

RSpec.describe 'レコード編集ができる時', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @record1 = FactoryBot.build(:record)
    @record2 = FactoryBot.build(:record)
  end
  context 'レコード編集ができるとき' do
    it 'ログインしたユーザーは自分のレコードの編集ができる' do
      # ログインする
      sign_in(@user1)
      # フォームに情報を入力する
      fill_in 'Date', with: @record1.date
      fill_in 'Memo', with: @record1.memo
      select '1. 外注工費', from: 'record_subject_id'
      fill_in 'Price', with: @record1.price
      fill_in 'Detail', with: @record1.detail
      
      find('input[name="commit"]').click

      expect(current_path).to eq new_record_path

      # レコード1に「編集」ボタンがあることを確認する
      expect(page).to have_link '編集'
      # 編集ページへ遷移する
      click_on '編集'
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # expect(
      #   find('#record_date').value
      # ).to eq @record1.date
      expect(
        find('#record_memo').value
      ).to eq @record1.memo
      expect(
        find('#record_subject_id').value
      ).to eq "1"
      expect(
        find('#record_price').value
      ).to eq "#{@record1.price}"
      expect(
        find('#record_detail').value
      ).to eq @record1.detail
      # 投稿内容を編集する
      fill_in 'Date', with: @record2.date
      fill_in 'Memo', with: "#{@record1.memo}+編集したテキスト"
      select '2. 接待交際費', from: 'record_subject_id'
      fill_in 'Price', with: @record1.price+10
      fill_in 'Detail', with: "#{@record1.detail}+編集したテキスト"
      # 編集してもRecordモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Record.count }.by(0)
      # 編集完了画面に遷移したことを確認する
      expect(current_path).to eq new_record_path(@record1)
      # 「更新が完了しました」の文字があることを確認する
      expect(page).to have_content('更新が完了しました')
      # トップページには先ほど変更した内容のレコードが存在することを確認する
      expect(page).to have_content(@record2.date)
      expect(page).to have_content("#{@record1.memo}+編集したテキスト")
      expect(page).to have_content('2.接待交際費')
      expect(page).to have_content(@record1.price+10)
    end
  end
end
RSpec.describe 'レコード詳細が見れる時', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @record1 = FactoryBot.build(:record)
  end
  context 'レコード詳細が見れるとき' do
    it 'ログインしたユーザーはレコード詳細ページに遷移できる' do
      # ログインする
      sign_in(@user1)
      # フォームに情報を入力する
      fill_in 'Date', with: @record1.date
      fill_in 'Memo', with: @record1.memo
      select '1. 外注工費', from: 'record_subject_id'
      fill_in 'Price', with: @record1.price
      fill_in 'Detail', with: @record1.detail
      
      find('input[name="commit"]').click

      expect(current_path).to eq new_record_path
      # レコードに「詳細」ボタンがあることを確認する
      expect(page).to have_link '詳細'
      # 詳細ページに遷移する
      click_on '詳細'
      # 詳細ページにレコードの内容が含まれている
      expect(page).to have_content(@record1.date)
      expect(page).to have_content(@record1.memo)
      expect(page).to have_content('1. 外注工費')
      expect(page).to have_content(@record1.price)
      expect(page).to have_content(@record1.detail)
    end
  end
end

RSpec.describe 'レコード詳細が見れる時', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @record1 = FactoryBot.create(:record)
  end
context 'レコード削除できるとき' do
  it 'ログインしたユーザーは自らが投稿したレコードの削除ができる' do
    #レコード1を投稿したユーザーでログインする
    sign_in(@user1)

    fill_in 'Date', with: @record1.date
    fill_in 'Memo', with: @record1.memo
    select '1. 外注工費', from: 'record_subject_id'
    fill_in 'Price', with: @record1.price
    fill_in 'Detail', with: @record1.detail
    
    find('input[name="commit"]').click

    expect(current_path).to eq new_record_path
    # レコード1に「削除」ボタンがあることを確認する
    expect(page).to have_link '削除'

    click_on '削除'

    page.driver.browser.switch_to.alert.accept
    # 投稿を削除するとレコードの数が1減ることを確認する
    
    # expect(Record.count()).to change{Record.count}.by(-1)

    # 削除完了画面に遷移したことを確認する
    expect(current_path).to eq new_record_path
    # 「削除が完了しました」の文字があることを確認する
    expect(page).to have_content('削除が完了しました')
    # トップページにはレコード1の内容が存在しないことを確認する(テキスト)
    expect(page).to have_no_content(@record1.date)
    expect(page).to have_no_content(@record1.memo)
    # expect(page).to have_no_content('1. 外注工費')
    expect(page).to have_no_content(@record1.price)
  end
end
end

RSpec.describe '他の人のレコードは見れない', type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
    @record1 = FactoryBot.create(:record)
  end

  context '他の人のレコードは見えない'do
    it '他の人のレコードは見えない' do
      # ログインする
      sign_in(@user1)
      # フォームに情報を入力する
      fill_in 'Date', with: @record1.date
      fill_in 'Memo', with: @record1.memo
      select '1. 外注工費', from: 'record_subject_id'
      fill_in 'Price', with: @record1.price
      fill_in 'Detail', with: @record1.detail

      # 送信するとRecordモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Record.count }.by(1)
      # 投稿完了ページに遷移することを確認する
      expect(current_path).to eq new_record_path
      # 「投稿が完了しました」の文字があることを確認する
      expect(page).to have_content('追加されました')
      # トップページには先ほど投稿した内容のレコードが存在することを確認する（テキスト）
      expect(page).to have_content(@record1.date)
      expect(page).to have_content(@record1.memo)
      expect(page).to have_content('1. 外注工費')
      expect(page).to have_content(@record1.price)

      click_link "ログアウト"
      visit new_user_password_path
      
      sign_in(@user2)
      expect(page).to have_no_content(@record1.date)
      expect(page).to have_no_content(@record1.memo)
      # expect(page).to have_no_content('1. 外注工費')
      expect(page).to have_no_content(@record1.price)

      click_link "ログアウト"
      visit new_user_password_path

      sign_in(@user1)

      expect(page).to have_content(@record1.date)
      expect(page).to have_content(@record1.memo)
      expect(page).to have_content('1. 外注工費')
      expect(page).to have_content(@record1.price)
  end
end
end

 


