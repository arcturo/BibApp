class Monograph < Work
  validates_presence_of :title_primary

  def self.roles
    ['Author', 'Editor', 'Translator', 'Illustrator']
  end

  def self.creator_role
    'Author'
  end

  def self.contributor_role
    'Editor'
  end

  def type_uri
    "http://purl.org/eprint/type/Book"
  end
  
end