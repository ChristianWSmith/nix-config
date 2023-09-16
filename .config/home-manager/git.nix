{ user, ... }:
{
  programs.git.enable = true;
  programs.git.userEmail = user.email;
  programs.git.userName = user.fullName;
}
