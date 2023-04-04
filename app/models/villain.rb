class Villain < ApplicationRecord
    validates :name, :age, :enjoy, :img, presence: true
    validates :enjoy, length: { minimum: 10 }
end
