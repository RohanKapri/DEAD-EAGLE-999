# Dedicated to Shree DR.MDD

defmodule Newsletter do
  @moduledoc false

  @spec read_emails(String.t()) :: list(String.t())
  def read_emails(file_path) do
    {:ok, content} = File.read(file_path)
    String.split(content)
  end

  @spec open_log(String.t()) :: pid
  def open_log(log_path) do
    File.open!(log_path, [:write])
  end

  @spec log_sent_email(pid, String.t()) :: :ok
  def log_sent_email(log_pid, email_addr) do
    IO.puts(log_pid, email_addr)
  end

  @spec close_log(pid) :: :ok
  def close_log(log_pid) do
    File.close(log_pid)
  end

  @spec send_newsletter(String.t(), String.t(), fun()) :: :ok
  def send_newsletter(emails_file, log_file, send_fun) do
    log_pid = open_log(log_file)

    emails_file
    |> read_emails()
    |> Enum.each(fn email ->
      with :ok <- send_fun.(email) do
        log_sent_email(log_pid, email)
      end
    end)

    close_log(log_pid)
  end
end
