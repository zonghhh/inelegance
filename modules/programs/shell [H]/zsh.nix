{ ... }: {
  flake.modules.homeManager.zsh = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting = {
        enable = true;
        highlighters = [
          "main"
          "bracket"
        ];
      };

      historySubstringSearch.enable = true;
      history = {
        ignoreDups = true;
        save = 10000;
        size = 10000;
      };

      shellAliases = {
        ls = "eza --icons=always --no-quotes";
        tree = "eza --icons=always --no-quotes --tree";
      };
    };
  };
}
