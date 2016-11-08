class User < ApplicationRecord

  USERNAME_REGEX = /\A\w+\z/i
  validates :username, presence: true,
                       length: { in: 3..50 },
                       format: { with: USERNAME_REGEX }

# has_secure_password

end
