require 'selenium-webdriver'
require_relative '../page-object/home'

Selenium::WebDriver::Chrome.driver_path = 'C:\Project\chromedriver_win32\chromedriver.exe'

driver = Selenium::WebDriver.for(:chrome)

driver.get "https://www.redfin.com/"

home = Home.new(driver)

home.txt_search_box_send_keys("Huntington Beach")
home.btn_search_click

sleep(5)