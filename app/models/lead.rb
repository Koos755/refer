class Lead < ActiveRecord::Base

  include SaveExtentions

  belongs_to :user
  belongs_to :sending_agent, class_name: "Agent"
  belongs_to :receiving_agent, class_name: "Agent"
  has_many :tokens
  has_many :lead_statuses
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user
  has_one :broker, through: :receiving_agent
  has_one :brokerage, through: :broker

  def accepted?
    if self.accepted_by_agent && self.accepted_by_broker
      return true
    else
      return false
    end
  end

  def save_agreement
    directory = establish_fog_service_and_find_bucket(ENV['AMAZON_BUCKET'])

    file = directory.files.create(
      :key    => "#{self.id}-agreement.pdf",
      :body   => File.open("#{Rails.root}/tmp/#{self.id}-agreement.pdf"),
      :public => false
    )
  end

  def get_temp_url
    bucket = establish_s3_service_and_find_bucket(ENV['AMAZON_BUCKET'])
    object = bucket.objects.find("#{self.id}-agreement.pdf")
    url = object.temporary_url(expires_at = Time.now + 3600)
  end

  private

  def establish_fog_service_and_find_bucket(bucket_name)
    connection = Fog::Storage.new({
      :provider                 => 'AWS',
      :aws_access_key_id        => ENV["AMAZON_ACCESS_KEY"],
      :aws_secret_access_key    => ENV["AMAZON_SECRET_KEY"]
    })

    directory = connection.directories.get(bucket_name)
  end


  def establish_s3_service_and_find_bucket(bucket_name)
    service = S3::Service.new(:access_key_id => ENV["AMAZON_ACCESS_KEY"],
                          :secret_access_key => ENV["AMAZON_SECRET_KEY"])
    bucket = service.buckets.find(bucket_name)
  end

end
