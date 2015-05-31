class Log < ActiveRecord::Base
  belongs_to :user

  def self.page_statistics(uri: nil, from: nil, til: nil)
    self.select('uri, count(*) as visits').group(:uri).order('visits DESC').limit(100)
  end

  def self.day_statistics(uri: nil, from: nil, til: nil)
    query = self.select('strftime(\'%d.%m.%Y\', created_at) as day, count(*) as visits').group('day').order('day ASC').limit(100)#select strftime(\'%d/%m/%Y\', created_at)
    query.where(uri: uri) if uri.present?
    query.where("created_at >= ?", from) if from.present?
    query.where("created_at <= ?", til) if til.present?
    query
  end

  def self.statistics_sessions
  	self.select('uri, count(*) as visits').group(:uri, :user_id, :session_id).order('visits DESC').limit(100)
  end
end
