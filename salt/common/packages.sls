upgrade_apt:
  pkg.upgrade

install_common_packages:
  pkg.installed:
    - pkgs: