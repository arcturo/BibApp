class WebPage < Work
  validates_presence_of :title_primary

  def self.roles
    ['Author']
  end

  def self.creator_role
    'Author'
  end

  def self.contributor_role
    'Author'
  end

  def type_uri
    "http://purl.org/dc/dcmitype/InteractiveResource" #DCMI Type
  end
end