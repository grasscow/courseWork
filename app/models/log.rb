class Log < ActiveRecord::Base
  belongs_to :user

  def self.page_statistics(uri: nil, from: nil, til: nil)
    self.select('uri, count(*) as visits').group(:uri).order('visits DESC').limit(100)
  end

  def self.day_statistics(uri: nil, from: nil, til: nil)
    query = self.select( 'strftime(\'%d.%m.%Y\',created_at) as day, date(created_at) as h, count(*) as visits').group('h').order('h ASC').limit(100)#select strftime(\'%d/%m/%Y\', created_at)
#    query = query.select('strftime(\'%d.%m.%Y\',created_at) as day, visits')
# =>date(created_at) as day
#    query = query.where(uri: uri) if uri.present?
    query = query.where("uri not like ?", "%logs%")
     # if from.present?
     #   puts "fuuuuuuuuuuuuuuuuuuuu"
     #   query = query.where("h >= ?", from)
     # end
#     if til.present?
# #    query = query.where("day >= ?", from) if from.present?
#     query = query.where("h <= ?", til)
#     end

#    query = query.where("day <= ?", til) if til.present?

  end

  def self.statistics_sessions
  	self.select('uri, count(*) as visits').group(:uri, :user_id, :session_id).order('visits DESC').limit(100)
  end
end
