{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    upx
    v4l-utils
    git
    git-lfs
    lazygit
    license-generator
    git-ignore
    pass-git-helper
    just
    xh
    tgpt
    # mcfly # terminal history
    zellij
    progress
    noti
    topgrade
    ripgrep
    rewrk
    wrk2
    procs
    tealdeer
    # skim #fzf better alternative in rust
    monolith
    aria
    # macchina #neofetch alternative in rust
    sd
    ouch
    duf
    du-dust
    fd
    jq
    gh
    trash-cli
    zoxide
    tokei
    fzf
    bat
    mdcat
    pandoc
    lsd
    gping
    viu
    tre-command
    # felix-fm
    chafa
    feh

    cmatrix
    pipes-rs
    rsclock
    cava
    figlet
    unzip
    gnumake
    graphviz
  ];
}
