require "selenium-webdriver"
require "nokogiri"

class ScrapeJob < ApplicationJob
  queue_as :default

  def perform(urls: [])
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument("--headless") # Run in headless mode
    options.add_argument("--disable-gpu") # Disable GPU acceleration
    options.add_argument("--no-sandbox") # Bypass OS security

    driver = Selenium::WebDriver.for :chrome, options: options

    urls.each do |url|
      driver.navigate.to(url)
      puts "Page title: #{driver.title}"

      wait = Selenium::WebDriver::Wait.new(timeout: 180)
      wait.until { driver.find_elements(css: ".list-item.with-text-2").any? }

      postings = driver.find_elements(css: ".list-item.with-text-2")

      puts "Found #{postings.size} job postings.\n\n"

      postings.each do |posting|
          puts posting.text
      end

      driver.quit
      end
    end
end
