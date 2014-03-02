class Task < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :project
  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments
  before_save :render_content
  before_save :check_end_state

  STATUSES = [
    'New',         # 0
    'In progress', # 1
    'Completed',   # 2
    'On hold',     # 3
    'Cancelled'    # 4
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
    if content_changed?
      require 'redcarpet'
      renderer = Redcarpet::Render::HTML.new
      extensions = {}  # https://github.com/vmg/redcarpet#and-its-like-really-simple-to-use
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      self.content_html = redcarpet.render self.content
    end
  end

  def check_end_state
    if status_changed? and status == 2  # changed to completed
      self.ended_at = DateTime.now
    end
  end
end
