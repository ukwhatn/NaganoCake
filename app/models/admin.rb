class Admin < ApplicationRecord
  # loginしか行わないので、database_authenticatableのみで良い
  devise :database_authenticatable
end
