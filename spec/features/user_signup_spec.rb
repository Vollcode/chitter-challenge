feature 'Users can sign up to the webpage' do
  scenario 'Users can create an account' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content 'Welcome H4xx!'
    expect(User.first.email).to eq 'daniel@daniel.co.uk'
  end

  scenario 'Both sign up and sing in buttons do not appear when signed in' do
    sign_up
    expect(page).should_not have_content('Sign Up')
    expect(page).should_not have_content('Sign In')
  end
end
