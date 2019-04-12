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
    wait = Selenium::WebDriver::Wait.new(:timeout => 15)
    wait.until { 
      element = driver.find_element(:css, '#search-box-input') 
      begin
        element.send_keys text  
      rescue Selenium::WebDriver::Error::ElementNotInteractableError
        puts "resuced from ElementNotInteractableError exception"
      end
      if element.attribute('value').downcase.include? text.downcase
        true
      end
    }
  end
end