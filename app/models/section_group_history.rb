class SectionGroupHistory < ApplicationRecord
    belongs_to :section_group
    belongs_to :user
end
  