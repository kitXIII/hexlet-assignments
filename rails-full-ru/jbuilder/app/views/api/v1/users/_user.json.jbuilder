json.extract! user, :id, :email, :address

json.full_name [user.first_name, user.last_name].join(' ')

json.posts user.posts, partial: 'api/v1/users/post', as: :post
