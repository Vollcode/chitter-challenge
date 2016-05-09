feature 'Users can post peeps' do

  scenario 'Only signed up users can post peeps' do
    visit('/')
    expect(page).should_not have_content('New Peep')
  end

  scenario 'A signed up user can post peeps' do
    sign_up
    fill_in :title, with: 'Hello everyone'
    fill_in :content, with: 'How are you doing?'
    click_button 'New Peep'
    expect(page). to have_content('Hello everyone')
  end
end
