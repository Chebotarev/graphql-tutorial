class Resolvers::SignInUser < GraphQL::Function
  argument :authProvider, !Types::AuthProviderInput

  # defines inline return type for the mutation
  type do
    name 'SigninPayload'

    field :token, types.String
    field :user, Types::UserType
  end

  def call(_obj, args, ctx)
    auth = args[:authProvider]
    # basic validation
    return unless auth[:email]

    user = User.find_by email: auth[:email]

    # ensures we have the correct user
    return unless user
    return unless user.authenticate(auth[:password])

    # use Ruby on Rails - ActiveSupport::MessageEncryptor, to build a token
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base.byteslice(0..31))
    token = crypt.encrypt_and_sign("user-id:#{ user.id }")

    ctx[:session][:token] = token

    OpenStruct.new({
      user: user,
      token: token
    })
  end
end
