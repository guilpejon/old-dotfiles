task :install do
  write_git_user_file
  install_files(Dir.glob('git/*'))
  # install_zsh_config
end

private

def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_files(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
    end

    if method == :symlink
      run %{ ln -nfs "#{source}" "#{target}" }
    else
      run %{ cp -f "#{source}" "#{target}" }
    end

    puts "=========================================================="
    puts
  end
end

def install_zsh_config
  source_config_code = "for config_file ($HOME/.gdf/zsh/*.zsh) source $config_file"
  File.open("#{ENV['HOME']}/.zshrc", 'a+') do |zshrc|
    if zshrc.readlines.grep(/#{Regexp.escape(source_config_code)}/).empty?
      zshrc.puts(source_config_code)
    end
  end
  oh_my_zsh = "source $ZSH/oh-my-zsh.sh"
  filename = "#{ENV['HOME']}/.zshrc"
  zshrc = File.readlines(filename)
  run %{ awk '!/source $ZSH/' #{filename} > ~/.temp && mv ~/.temp #{filename} }
  run %{ echo source $ZSH/oh-my-zsh.sh | sudo tee -a "#{ENV['HOME']}/.zshrc" }
end

def write_git_user_file
  puts "======================================================"
  puts "Git user configuration."
  puts "======================================================"

  file_name = "#{ENV["HOME"]}/.gitconfig.user"

  if File.exists?(file_name)
    puts "gitconfig.user file already exists, skipping."
  else
    gh_user = text_input("Git name")
    gh_email = text_input("Git email")

    File.open(file_name, 'w') do |f|
      f.puts("[user]\n  name = #{gh_user}  email = #{gh_email}")
    end
  end
end
