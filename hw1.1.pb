#!/usr/bin/ansible-playbook

---
- name: homework 1.1
  hosts: webservers
  become: yes
  become_user: root

  tasks:

  - name: install httpd
    package: 
      name: 
        - httpd
      state: latest

  - name: keep folder /var/www/html/index.html
    file:
      dest: /var/www/html
      state: directory

  - name: create index.html
    copy:
      dest: /var/www/html/index.html
      content: |
        Welcome to my web server!
    notify: restart httpd


  - name: setup firewall
    firewalld:
      service: "{{item}}"
      state: enabled    
      permanent: yes
      immediate: yes
    with_items:
      - http
      - https


  handlers:

  - name: restart httpd
    service: 
      name:  httpd
      state: restarted
