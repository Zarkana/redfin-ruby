require 'selenium-webdriver'

class BasePage
  attr_accessor :w_element
  attr_writer :base_driver  
  
  # def initialize(driver)
  #   @base_driver = driver
  # end

  # def get_web_element(driver, by, timeout = 30)

  # end

  #rename?
  def find_web_element(type, name)
    wait = Selenium::WebDriver::Wait.new(timeout: 15)
    wait.until { 
      element = @driver.find_element(type, name) 
      element.displayed?
      element
    }
  end
  
end