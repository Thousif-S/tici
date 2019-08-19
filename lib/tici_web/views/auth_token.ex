defmodule TiciWeb.AuthToken do
  @user_salt "user salt"

  def sign(user) do
    Phoenix.Token.sign(TiciWeb.Endpoint, @user_salt, %{id: user.id})
  end

  def verify(token) do
    Phoenix.Token.verify(TiciWeb.Endpoint, @user_salt, token, max_age: 365 * 24 * 3600)
  end
end
