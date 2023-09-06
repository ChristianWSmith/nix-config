{ userEmail, userFullName, ... }:
{
  programs.git.enable = true;
  programs.git.userEmail = userEmail;
  programs.git.userName = userFullName;
}
