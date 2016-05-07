def sign_up
  visit('/users')
  fill_in(:username, with: 'H4xx')
  fill_in(:name, with: 'Daniel Ortiz')
  fill_in(:email, with: 'daniel@daniel.co.uk')
  fill_in(:password, with: 'pearlover')
  click_button('Sign Up')
end
