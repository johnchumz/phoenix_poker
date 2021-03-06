defmodule PhoenixPoker.Email do
  use Bamboo.Phoenix, view: PhoenixPoker.SharedView
  alias PhoenixPoker.Utils
  alias PhoenixPoker.GameNight
  
  def welcome_text_email(email_address, body \\ "Test from PhoenixPoker") do
    new_email
    |> to(email_address)
    |> from("john.baylor@gmail.com")
    |> subject("Welcome!")
    |> text_body(body)
  end
  
  def poker_results_email(game_night, hostname) do
    verified_or_not = Enum.group_by(game_night.attendee_results, fn(a_r) ->
      a_r.player.email_verified
    end)
    IO.puts("DEBUG verified_or_not: " <> inspect(verified_or_not))

    emails = Enum.map(verified_or_not[:true], fn(a_r) ->
      a_r.player.email
    end)
    IO.puts("DEBUG emails: " <> inspect(emails))
    unverified_emails = Enum.map(verified_or_not[:false], fn(a_r) ->
      a_r.player.email
    end)
    IO.puts("DEBUG unverified_emails: " <> inspect(unverified_emails))
    
    text = Enum.sort(game_night.attendee_results, &(Utils.chips_n_name(&1) < Utils.chips_n_name(&2)) )
    |> Enum.map(fn(a_r) -> Utils.email_row(a_r) end)
    |> Enum.join("\n")
    
    base_email
    |> to(emails)
    |> subject("Poker Results for #{game_night.yyyymmdd} (fwd to #{inspect(unverified_emails)})")
    |> text_body(text)
    |> render("results_table.html", %{
                game_night: game_night,
                player_id: -1,
                hostname: hostname,
                selected_player_id: -1,
                attendees: GameNight.sorted_attendees(game_night),
                total_chips: Utils.total_chips(game_night) / 100,
                exact_cents: Utils.exact_cents(game_night),
                rounded_1_cents: Utils.rounded_1_cents(game_night),
                chips_color: Utils.chips_color(game_night),
                historical_game: true}
    )
  end
  
  defp base_email do
    new_email
    |> from("john.baylor@gmail.com")
    |> put_html_layout({PhoenixPoker.SharedView, "email_layout.html"})
  end

end
