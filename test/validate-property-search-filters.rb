require 'selenium-webdriver'
require 'test/unit'
require_relative '../page-object/home'
require_relative '../page-object/property-search'

class PropertySearchFiltersTest < Test::Unit::TestCase
  attr_accessor :property_search

  def setup  
    Selenium::WebDriver::Chrome.driver_path = 'C:\Project\chromedriver_win32\chromedriver.exe'

    driver = Selenium::WebDriver.for(:chrome)

    driver.get "https://www.redfin.com/"

    home = Home.new(driver)

    home.txt_search_box_send_keys("Huntington Beach")
    home.btn_search_click

    @property_search = PropertySearch.new(driver)

    sleep(2)
    @property_search.btn_more_filters_click
    @property_search.drpbx_min_price_send_keys("$75k")
    @property_search.drpbx_max_price_send_keys("$700k")

    @property_search.drpbx_min_beds_send_keys("1")
    @property_search.drpbx_max_beds_send_keys("2")

    @property_search.txt_baths_send_keys("1.25+")
    @property_search.btn_apply_filters_click

    @property_search.search_results
  end

  def test_min_price
    @property_search.validate_min_price(75_000)
    @property_search.validate_max_price(700_000)

    @property_search.validate_min_bed(1)
    @property_search.validate_max_bed(2)

    @property_search.validate_min_bath(1.25)
  end

  # def test_max_price
    
  # end

  # def test_min_bed
    
  # end

  # def test_max_bed
    
  # end

  # def test_min_baths
    
  # end

  sleep(5)
end


