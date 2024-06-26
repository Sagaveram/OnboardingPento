defmodule Pento.Promo do
  alias Pento.Promo.Recipient

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  # send email to promo recipient {:ok, %Recipient{}}
  def send_promo(_recipient, _attrs) do
  end
end
