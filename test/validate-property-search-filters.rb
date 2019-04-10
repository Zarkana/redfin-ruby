require 'selenium-webdriver'
require_relative '../page-object/home'
require_relative '../page-object/property-search'

Selenium::WebDriver::Chrome.driver_path = 'C:\Project\chromedriver_win32\chromedriver.exe'

driver = Selenium::WebDriver.for(:chrome)

driver.get "https://www.redfin.com/"

home = Home.new(driver)

home.txt_search_box_send_keys("Huntington Beach")
home.btn_search_click

property_search = PropertySearch.new(driver)

sleep(2)
property_search.btn_more_filters_click
property_search.drpbx_min_price_send_keys("$75k")
property_search.drpbx_max_price_send_keys("$175k")

property_search.drpbx_min_beds_send_keys("1")
property_search.drpbx_max_beds_send_keys("2")

sleep(5)