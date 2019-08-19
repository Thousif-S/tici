defmodule TiciWeb.Schema.Schema do
  use Absinthe.Schema

  import Absinthe.Resolution.Helpers, only: [dataloader: 1, dataloader: 3]
  import_types(Absinthe.Type.Custom)

  alias TiciWeb.Resolvers
  alias TiciWeb.Schema.Middleware

  alias Tici.Accounts

  query do
    @desc "Get currently signed-in user"
    field :me, :user do
      resolve(&Resolvers.Accounts.me/3)
    end
    
  end

  mutation do
    @desc "Create a user"
    field :signup, :session do
      arg(:username, non_null(:string))
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.signup/3)
    end

    @desc "Sign in as a User"
    field :signin, :session do
      arg(:username, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.Accounts.signin/3)
    end
  end

  object :user do
    field :username, non_null(:string)
    field :email, non_null(:string)
  end

  object :session do
    field :token, non_null(:string)
    field :user, non_null(:user)
  end
end
