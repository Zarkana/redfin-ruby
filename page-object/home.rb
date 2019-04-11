require 'selenium-webdriver'
require_relative 'base-page'

class Home < BasePage
  attr_accessor :driver

  def initialize(driver)
    @driver = driver
  end

  def btn_search_click
    btn_search = web_element(:css, 'button.SearchButton.clickable')  
    btn_search.click
  end

  def txt_search_box_send_keys(text)
    search_box = web_element(:css, '#search-box-input')  
    search_box.send_keys text
  end
end