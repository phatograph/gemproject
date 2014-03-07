class AttachmentSerializer < ApplicationSerializer
  attributes :id,
    :original_url,
    :thumb_url

  def original_url
    object.attachment.url
  end

  def thumb_url
    object.attachment.thumb.url
  end
end
