


CarrierWave.configure do |config|
  config.storage    = :aws
  config.aws_bucket = "boro123"
  config.aws_acl    = 'public-read'

  # Optionally define an asset host for configurations that are fronted by a
  # content host, such as CloudFront.
 
  # The maximum period for authenticated_urls is only 7 days.
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7

  # Set custom options such as cache control to leverage browser caching
  config.aws_attributes = {
    expires: 1.week.from_now.httpdate,
    cache_control: 'max-age=604800'
  }

  config.aws_credentials = {
    access_key_id:     'AKIAIB2D46GUN57F7FYA',
    secret_access_key: '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',
    region:            'us-west-2' # Required
  }

end