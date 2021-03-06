# frozen_string_literal: true

module SignInSupport
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq new_record_path
  end
end
