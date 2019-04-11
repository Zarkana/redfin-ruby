require 'selenium-webdriver'

class BasePage
  # attr_accessor :w_element
  # attr_writer :base_driver  
  
  # def initialize(driver)
  #   @base_driver = driver
  # end

  # def get_web_element(driver, by, timeout = 30)

  # end

  #rename?
  def web_element(type, name)
    #use wait_for method
    wait = Selenium::WebDriver::Wait.new(timeout: 15)
    wait.until { 
      element = @driver.find_element(type, name) 
      element.displayed?
      element
    }
  end

  def web_elements(type, name)
    #use wait_for method
    # wait = Selenium::WebDriver::Wait.new(timeout: 15)
    # wait.until { 
    #   element = @driver.find_elements(type, name) 
    #   element.displayed?
    #   element
    # }
    elements = @driver.find_elements(type, name)
  end

  def wait_for(seconds)
    Selenium::WebDriver::Wait.new(timeout: seconds).until { yield }
  end
  
end