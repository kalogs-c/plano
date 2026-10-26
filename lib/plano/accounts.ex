defmodule Plano.Accounts do
  use Ash.Domain, otp_app: :plano, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Plano.Accounts.Token
    resource Plano.Accounts.User
  end
end
