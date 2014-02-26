require 'spec_helper'

describe "users can see specific states delegations" do
  let!(:user) {FactoryGirl.create(:user)}

  let!(:elected) {FactoryGirl.create(:elected)}
  let!(:elected_oos) {FactoryGirl.create(:elected, state: "NV", biography: "10001")}

  it "shows only electeds from a specific state" do
    login(user)
    # binding.pry
    visit electeds_path
    save_and_open_page
    select elected.state, from: "State"
    click_button "Filter"
    
    expect(page).to have_content elected.first_name
    expect(page).to_not have_content elected_oos.first_name
  end

  def login(user)
    visit "/login"
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button "Log in!"
  end
end