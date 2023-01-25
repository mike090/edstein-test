require 'rufus-scheduler'

scheduler = Rufus::Scheduler.singleton

# scheduler.in '5s' do
    # Rails.logger.info 'Starting accuweather data fetching at application start...'
#   AccuweatherFetchService.call ENV['LOCATION_KEY']
# end

scheduled_time = Time.now.beginning_of_hour.since(5.minutes)
scheduled_time = scheduled_time.since(1.hour) if scheduled_time < Time.now
Rails.logger.info "Hourly data fetching will start at #{scheduled_time}"

scheduler.at scheduled_time do
  Rails.logger.info 'Starting hourly data fetching...'
  scheduler.every '1h' do
    Rails.logger.info 'Starting accuweather data fetching...'
    AccuweatherFetchService.call ENV['LOCATION_KEY']
  end
end
