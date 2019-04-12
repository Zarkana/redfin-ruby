require 'selenium-webdriver'
require_relative 'base-page'

class PropertySearch < BasePage
  attr_accessor :driver
  attr_writer :price_results, :number_bed_results, :number_bath_results

  def initialize(driver)
    @driver = driver
  end

  def btn_more_filters_click
    element = web_element(:css, "button.button.Button.wideSidepaneFilterButton")
    element.click
  end

  #Filters

  def drpbx_min_price_send_keys(text)
    # element = web_element(:css, "span.quickMinPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element = web_element(:css, ".minPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click

    element = web_element(:xpath, "//span[contains(@class, 'minPrice')]//span[contains(text(),'#{text}')]")
    element.click
  end
  def drpbx_max_price_send_keys(text)
    # element = web_element(:css, "span.quickMaxPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element = web_element(:css, ".maxPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click

    element = web_element(:xpath, "//span[contains(@class, 'maxPrice')]//span[contains(text(),'#{text}')]")
    element.click
  end

  def drpbx_min_beds_send_keys(text)
    element = web_element(:css, "span.minBeds.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click
  
    element = web_element(:xpath, "//span[contains(@class, 'minBeds')]//span[contains(text(),'#{text}')]")
    element.click
  end
  def drpbx_max_beds_send_keys(text)
    element = web_element(:css, "span.maxBeds.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click
  
    element = web_element(:xpath, "//span[contains(@class, 'maxBeds')]//span[contains(text(),'#{text}')]")
    element.click
  end

  def txt_baths_send_keys(text)
    element = web_element(:css, "span.baths span.value")
    
    num_beds = element.text
    i = 0
    
    while (num_beds != text && (i < 20))
      btn_step_up_click
      element = web_element(:css, "span.baths span.value")
      num_beds = element.text
      i = i +1      
    end
    if text != element.text
      raise "#{text} number of bed options do not exist!"
    end
  end
  def btn_step_up_click
    element = web_element(:css, "span.baths span.step-up")
    element.click
  end

  def btn_apply_filters_click
    element = web_element(:css, "button[data-rf-test-id='apply-search-options']")
    element.click
  end

  #Home Cards

  def validate_min_price(min_price)
    @price_results.each do |price_result|
      if price_result < min_price        
        fail "FAILED: #{price_result} is lower than the min of #{min_price}"
      else
        puts "PASSED: #{price_result} is greater than the min of #{min_price}"
      end
    end
  end
  def validate_max_price(max_price)
    @price_results.each do |price_result|
      if price_result > max_price
        fail "FAILED: #{price_result} is greater than the max of #{max_price}"
      else
        puts "PASSED: #{price_result} is lower than the max of #{max_price}"
      end
    end
  end

  def validate_min_bed(min_beds)
    @number_bed_results.each do |bed_result|
      if bed_result < min_beds
        fail "FAILED: #{bed_result} is lower than the min of #{min_beds}"
      else
        puts "PASSED: #{bed_result} is greater than the min of #{min_beds}"
      end
    end
  end
  def validate_max_bed(max_beds)
    @number_bed_results.each do |bed_result|
      if bed_result > max_beds
        fail "FAILED: #{bed_result} is greater than the max of #{max_beds}"
      else
        puts "PASSED: #{bed_result} is lower than the max of #{max_beds}"
      end
    end
  end

  def validate_min_bath(min_baths)
    @number_bath_results.each do |bath_result|
      if bath_result < min_baths
        fail "FAILED: #{bath_result} is lower than the min of #{min_baths}"
      else
        puts "PASSED: #{bath_result} is greater than the min of #{min_baths}"
      end
    end
  end

  #Page Navigation

  def search_results
    #Explicitly wait for pushpin animation to complete
    wait_for(10) { @driver.find_element(:css, '.Pushpin.homePushpin.clickableHome.animateMarkers').displayed? }

    page_numbers = web_elements(:css, "[data-rf-test-id='paging-controls'] .goToPage").map do |page_number|
      page_number.text
    end    

    total_pages = 1
    if page_numbers.length > 0
      total_pages = page_numbers.last.to_i
    end
    
    @price_results = []
    @number_bed_results = []
    @number_bath_results = []

    total_pages.times do |page_num|

      wait_for(10) { @driver.find_element(:css, '.Pushpin.homePushpin.clickableHome.animateMarkers').displayed? }

      if page_num > 0
        element = web_element(:css, "[data-rf-test-id='react-data-paginate-page-#{page_num}']")
        element.click
      end

      @price_results += web_elements(:css, "div.homecards div.HomeCardContainer .bottomV2 [data-rf-test-name='homecard-price']").map do |price_element|        
        value = price_element.text.sub(",", "").sub("$", "").sub("+", "").to_i
      end      

      @number_bed_results += web_elements(:css, "div.homecards div.HomeCardContainer .bottomV2 .HomeStatsV2 .stats").select {|x| x.text.include? "Bed"}.delete_if {|x| x.text.include? "—"}.map do |bed_element|
        number = bed_element.text.sub("Beds", "").sub(" ", "").to_f
      end

      @number_bath_results += web_elements(:css, "div.homecards div.HomeCardContainer .bottomV2 .HomeStatsV2 .stats").select {|x| x.text.include? "Bath"}.delete_if {|x| x.text.include? "—"}.map do |bath_element|
        number = bath_element.text.sub("Baths", "").sub(" ", "").to_f
      end
    end
  end
end
