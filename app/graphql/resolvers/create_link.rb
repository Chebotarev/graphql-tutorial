class Resolvers::CreateLink < GraphQL::Function
  # Define `initialize` to store field-level options, eg
  #
  #     field :myField, function: Functions::CreateLink.new(type: MyType)
  #
  # attr_reader :type
  # def initialize(type:)
  #   @type = type
  # end

  argument :url, !types.String
  argument :description, !types.String

  type Types::LinkType

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  # Resolve function:
  def call(obj, args, ctx)
    Link.create!(
      url: args[:url],
      description: args[:description],
      user: ctx[:current_user]
    )
  rescue ActiveRecord::RecordInvalid => exception
    GraphQL::ExecutionError.new("Invalid link: #{exception.record.errors.full_messages.join(', ')}")
  end
end
