class UserSerializer < ActiveModel::Serializer
  has_many :posts

  attributes :id, :email, :address, :full_name

  def full_name
    object.slice(:first_name, :last_name).values.join(' ')
  end
end
