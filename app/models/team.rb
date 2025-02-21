class Team < ApplicationRecord
  acts_as_tenant :organisation
end
