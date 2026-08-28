defmodule Progress do
  def update_progress(file_path) do
    file_lines = get_file_lines!(file_path)
    task_lines = filter_tasks(file_lines)
    ratio_tup = count_tasks(task_lines)
    percent_tup = percent_progress(ratio_tup)
    progress_msg = progress_message(percent_tup)
    IO.puts(progress_msg)
    new_file = update_progress(file_lines, progress_msg)
    overwrite_file(new_file, new_file)
  end

  def get_file_lines!(file_path) do
    content = File.read!(file_path)
    String.split(content, "\n")
  end

  def filter_tasks(lines) do
    # One-line: Enum.count(lines, fn l -> String.starts_with?(String.trim_leading(l), ["- [ ]", "- [x]"]) end)
    # Broken up by calling another function
    # Enum.count(lines, check_if_task(l))
    # Actually, I want it to return those lines not just count them
    Enum.filter(lines, &check_if_task/1)
  end

  def check_if_task(line) do
    String.starts_with?(String.trim_leading(line), ["- [ ]", "- [x]"])
  end

  def check_if_task_complete(line) do
    #This does not work: line[3] == "x"
    String.at(line, 3) == "x"
    #String.starts_with?(line, "- [x]")
  end

  def count_tasks(tasks) do
    total = length(tasks)
    completed = Enum.count(tasks, &check_if_task_complete/1)
    {completed, total}
  end

  def percent_progress(tup2) do
    percent_float = (elem(tup2,0) / elem(tup2,1)) * 100
    as_int = trunc(percent_float)
    if percent_float == as_int do
      {as_int, elem(tup2, 0), elem(tup2, 1)}
    else
      {Float.round(percent_float, 2), elem(tup2, 0), elem(tup2, 1)}
    end
  end

  def progress_message(tup3) do
    "**Progress: #{elem(tup3,0)}** #{elem(tup3, 1)}/#{elem(tup3, 2)} sections studied"
  end

  def find_progress_line(line) do
    String.starts_with?(String.trim_leading(line), "**Progress")
  end

  ###I want to find the index of the line starting with **Progress and replace it
  def update_progress(lines, msg) do
    i = Enum.find_index(lines, &find_progress_line/1)
    List.replace_at(lines, i, msg)
  end

  def compile_new_file(lines) do
    Enum.join(lines, "\n")
  end

  def overwrite_file(file_path, file_str) do
    File.write!(file_path, file_str)
  end

end
