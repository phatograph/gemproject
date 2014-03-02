class Task < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :project
  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments
  before_save :render_content

  STATUSES = [
    'New',
    'In progress',
    'Completed',
    'On hold',
    'Cancelled'
  ]

  def status_text
    STATUSES[status]
  end

  def self.statuses_object
    STATUSES.each_with_index.map do |status, i|
      {
        :id => i,
        :name => status
      }
    end
  end

  def running?
    assignments.any? do |assignment|
      assignment.running?
    end
  end

  def assignees
    assignments.map do |assignment|
      { :name => assignment.user.full_name }
    end
  end

  private

  def render_content
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    extensions = {}  # https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.content_html = redcarpet.render self.content
  end
end
