defmodule TiciWeb.Resolvers.Accounts do
  alias Tici.Accounts
  alias TiciWeb.Schema.ChangesetErrors

  def signin(_, %{username: username, password: password}, _) do
    case Accounts.authenticate(username, password) do
      :error ->
        {:error, "Please check your username or password"}

      {:ok, user} ->
        token = TiciWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def signup(_, args, _) do
    case Accounts.create_user(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create a account", details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = TiciWeb.AuthToken.sign(user)
        {:ok, %{token: token, user: user}}
    end
  end

  def me(_,_,%{context: %{current_user: user}}) do
      {:ok, user}
  end

  def me(_,_,_) do
      {:ok, nil}
  end
end

