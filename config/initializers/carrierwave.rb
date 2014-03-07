CarrierWave.configure do |config|
  config.enable_processing = true
  config.storage = :file

  # Disable processing in test mode to speed up testing.
  if Rails.env.test?
    config.enable_processing = false

  # Configure CarrierWave if FOG configuration is present, e.g. production.
  elsif ENV['FOG_DIRECTORY'].present?
    config.storage = :fog
    config.asset_host = ENV['AWS_S3_HOST']
    config.fog_public = true
    config.fog_directory = ENV['FOG_DIRECTORY']
    config.fog_credentials = {
      :provider => (ENV['FOG_PROVIDER'] || "AWS"),
      :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
      :region => ENV['AWS_S3_REGION'],
    }
  end
end
