class Attachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
end
