class User < ActiveRecord::Base

  validates :nickname,
            presence: true,
            :uniqueness => { :case_sensitive => false }

  # Include default devise modules. Others available are:
  # :registerable, :recoverable, :trackable, :validatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable

  # def self.find_for_database_authentication(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(nickname) = lower(:value) OR lower(email) = lower(:value)", { :value => login }]).first
  #   else
  #     where(conditions).first
  #   end
  # end
end
