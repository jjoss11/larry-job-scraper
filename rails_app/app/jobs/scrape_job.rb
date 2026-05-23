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

        postings.each do |posting|
            doc = Nokogiri::HTML.fragment(posting.attribute("outerHTML"))
            title =  doc.at_css(".title.ellipsis")
            left = doc.css(".flex.subtitle.subtitle-left.ellipsis").map(&:text)
            right = doc.css(".flex.subtitle.subtitle-right.ellipsis").map(&:text)
            position_area = left[0]
            school_district = left[1]
            posted_at = right[0]
            distance = right[1]

            wait.until { posting.displayed? && posting.enabled? }
            driver.execute_script("arguments[0].click();", posting)
            wait.until { driver.find_elements(css: ".job-details-container").any? }
            description_box = driver.find_element(css: ".job-details-container")
            description = description_box.attribute("innerText")

            #puts "Extracted Data:\nTitle: #{title.text.strip}\nPosition Area: #{position_area.strip}\nSchool District: #{school_district.strip}\nPosted At: #{posted_at.strip}\nDistance: #{distance.strip}\nDescription: #{description.strip}\n\n"
            job_posting = JobPosting.create(
              title: title.text.strip,
              position_area: position_area.strip,
              school_district: school_district.strip,
              posted_at: posted_at.strip,
              distance: distance.strip,
              description: description.strip
            )
            puts job_posting.to_s
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
