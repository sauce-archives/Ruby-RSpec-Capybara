require "spec_helper"

describe "Wikipedia's Ramen Page 1" do
  it "Should mention the inventor of instant Ramen 1" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 2" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 3" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 4" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 5" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 6" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 7" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen - 8" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end

  it "Should mention the inventor of instant Ramen 9" do
    visit "http://en.wikipedia.org/"
    fill_in 'search', :with => "Ramen"
    click_button "searchButton"

    heading = find '#firstHeading'
    expect( heading ).to have_content "Ramen -123"
  end
end
