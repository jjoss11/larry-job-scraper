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
      loop do
        wait.until { driver.find_elements(css: ".list-item.with-text-2").any? }

        postings = driver.find_elements(css: ".list-item.with-text-2")

        #puts "Found #{postings.size} job postings.\n\n"

        postings.each do |posting|


            doc = Nokogiri::HTML.fragment(posting.attribute("outerHTML"))
            title =  doc.at_css(".title.ellipsis").text.strip
            left = doc.css(".flex.subtitle.subtitle-left.ellipsis").map(&:text).join("::")
            right = doc.css(".flex.subtitle.subtitle-right.ellipsis").map(&:text).join("::")
            puts "#{title} // #{left} // #{right}\n\n"

            wait.until { posting.displayed? && posting.enabled? }
            driver.execute_script("arguments[0].click();", posting)
            wait.until { driver.find_elements(css: ".job-details-container").any? }
            description_box = driver.find_element(css: ".job-details-container")
            description = description_box.attribute("innerText")
        end
        next_button = driver.find_elements(css: ".v-pagination__navigation")
        break if next_button.empty? || !next_button.last.enabled?
        
        driver.execute_script("arguments[0].click();", next_button.last)
        #sleep 10
        wait.until { driver.find_elements(css: ".list-item.with-text-2").first != postings.first }

      end

      driver.quit
      end
    end
end
