require 'selenium-webdriver'
require_relative 'base-page'

class PropertySearch < BasePage
  attr_accessor :driver

  def initialize(driver)
    @driver = driver
  end

  def btn_more_filters_click
    element = find_web_element(:css, "button.button.Button.wideSidepaneFilterButton")
    element.click
  end

  #Filters

  def drpbx_min_price_send_keys(text)
    # element = find_web_element(:css, "span.quickMinPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element = find_web_element(:css, ".minPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click

    element = find_web_element(:xpath, "//span[contains(@class, 'minPrice')]//span[contains(text(),'#{text}')]")
    element.click
  end
  def drpbx_max_price_send_keys(text)
    # element = find_web_element(:css, "span.quickMaxPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element = find_web_element(:css, ".maxPrice.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click

    element = find_web_element(:xpath, "//span[contains(@class, 'maxPrice')]//span[contains(text(),'#{text}')]")
    element.click
  end

  def drpbx_min_beds_send_keys(text)
    element = find_web_element(:css, "span.minBeds.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click
  
    element = find_web_element(:xpath, "//span[contains(@class, 'minBeds')]//span[contains(text(),'#{text}')]")
    element.click
  end
  def drpbx_max_beds_send_keys(text)
    element = find_web_element(:css, "span.maxBeds.withFlyout.withOptions.mounted.field.select.Select.clickable.optional")
    element.click
  
    element = find_web_element(:xpath, "//span[contains(@class, 'maxBeds')]//span[contains(text(),'#{text}')]")
    element.click
  end

  def txt_baths_send_keys(text)
    element = find_web_element(:css, "span.baths span.value")
    
    num_beds = element.text
    i = 0
    
    while (num_beds != text && (i < 20))
      btn_step_up_click
      element = find_web_element(:css, "span.baths span.value")
      num_beds = element.text
      i = i +1      
    end
    if text != element.text
      raise "#{text} number of bed options do not exist!"
    end
  end
  def btn_step_up_click
    element = find_web_element(:css, "span.baths span.step-up")
    element.click
  end

end
