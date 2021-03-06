# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)      not null
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#

require 'rails_helper'

RSpec.describe Comment, type: :model do

end
