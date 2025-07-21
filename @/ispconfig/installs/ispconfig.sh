#!/bin/bash

apt update
apt upgrade

echo "Ansible install !!!"

apt install software-properties-common -y

add-apt-repository --yes --update ppa:ansible/ansible
apt install ansible -y

cd /etc/ansible/
ansible-galaxy install alchemiistcreative.ansible_ispconfig3_ubuntu20_04 -p ./roles/



echo "Ansible configure for ISPconfig !!!"

cd /etc/ansible

echo "[default]" >> ansible.cfg
echo "role_path=./roles/" >> ansible.cfg


touch role.yaml
echo "---" >> role.yaml
echo "- name: Install ISPconfig" >> role.yaml
echo "  hosts: localhost" >> role.yaml
echo "  become: yes" >> role.yaml
echo "  roles:" >> role.yaml
echo "          - role: alchemiistcreative.ansible_ispconfig3_ubuntu20_04" >> role.yaml

read -p 'country: ' country
read -p 'ISPconfig password: ' ispconfig_password
read -p 'Admin email: ' admin_email
read -p 'ssl_cert_country: ' ssl_cert_country
read -p 'ssl_cert_state: ' ssl_cert_state
read -p 'ssl_cert_locality: ' ssl_cert_locality
read -p 'ssl_cert_organisation: '  ssl_cert_organisation
read -p 'ssl_cert_organisation_unit: ' ssl_cert_organisation_unit
read -p 'ssl_cert_common_name: ' ssl_cert_common_name
read -p 'ispconfig_admin_password: ' ispconfig_admin_password
read -p 'ispconfig_mysql_ispconfig_password: ' ispconfig_mysql_ispconfig_password
read -p 'ispconfig_mysql_master_root_password: ' ispconfig_mysql_master_root_password
read -p 'user_mariadb_password: ' user_mariadb_password
read -p 'ispconfig_mysql_root_password: ' ispconfig_mysql_root_password

echo  "#### Country
country: BE
################# Mail subdomain name ########################
mail_fqdn: mail.example.com
####### User Creation: if true user is created ######
user_needed: true
user_ispconfig: admin_ispconfig
user_ispconfig_password: $ispconfig_password ## Should be vaulted
####### MariaDB Bind Address #########################
mysql_bind_address_bool: false
bind_address: 127.0.0.1
###
admin_email: $admin_email
## source list ###
repo:
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal-security multiverse"'"
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal-security universe"'"
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal-backports main restricted universe multiverse"'"
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal-updates multiverse"'"
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal multiverse"'"
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal-updates universe"'"
  - "'"deb http://{{country}}.archive.ubuntu.com/ubuntu focal universe"'"
#### hostname #####
ispconfig_hostname: "'"server1.example.com"'"
hostname_needed: false
####### Defaults #######
author: AlchemistCreative
##### Certificate #####
ssl_cert_country: $ssl_cert_country
ssl_cert_state: $ssl_cert_state
ssl_cert_locality: $ssl_cert_locality
ssl_cert_organisation: $ssl_cert_organisation
ssl_cert_organisation_unit: $ssl_cert_organisation_unit
ssl_cert_common_name: $ssl_cert_common_name
#### autoinstall ####
language: en
ispconfig_mysql_hostname: localhost
ispconfig_install_mode: standard
ispconfig_mysql_database: dbispconfig
ispconfig_mysql_port: 3306
ispconfig_mysql_charset: utf8
ispconfig_http_server: apache
ispconfig_ispconfig_port: 8080
ispconfig_ispconfig_use_ssl: y
ispconfig_admin_password: $ispconfig_admin_password ### Should be vaulted
ispconfig_mysql_ispconfig_user: ispconfig
ispconfig_mysql_ispconfig_password: $ispconfig_mysql_ispconfig_password ## Should be vaulted
ispconfig_join_multiserver_setup: n
ispconfig_mysql_root_user: root
ispconfig_mysql_master_database: dbispconfig
ispconfig_mysql_master_hostname: master.example.com
ispconfig_mysql_master_root_password: $ispconfig_mysql_master_root_password ## Should be vaulted
user_mariadb_password: $user_mariadb_password
ispconfig_mysql_root_password: $ispconfig_mysql_root_password
ignore_hostname_dns: y
ispconfig_postfix_ssl_symlink: y
ispconfig_pureftpd_ssl_symlink: y
create_ssl_server_certs: y
ispconfig_configure_mail: y
ispconfig_configure_jailkit: y
ispconfig_configure_ftp: y
ispconfig_configure_dns: y
ispconfig_configure_nginx: n
ispconfig_configure_apache: y
ispconfig_configure_firewall: y
ispconfig_configure_webserver: y
ispconfig_install_ispconfig_web_interface: y
ispconfig_reconfigure_permissions_in_master_database: no
ispconfig_reconfigure_services: yes
ispconfig_create_new_ispconfig_ssl_cert: no
ispconfig_do_backup: yes
ispconfig_reconfigure_crontab: yes" > roles/alchemiistcreative.ansible_ispconfig3_ubuntu20_04/defaults/main.yml




echo -e "---
###################################################### Create file .count_run ########################################
- name: Check if .count_run exist
  stat:
    path: "'"/root/.count_run"'"
  register: count_run_file

- name: Setup .count_run on first run
  block:
  - name: Create .count_run
    file:
      path: "'"/root/.count_run"'"
      state: touch
      owner: root
      group: root
      mode: 0644
  - name: Content
    lineinfile:
      path: "'"/root/.count_run"'"
      line: "'"0"'"
  when: not count_run_file.stat.exists

- name: Get Content
  command: "'"cat /root/.count_run"'"
  register: count_run_content

- name: "'"Counting"'"
  set_fact:
    counting: "'"{{ count_run_content.stdout|int + 1 }}"'"


- name: Incrementation count
  replace:
    path: "'"/root/.count_run"'"
    regexp: "'"{{ count_run_content.stdout|int }}"'"
    replace: "'"{{ counting }}"'"

- name: debug
  debug:
    msg: "'" Run counting: {{ counting }}"'"
############################################### Hostname ###############################

- name: Set hostname
  hostname:
    name: "'"{{ ispconfig_hostname }}"'"
  when: hostname_needed

############################################### User Creation and ssh keys deploiment ###############################
- name: User creation if needed
  block:
  - name:  "'"User creation {{ user_ispconfig }} "'"
    user:
      name: "'"{{ user_ispconfig }}"'"
      shell: /bin/bash
      groups: sudo
      append: yes
      password: "'"{{ user_ispconfig_password }}"'"

  when: user_needed

####################################################### Modify source.list ###########################################
- name: Add source repository into sources list
  apt_repository:
    repo: "'"{{ item }}"'"
    state: present
    update_cache: no
  with_items:
  - "'"{{repo}}"'"

############################################# Update/Upgrade and reboot if needed ####################################
- name: Update apt repo and cache
  apt:
    update_cache: yes
    force_apt_get: yes
    cache_valid_time: 3600

- name: Upgrades all packages
  apt:
    upgrade: dist
    force_apt_get: yes

- name: Check reboot-required files
  register: reboot_required_file
  stat:
    path: "'"/var/run/reboot-required"'"

- name: Reboot if needed
  reboot:
    msg: "'"Reboot from ansible"'"
    connect_timeout: 5
    reboot_timeout: 300
    pre_reboot_delay: 0
    post_reboot_delay: 30
    test_command: uptime
  when: reboot_required_file.stat.exists
##################################################### Disabling AppArmor ###############################################
- name: Check if AppArmor is present
  stat:
    path: "'"/etc/init.d/apparmor"'"
  register: service_apparmor_status

- name: Disable AppArmor if present
  block:
  - name: Stopping service AppArmor
    service:
      name: apparmor
      state: stopped

  - name: Disable service AppArmor
    service:
      name: apparmor
      enabled: false

  - name: remove package AppArmor
    apt:
      name: apparmor
      state: absent
      purge: true
  when: service_apparmor_status.stat.exists

##################################################### Installing NTP ###################################################

- name: Installing NTP
  apt:
    name: ntp
    state: present

##################################################### Bind DNS / haveged ###################################################

- name: Installing Bind DNS
  apt:
    name:
      - bind9
      - dnsutils
      - haveged
    state: present" > /etc/ansible/roles/alchemiistcreative.ansible_ispconfig3_ubuntu20_04/tasks/01-default_setup.yml





    echo -e "- name: Install packages (SpamAssassin_Amavisd-new_ClamAV and dependencies)
  apt:
    name:
      - amavisd-new
      - spamassassin
      - clamav
      - clamav-daemon
      - unzip
      - bzip2
      - arj
      - nomarch
      - lzop
      - cabextract
      - apt-listchanges
      - libnet-ldap-perl
      - libauthen-sasl-perl
      - clamav-docs
      - daemon
      - libio-string-perl
      - libio-socket-ssl-perl
      - libnet-ident-perl
      - zip
      - libnet-dns-perl
      - postgrey
      - jailkit
      - fail2ban
      - ufw
    state: present

  register: sec1_packages_install

- name: stop spamassassin and remove from updaterc
  systemd:
    name: spamassassin
    state: stopped
    enabled: false
- name: Debug clamav install
  debug:
    var: "'"{{ sec1_packages_install }}"'"

###### ClamAV

- name: Start ClamAV when packages changes
  block:
  - name: Run freshclam after packages installed
    command: freshclam
    register: freshclam_result
    ignore_errors: yes
  - name: Run clamav-daemon
    service:
      name: clamav-daemon
      state: started
  - name: Show freshclam_result
    debug:
      msg: "'"Error (ignore): {{ freshclam_result.stderr }}"'"
  when: counting == 1

  #- name: Start ClamAV when packages didnt change
  #  block:
          #  - name: Run freshclam after packages installed
          #    command: freshclam
          #    register: freshclam_result_
          #    failed_when:
          #      - freshclam_result_ is failed
          #      - freshclam_result_.stderr.find('locked by another process') != -1
          # - name: Run clamav-daemon
          #    service:
          #      name: clamav-daemon
          #      state: started
          # - name: Show freshclam_result_
          #  debug:
          #      msg: """"Error (no ignore): {{ freshclam_result_.stderr }}""""
          #  when: counting > 1

##### fail2ban

- name: Configure Fail2ban
  template:
    src: jail.local.j2
    dest: "'"/etc/fail2ban/jail.local"'"
  notify: restart fail2ban
" > /etc/ansible/roles/alchemiistcreative.ansible_ispconfig3_ubuntu20_04/tasks/06-security.yml


cd /etc/ansible/
ansible-playbook role.yaml
